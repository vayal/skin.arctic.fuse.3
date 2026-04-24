# Screen-by-Screen Build Contract (Skin + Addon)

Derived from [`../archive/skin-vision-blueprint-v0.md`](../archive/skin-vision-blueprint-v0.md) (historical) and repo inventory. This file is the **target**, **status**, and **open work** index — not a changelog.

*Navigation note:* Older roadmap text may cite “§1”, “§2”, “§7”, or “§8” of this file. **§1 / global rules** → **Target** (global UX rules). **§2.1–2.3** main hub details → **Target** (main hub row contracts) + **Current status** table. **§7 / §8** (status + long plan) → **Current status** and **Remaining implementation plan**.

---

## Target

**Purpose:** Turn the skin vision into a buildable contract: what each surface renders, which Velocity addon `list_id` (or action) powers each row, and what to remove or simplify in legacy skin code.

**Architecture**

- **Main hubs:** `Home`, `Series` (1101), `Movies` (1102). Primary wiring: `Home.xml`, `Custom_1101_Hub.xml`, `Custom_1102_Hub.xml`, `Includes_Hubs.xml`, `Includes_Home.xml`.
- **Provider mini-hubs (curated):** One logical surface per provider in the agreed roster (Netflix, Disney+, Prime Video, Apple TV+, Hulu, Max, Paramount+, Peacock, BBC iPlayer) — see §2.4 in spirit; dedicated skin windows TBD.
- **Search / discovery:** `Custom_1105_Search.xml`, `Includes_Search.xml`, generator under `shortcuts/generator/…`.

**Global UX rules (all hubs)**

| Rule | |
|------|---|
| Spotlight | Hero, near full-screen, **single** item, info-first; **non-paginated** (no next-page). |
| Row cards | **Image-only** (poster / landscape / square) — no metadata overlays on cards. |
| Row density | Baseline `balanced`. |
| Paging | In-row **≤10** → row-end “next” → row title / header opens **full** list; full list **40 items per page** (not a total cap). |
| Empty | Explicit **“No items available”** (or product string) via shared empty/now-results patterns. |

**Main hub row contracts (feeds + layout)**

| Hub | Order | Row | Card / layout | Addon contract (`list_id` or family) | Pag. |
|-----|------:|-----|---------------|----------------------------------------|:----:|
| **Home** | 1 | Spotlight | Hero | `home_spotlight_mixed` | No |
| | 2a / 2b | In-progress Series / Movies | Poster | `home_in_progress_series` / `home_in_progress_movies` | Yes |
| **Series** | 1 | Spotlight | Hero | `series_spotlight_trending` | No |
| | 2 | Continue watching | Landscape | `series_continue_watching_episodes` | Yes |
| | 3 | In-progress shows | Poster | `series_in_progress_shows` | Yes |
| | 4 | Global trending | Poster | `series_global_trending` | Yes |
| | 5 | Provider icons | Square | `series_provider_icons` | No |
| | 6 | Genre | Square strip / navigation to discover | `series_genre_navigation` → `genre_global_{slug}` (`media_type=show`) | Yes |
| **Movies** | 1 | Spotlight | Hero | `movies_spotlight_trending` | No |
| | 2 | In progress | Poster | `movies_in_progress` | Yes |
| | 3 | Global trending | Poster | `movies_global_trending` | Yes |
| | 4 | Provider icons | Square | `movies_provider_icons` | No |
| | 5 | Genre | Square strip / navigation to discover | `movies_genre_navigation` → `genre_global_{slug}` (`media_type=movie`) | Yes |

**Provider mini-hub (per provider) — target rows:** `provider_{id}_spotlight` (No), `provider_{id}_trending` / `popular` / `genre_{genre}` (Yes). **Skin:** to be wired to dedicated mini-hub surface(s). **Addon:** `phase02_contracts` family exists; integration TBD.

**Search (§2.5):** Tab set Discover / Movies / TV; combined movie+series mode supported; trim aliases to what product uses; generator/search paths should not pull dead music rows.

**Details / context / OSD — direction:** Full-screen details as canonical “Info”; lean rails (no Wikipedia / heavy cast dependency); context menu **curated**; remove playlist OSD, cast OSD, PVR in fork, OSD next-recommendation per contract. **Files:** `DialogVideoInfo.xml`, `Includes_DialogInfo.xml`, `Dialog_DialogContextMenu.xml`, `Includes_OSD.xml`, etc.

**Remove / simplify (high level):** Home submenu static strip; NextAired as primary home rail; user-facing shortcut editor; PVR entry points; OSD 1140/1141/1143 per §4.1; search alias trim; `TMDbHelper` / legacy property retirement where feasible (D-038).

**Addon packages (execution buckets):** (1) spotlights, (2) progress/continue, (3) discovery/trending/provider, (4) genre family, (5) paging contract, (6) normalized details/list payloads.

**Freeze / docs (placeholders):** D-003 display mode matrix, D-021 context keep/remove, D-038 legacy exceptions, D-045 freeze checklist, dedicated linked addon work doc.

