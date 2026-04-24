# Kodi.log investigation — slow skin / widgets vs Velocity

**Log file:** `/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log`  
**Session:** 2026-04-23 ~18:34:17 – ~18:37+ (Kodi 21.3, Flatpak, `skin.velocity.af3` 3.2.6, `plugin.video.velocity2` 2.0.0)  
**Log snapshot (shell):** `wc -l` → **2933** lines (same capture; path is Kodi’s live `special://logpath`).

**Bottom line:** The captured log **does not** show the skin XML phase taking minutes. Kodi reports **~7 ms** to load the skin XML bundle. Most wall time in this capture is **Velocity’s Python plugin cold starts**, **seven concurrent Home `plugin://` listings**, and especially the **Velocity service daemon’s `tv_tracker` task**, which walks a **1530-show catalog** and logs **hundreds** of per-show “Fetching TV data” steps (remote work), overlapping the whole session.

Your suspicion that the **Velocity addon** dominates sluggishness **matches this log** more strongly than “the skin itself.”

---

## 1. Skin load time (from the log)

| Timestamp | Event |
|-----------|--------|
| `18:34:21.775` | `load skin from: .../skin.velocity.af3/` |
| `18:34:21.861` | **`Load Skin XML: 6.98 ms`** (Kodi’s own timing) |
| `18:34:21.909` | `skin loaded...` |

So **includes + initial window XML for this path ≈ 7 ms**. The skin is not the multi‑minute offender in this file.

Earlier work (splash, hub preload, many `plugin://` rows) can still affect *feel* on other setups; here Kodi explicitly measured skin XML load as negligible.

---

## 2. Home opens: seven Velocity directory jobs at once

At `18:34:22.035` (immediately after `Home.xml` init), Kodi queues **all** of these:

1. `plugin://plugin.video.velocity2/?action=list&list_id=home_spotlight_mixed&page=1`
2. `...&action=smart_list&type=active_shows`
3. `...&action=smart_list&type=in_progress_movies`
4. `...&action=smart_list&type=new_episodes`
5. `...&action=smart_list&type=continue_watching`
6. `...&action=smart_list&type=recently_watched`
7. `...&action=list&list_id=movies_spotlight_trending&page=1`

That pattern matches the skin’s **standard hub** widget XML (multiple `<content>` plugin URLs), including rows that may be **hidden** in the UI but still registered as `CDirectoryProvider` “refreshing”.

**Implication:** Even “local” SQL paths still pay **one Python subprocess / interpreter startup and addon bootstrap per job**, contending with each other and with **`service.py`** starting at the same time.

---

## 3. Timeline: plugin workers vs Velocity service / daemon

| Time | What happened |
|------|----------------|
| `22.037` | ScriptRunner job `1` → `home_spotlight_mixed` |
| `22.049` | Jobs `2`–`3` → first two `smart_list` |
| `22.056` | Multiple `CPythonInvoker ... main.py`: **start processing** |
| `22.084` | **`CServiceAddonManager: starting plugin.video.velocity2`** |
| `22.087` | `service.py` invoker starts |
| `22.596`–`22.738` | Each `main.py` worker reaches **“the source file to load”** (~0.5 s stagger) |
| `25.295` | **`CAddonSettings[0@plugin.video.velocity2]: trying to load setting definitions from old format...`** (first worker) |
| `25.359` | `Velocity: smart_list type=in_progress_movies item_count=1` |
| `25.360` | `Velocity: smart_list type=active_shows item_count=2` |
| `25.843` | Jobs `4`–`5` → `new_episodes`, `continue_watching` |
| `26.025` | **`Velocity 2.0 Pure Python Daemon started on http://127.0.0.1:65432`** |
| `26.334`–`26.916` | Remaining `smart_list` / `list` jobs complete (`item_count` logged) |
| `27.164` | **`onExecutionDone(0, ... main.py)`** for invoker `0` → **`home_spotlight_mixed` finished last** among the first batch |

**Takeaways**

- **~3.3 s** from first `smart_list` script start to `item_count` lines (`22.049` → `25.359`), dominated by **Python startup + addon settings migration** (“old format”), not by SQL row count (only a handful of items).
- **`home_spotlight_mixed`** is the **slowest first-wave job** (~**4.4 s** from interpreter load `22.738` to `onExecutionDone` `27.164`), overlapping daemon boot.
- The **HTTP daemon** comes online at **`26.025`**, *after* the first two smart lists already returned — those used the **SQLite `ClientRepo` fast path** as designed. Spotlight/list path still paid **cold start + settings + contention**.

---

## 4. Primary smoking gun: `tv_tracker` + large catalog (Velocity daemon)

On thread **`T:82`** (same invoker as `service.py` / asyncio daemon):

| Time | Log |
|------|-----|
| `18:34:27.037` | `Scheduler: Executing task 'tv_tracker'` |
| `18:34:27.696` | **`TV Tracker: Found 1530 TV shows in catalog`** |
| `18:34:27.696` | `TV Tracker: Found 3 user states` |
| Then continuously | **`TV Tracker: Fetching TV data for tv-… (TMDB: …)`** |

A grep over this log shows **473** lines matching `TV Tracker: Fetching` or `Updating episode data` — i.e. **hundreds of discrete fetch/update steps**, from **`18:34:27`** through at least **`18:37:05`** in the file (and still going), i.e. **on the order of ~2.5+ minutes of sustained background work** in the captured window.

The same thread also interleaves:

- `diff_engine: adding/removing … items` for genre lists  
- `Scheduler: Executing task 'diff_engine'`, `garbage_collector`, `tmdb_cache_purge` right after `tv_tracker` starts  

So the **Velocity daemon asyncio loop** is doing **heavy, sequential remote/catalog maintenance** immediately after startup, **while** Kodi is still opening hubs, decoding fanart (`ffmpeg` / `swscaler` warnings), and running **other** video addons’ services (e.g. **Umbrella** logs a large settings dump `18:34:23.7xx`–`25.xxx` overlapping the same period).

**This is the strongest log-backed explanation for “everything feels slow for 2+ minutes”** even though individual smart rails return small `item_count`s quickly: the **CPU, GIL, network, and SQLite** are contested by **long-running Velocity automation**, not by skin parsing.

---

## 4.1 Why the addon fetches hundreds of TMDb entries at startup (code + scheduler)

This section answers: *why does Velocity do this at all, and why right after Kodi starts?*

### A. What `tv_tracker` is for (product / behavior)

`run_tv_tracker` is the **“Predictive TV Show Tracker”**: it is supposed to **refresh catalog TV rows from TMDb** so episode / “next episode” metadata stays current when:

- the stored metadata has **no** `next_episode_air_date`, or  
- the next episode **air date has passed** (so the show may need updated `next_episode_to_air` / season data).

Docstring and loop logic (simplified):

```175:180:/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/plugin.video.velocity2/lib/daemon/automation/tracker.py
async def run_tv_tracker(api_key: str, bearer_token: str = '', app_context: Optional[Dict[str, Any]] = None) -> None:
    """
    Update episode data for active TV shows.
    
    For each active show, checks if the next episode air date has passed.
    If so, fetches updated TMDb data and updates the catalog.
```

It loads **every** `media` row with `media_type='tv'` (that is the **“Found 1530 TV shows in catalog”** line in the log), then **filters** with `_is_active_show` (status in a small allow-list, `last_updated` within **6 months**, etc.). For each remaining show that is not user-marked **completed**, it either:

1. **`TV Tracker: Fetching TV data for …`** — metadata has **no** `next_episode_air_date`; it calls **`await client.get_tv(tid)`** (and optionally **`get_season`** when settings allow) and persists items.  
2. **`TV Tracker: Updating episode data for …`** — there is a `next_episode_air_date` and it is **not** in the future (aired / stale path); again **`get_tv`**, and under conditions **`get_season`**, then persist.

So **hundreds of log lines** mean **hundreds of “active” shows** that still need a TMDb refresh under those rules — not that the log line “1530” implies 1530 HTTP calls; the **1530** count is **catalog scan size**, while **fetch/update** count is the **active** subset missing dates or past air logic.

There is also **rate limiting** (`asyncio.sleep(0.5)` between some updates), which stretches wall time when many shows qualify.

### B. Why the task runs **at startup** (scheduler + DB)