---

## SkinVariables generator (required workflow)

`1080i/script-skinvariables-generator-includes.xml` is **generated output**. Edits to hub widget rows that must survive regen go through **`shortcuts/skinvariables-generator.json`**, **`shortcuts/generator/data/…`**, shortcut JSONs (e.g. `shortcuts/skinvariables-shortcut-1101widgets.json`), then regenerate and commit **sources + output** together.

---

## Current status (workspace)

Legend: **Yes** = matches contract; **Partial** = incomplete, alternate path, or not fully verified; **No** = missing or contrary to target.

| Area | Item | Status | Notes (factual) |
|------|------|--------|-----------------|
| **§1 Global** | Main hubs 1100 / 1101 / 1102 | Yes | `Home.xml`, `Custom_1101/1102_Hub.xml`, `Includes_Hubs.xml` |
| | Provider mini-hubs as dedicated skin surfaces | Partial | Addon: `PROVIDER_ORDER`, `provider_*_*` resolvers. Skin: no per-provider hub windows; rails report lists “not used” on skin |
| | Spotlight hero + non-paginated spotlight | Partial / Yes | Layout audit Partial; addon non-paginated spotlight + caps Yes |
| | Image-only row cards | Partial | Not all rows/layouts audited |
| | `balanced` density | Partial | Not all rows verified |
| | Paging: 10 / next / header / 40 | Partial | Addon `full_page_size=40`; skin `browse` via `Defs_BrowseLimitedLists`; cap-10 not enforced in XML alone |
| | Empty state copy / behavior | Partial | Patterns exist; not every row verified |
| | Startup / splash dismiss safety | Yes | `SplashTimeOut`, `Home.xml` alarm split (no `ClearProperty`+comma in one `AlarmClock`) |
| | 1101/1102 widget info (combined + wall) | Yes | `Hub_Combined_Info` / `Hub_Wall_Info` for 1101 **501–505**, 1102 **501–504**; shortcut JSONs for regen |
| **§2.1 Home** | `home_spotlight_mixed` | Yes | |
| | `home_in_progress_series` / `…_movies` (D-015 URLs on Home) | Partial | Lists exist; Home **501/502** still `smart_list&type=…` in generated home widgets |
| **§2.2 Series** | `series_spotlight_trending` | Yes | |
| | `series_continue_watching_episodes` (landscape 501) | Yes | |
| | `series_in_progress_shows`, `series_global_trending` | Yes | Rows 502, 503 |
| | `series_provider_icons` | Yes | Row 504, square |
| | Genre navigation (fixed set → `genre_global_*`) | Yes | Row 505, `list_link` strip; not separate `List_Button_Row` |
| **§2.3 Movies** | `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending` | Yes | |
| | `movies_provider_icons` | Yes | Row 503, square |
| | Genre navigation | Yes | Row 504 |
| **§2.4** | `provider_{id}_*` rows on mini-hub surface | Partial | Resolver-side exists; **skin** mini-hubs not built |
| **§2.5 Search** | Tabs: Discover, Movies, TV only | Partial | |
| | Combined search mode | Yes | |
| | Alias trim (no music cruft in product) | Partial | Generator search fragments may still include music paths |
| **§3** | Full details (not small-only info) | Partial | |
| | Lean details, curated context | Partial | D-021 open |
| | OSD baseline controls | Yes | |
| | Remove 1140 playlist OSD | **No** | File + routes may remain |
| | Remove 1141 cast / 1143 next / PVR | Partial | Mixed removal state |
| **§4** | Home static submenu / NextAired / shortcut editor / 1140 / PVR / details trim | No–Partial | See target remove list; many items open |
| **§5 Add-on** | Pkg 1 spotlights (incl. provider on skin) | Partial | Home/Series/Movies ok; `provider_*_spotlight` not skin-wired |
| | Pkg 2 progress (incl. Home D-015) | Partial | 1101 continue ok; **Home** URL parity open |
| | Pkg 3–4 discover / provider / genre (main hubs) | Yes | |
| | Pkg 5 paging UX | Partial | |
| | Pkg 6 details payload matrix | Partial | |
| **§6** | D-003, D-021, D-038, D-045, addon work doc | **No** | |

---

## Remaining implementation plan (check now)

### Home hub — URL parity (D-015)

- [ ] Generator / `getnfo`: **501** `?action=list&list_id=home_in_progress_series&page=1` (replace `smart_list&type=active_shows`); regen `script-skinvariables-generator-includes.xml`
- [ ] Same for **502** → `home_in_progress_movies` (replace `smart_list&type=in_progress_movies`); regen
- [ ] Reconcile product copy (tabs vs two visible rows) with `Includes_Home` if needed
- [ ] QA: `Hub_Onload` / `Velocity.WidgetContainer`, pagination, `Widget_NoResults`, focus

### Main hubs — product hardening (§1, §5 pkg 5)