The daemon’s `AsyncScheduler` wakes every second, loads **due** rows from SQLite `task_state`, and runs any that match.

**Due rule** (`get_tasks_due`): a task runs if `last_run_at` is **NULL** **or** the time since `last_run_at` is **≥ `interval_seconds`**.

```51:63:/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/plugin.video.velocity2/lib/repo/tasks.py
def get_tasks_due(conn: sqlite3.Connection, enabled_only: bool = True) -> list[dict]:
    sql = """
    SELECT * FROM task_state
    WHERE (last_run_at IS NULL
           OR (CAST(strftime('%s', 'now') AS INTEGER) - CAST(strftime('%s', last_run_at) AS INTEGER)
               >= interval_seconds))
      AND status != 'running'
    """
```

On each Kodi start, `start_scheduler` **registers** `tv_tracker` with **`upsert_task`**. That uses **`INSERT OR REPLACE`** and only supplies **`task_id`, `coro_func`, `interval_seconds`, `enabled`, `status`** — it does **not** supply `last_run_at`:

```16:24:/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/plugin.video.velocity2/lib/repo/tasks.py
        conn.execute(
            """
            INSERT OR REPLACE INTO task_state(
                task_id, coro_func, interval_seconds, enabled, status
            ) VALUES (?, ?, ?, ?, ?)
            """,
            (task_id, coro_func, interval_seconds, enabled, status),
        )
```

In SQLite, **`INSERT OR REPLACE` replaces the whole row**; columns omitted from the `INSERT` are set to **NULL** (there is no default on `last_run_at` in the schema). So **every service start tends to reset `last_run_at` to NULL** for that row.

**Effect:** `get_tasks_due` almost always treats **`tv_tracker` as due immediately** on the next scheduler loop (after the initial `await asyncio.sleep(1)` in `_run_loop`), **not** “only every 12 hours.” The **nominal** interval is still **43200 s (12 h)** in `register_task`, but **first run after each Kodi session** is effectively “as soon as the daemon is up” because **`last_run_at` was cleared**.

```238:243:/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/plugin.video.velocity2/lib/daemon/automation/scheduler.py
    scheduler.register_task(
        task_id='tv_tracker',
        interval_seconds=43200,
        coro_func=functools.partial(run_tv_tracker, key, bear, app),
        enabled=cfg.get_enable_tv_tracker(),
    )
```

After a run completes, the scheduler sets `last_run_at` (`set_task_last_run` in `scheduler._execute_task`), so **within a single long-lived Kodi process** the 12 h spacing applies — but **the next full Kodi restart** goes through **`upsert_task` again** and the pattern repeats.

### C. Summary table

| Question | Answer |
|----------|--------|
| **Why fetch TMDb at all?** | By design: keep **active** TV catalog metadata / next-episode info aligned with TMDb (`run_tv_tracker`). |
| **Why so many lines?** | Many catalog TV rows are still “active” and lack `next_episode_air_date` or need post-airdate refresh → **`get_tv`** (and sometimes **`get_season`**) per show + sleeps. |
| **Why right at startup?** | Scheduler runs any task with **`last_run_at IS NULL`**; **`upsert_task` on each boot clears `last_run_at`**, so **`tv_tracker` is due immediately** after the daemon starts. |

**Fix direction (addon, not skin):** preserve `last_run_at` across registration (e.g. `INSERT ... ON CONFLICT(task_id) DO UPDATE` updating only changed columns, or read-merge-write), or defer the first `tv_tracker` pass until idle / explicit user action.

---

## 5. Other contributors visible in the log (secondary)

| Factor | Evidence |
|--------|-----------|
| **Parallel Python jobs** | Up to **three** `main.py` invokers + `service.py` + later invokers `9`–`12` serially for remaining lists |
| **Addon settings** | Repeated **`trying to load setting definitions from old format`** on each new interpreter |
| **Other addons** | `plugin.video.umbrella` service spam + **cocoscrapers** during same seconds |
| **Texture / UI** | Multiple **`[swscaler] No accelerated colorspace conversion`** while fanart-style images decode |
| **Peripheral noise** | Recurring **`peripheral.xarcade: Failed to open event devices`** (unrelated but noisy) |

---