- [ ] **In-row cap 10:** enforce in addon first page and/or `limit` on row `<content>` — document single source of truth
- [ ] **Row-end next + header full list:** same `list_id` with `page=`; confirm header onclick and `browse` mode
- [ ] **Image-only + balanced:** audit `List_*_Row` / layout includes; strip overlays where contract says image-only
- [ ] **Empty copy:** one shared string for “No items available” (or product string) on all contract rows
- [ ] D-003: lock Standard / Combined / Wall per hub family where required

### Provider icon rows — deep links to mini-hubs (§2.2–2.3, toward §2.4)

- [ ] Confirm each `series_provider_icons` / `movies_provider_icons` item exposes stable `ActivateWindow`-compatible path
- [ ] `Widget_NoResults` / empty for icon strip

### Provider mini-hubs (§2.4) — skin + bootstrap

- [ ] Decide: one parameterized shell (e.g. 1103) vs multiple windows; record in D-003
- [ ] Skin: spotlight + trending + popular + genre rows per provider
- [ ] `Startup` / `skinvariables-startup` / `HomeSwitcher`: per-provider slug spotlight paths
- [ ] Back navigation to parent Series/Movies hub
- [ ] Update `velocity-addon-list-rails-report.md` when wired

### Genre (main hub) — spec vs shipped

- [ ] Shipped: square **`list_link`** strip after contract; if product insists on `List_Button_Row`, add generator fragment or document deviation in D-003
- [ ] Document canonical `list_id` / action per genre in [d015-addon-required-lists-contract.md](./d015-addon-required-lists-contract.md) or appendix

### Search (§2.5, §4.3)

- [ ] Tab inventory: only Discover, Movies, TV reachable
- [ ] Remove music / unused search **content** from `search_path.xml` and shortcut JSON; **regen** (see **SkinVariables generator** above)
- [ ] Document combined as default

### OSD & playback (§3.3, §4.1) — I-track

- [ ] Remove **1140** playlist OSD: file + `ActivateWindow(1140)` / actions in `Includes_Actions`, seekbar, expressions
- [ ] Remove all **1141** references; confirm no required XML
- [ ] **1143** next overlay: remove or hard-disable
- [ ] Pause overlay + “first Info → light overlay, second → full details” behavior — align `Custom_1193`, `Includes_OSD`

### PVR removal (J-track)

- [ ] Map entry points (`Home`, `Settings`, `tvchannels`, PVR dialogs); remove or block user-visible paths
- [ ] `Includes.xml` PVR includes: policy (delete vs unreachable stub)
- [ ] Document fork policy in D-045

### Submenu & shortcut editor (K-track)

- [ ] Remove or hide `skinvariables-homesubmenu-staticitems` from `Includes_Home` (+ generator `home_submenu.xml`)
- [ ] Remove `ActivateWindow(1115)` from user settings or gate to dev-only; document if internal editor remains

### Details & context (L-track)

- [ ] D-021: keep/remove table for `Dialog_DialogContextMenu` → apply
- [ ] Details lean pass: `Includes_DialogInfo` / `DialogVideoInfo` per §3.1
- [ ] D-038: `TMDbHelper` / legacy properties grep + exception list in code or doc

### NextAired, NextAired on home

- [ ] Contract: not on Home main rail; confirm `Home.xml` / `Includes_NextAired` usage; trim if still user-visible in wrong place

### Addon + docs (M-track)

- [ ] Details **payload matrix** (ListItem fields) vs `normalize_item_for_skin` / list builders; fix gaps
- [ ] **Dedicated addon work** doc; link from [doc/README.md](../README.md) or this file
- [ ] **D-045** freeze checklist wording and trigger
- [ ] D-003 / D-021 / D-038 / D-045 as formal close-out tasks

### Every skin hub change — verification

- [ ] Menu **Down** → spotlight **310** when spotlight has items and is configured
- [ ] Spotlight **Down** → first widget; **Up** back
- [ ] `Window(Home).Property(Velocity.WidgetContainer)` matches row for info/fanart
- [ ] Empty list: explicit empty UI, poster/icon fallbacks
- [ ] `xmllint` / skin reload; `pytest` if addon handlers change
- [ ] If widget XML: **shortcuts/ generator sources updated** + regen; output committed (see top **SkinVariables** section)

---

## Reference (file index — not exhaustive)

| Concern | Typical files |
|--------|----------------|
| Hubs / widgets | `1080i/Includes_Hubs.xml`, `Includes_Home.xml`, `Includes_Widgets.xml`, `Includes_Lists.xml`, `Includes_Layouts.xml` |
| Generated includes | `1080i/script-skinvariables-generator-includes.xml` (output) |
| Generator inputs | `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/`, `shortcuts/skinvariables-shortcut-*.json` |
| Startup / spotlight | `1080i/Startup.xml`, `shortcuts/skinvariables-splash.json`, `shortcuts/skinvariables-startup.json` |
| Search | `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`, `shortcuts/generator/data/setup/search_path.xml` |
| Addon contracts | `plugin.video.velocity2` — `lib/daemon/phase02_contracts.py`, `lib/client/handlers/lists.py`, `lib/client/builder.py` |

---

*End of document.*