## 6. Does this log support “metadata and artwork are local, so it should be instant”?

**Partially contradicted by the log itself:**

- Widget **data** for smart rails is tiny (`item_count` 0–3 in this run) and returns in a few seconds after cold start.
- **`tv_tracker`** messages explicitly say **“Fetching TV data”** with **TMDB ids** — that is **not** “everything is local” behavior for that subsystem.
- ListItem **art** may still be remote URLs from TMDb paths (separate from this log’s lack of CURL lines); the log does show **ffmpeg** busywork consistent with **image decode** load.

---

## 7. Recommendations (ordered by impact / log relevance)

1. **Velocity daemon: `tv_tracker` (and possibly `diff_engine`)**  
   - **Highest leverage:** fix **`upsert_task` / `INSERT OR REPLACE`** so **`last_run_at` is not nulled** on every `service.py` start (see §4.1); that alone stops “full tracker run every boot.”  
   - Throttle, batch, or **defer first run** after Kodi start (e.g. wait until idle or user opens Velocity).  
   - Narrow work: skip shows that already have fresh `next_episode_air_date` and no need for `get_tv`, or cap shows per run.  
   - Consider moving long HTTP/TMDb loops off the critical asyncio path so the aiohttp server stays responsive.

2. **Plugin `main.py` cold start**  
   - Lazy-import heavy modules inside handlers.  
   - Migrate **`settings.xml` to current format** to drop “old format” migration work on **every** new `LanguageInvoker`.

3. **Skin / product**  
   - Reduce **concurrent** `plugin://` `<content>` targets on Home (omit hidden rails’ `content` until visible, or use a single combined endpoint). That cuts parallel Python startups.

4. **A/B test**  
   - Temporarily **disable** Velocity service or `tv_tracker` in settings (if exposed) and re-capture `kodi.log` for comparison.

---

## 8. Log citations (representative lines)

Skin timing:

```698:718:/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log
2026-04-23 18:34:21.861 T:7       debug <general>: Load Skin XML: 6.98 ms
...
2026-04-23 18:34:21.909 T:7        info <general>:   skin loaded...
```

Seven Velocity providers + service start:

```771:803:/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log
2026-04-23 18:34:22.035 T:7       debug <general>: CDirectoryProvider[plugin://plugin.video.velocity2/?action=list&list_id=home_spotlight_mixed&page=1]: refreshing..
...
2026-04-23 18:34:22.084 T:7       debug <general>: CServiceAddonManager: starting plugin.video.velocity2
2026-04-23 18:34:22.087 T:82      debug <general>: CPythonInvoker(5, .../service.py): start processing
```

Daemon online + `tv_tracker` + 1530 shows:

```1244:1401:/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log
2026-04-23 18:34:26.025 T:82       info <general>: Velocity 2.0 Pure Python Daemon started on http://127.0.0.1:65432
...
2026-04-23 18:34:27.037 T:82       info <general>: Velocity lib.daemon.automation.scheduler: Scheduler: Executing task 'tv_tracker'
...
2026-04-23 18:34:27.696 T:82       info <general>: Velocity lib.daemon.automation.tracker: TV Tracker: Found 1530 TV shows in catalog
2026-04-23 18:34:27.696 T:82       info <general>: Velocity lib.daemon.automation.tracker: TV Tracker: Fetching TV data for tv-10000 (TMDB: 10000)
```

---

## 9. Conclusion

For this `kodi.log`:

| Claim | Verdict |
|--------|---------|
| “Skin load > 2 minutes” | **Not supported** — Kodi logged **~7 ms** skin XML load; total boot includes addons/GUI init. |
| “Widgets extremely slow” | **Partially** — first wave is **seconds** of **parallel Python + settings + last list ~4s**; **minutes of sluggishness** align with **Velocity `tv_tracker`** hammering **1530** catalog entries with **hundreds of fetch/update logs** on the **service** thread, plus other addons. |
| “Comes from Velocity, not skin” | **Largely yes** for sustained load; **skin still chooses** 7 concurrent plugin URLs on Home. |

Further engineering should treat **`lib.daemon.automation.tracker` / `tv_tracker` scheduling** and **Home plugin concurrency** as first-class performance surfaces.
