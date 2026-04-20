# Arctic Fuse 3 fork + Velocity integration — detailed roadmap

**Purpose:** Personal-use skin fork (`plugin.video.velocity2` as the only content provider) with explicit control over widgets, spotlight, detail density, and layout — without maintaining TMDbHelper-style compatibility unless you choose to.

**Audience:** You (or a future maintainer) executing work in ordered phases.

**Companion (read first for agents):** Full addon contract — plugin actions, HTTP routes, `ListItem` behavior: [`velocity-addon-reference-for-skin-forks.md`](velocity-addon-reference-for-skin-forks.md).

**Implementation instructions (read before coding):** [`phase1-implementation-instructions.md`](phase1-implementation-instructions.md).

**Related repo state:** Velocity exposes list/smart routes via HTTP (`lib/daemon/api/`) and Kodi plugin actions (`lib/client/handlers/dispatch.py`). List pagination is implemented as a real directory item (`Next Page >>`) in `lib/client/handlers/lists.py` + `lib/client/builder.py::build_next_page_item`. Smart rails return `next_page: null` (`lib/daemon/api/routes_smart.py`).

---

## Principles

1. **Skin owns layout and chrome** (button sizes, multi-row, poster vs landscape vs square). The addon owns **data contracts** (URLs, `ListItem` metadata, optional pagination).
2. **Separate modes explicitly** — e.g. “widget feed” vs “spotlight feed” vs “full browse” — so one global setting does not leak into another surface (your “Next Page in spotlight” issue).
3. **Centralize skin entry points** — wrapper includes / variables so you change routing once, not in every XML file.
4. **Keep upstream merge pain bounded** — isolate your changes in `skin/velocity/` (or similarly named) includes and avoid editing upstream core files unless necessary.

---

## Phase 0 — Baseline, fork hygiene, and inventory

**Goal:** A safe fork you can version, diff, and rebase; and a complete inventory of what the skin and addon must agree on.

### Work items

- [x] **Choose AF3 version** and tag it in git (e.g. `baseline-af3-x.y.z`). *(status: complete; AF3 `3.2.6` selected and baseline tag created: `baseline-af3-3.2.6`)*
- [x] **Rename** the addon id in `addon.xml` if you maintain a skin fork as a separate addon (e.g. `skin.velocity.af3` or keep upstream id — see risks below). *(status: complete; renamed to `skin.velocity.af3`)*
- [x] **Document** license and upstream attribution (GPL-3.0+ for many skins; respect original author credits). *(status: complete; see [`doc/license-and-upstream-attribution.md`](license-and-upstream-attribution.md))*
- [x] **Inventory Velocity paths** used today. *(status: complete)*
  - Plugin actions: see `lib/client/handlers/dispatch.py` (`home`, `list`, `smart_list`, `view_show`, `view_season`, `discovery`, `search_hub`, `execute_search`, `play`/`select`, etc.).
  - HTTP API: `lib/daemon/api/routes_list.py`, `routes_smart.py`, `routes_media.py`, `routes_discovery.py`, `routes_search.py`.
- [x] **Inventory skin** references to: *(status: complete)*
  - `plugin.video.themoviedb.helper`, `script.extendedinfo`, other helpers.
  - Hardcoded `plugin://` paths, `RunScript`, `ActivateWindow`, spotlight/widget definitions.
- [x] **Create a single “contract” table** (spreadsheet or section in this doc): *Skin feature → Velocity URL/action → Notes*. *(status: complete; see [`doc/phase0-contract-table.md`](phase0-contract-table.md))*

### Phase 0 contract table (first pass)

Moved to dedicated file: [`doc/phase0-contract-table.md`](phase0-contract-table.md).

### Acceptance criteria

- You can list every user-visible surface (home, widgets, spotlight, info, OSD) and which Velocity path backs it.
- Fork builds/installs in Kodi without errors.

### Risks / notes

- Changing the **skin addon id** affects `special://skin/` paths and saved skin settings; document migration if you rename.

---

## Phase 1 — Strip unwanted dependencies and dead surfaces

**Goal:** Remove or stub everything you will never use so maintenance and regressions shrink.

### Work items

- [ ] Remove/disable **TMDbHelper / ExtendedInfo** includes and menu entries that point to them.
- [ ] Remove **unused** AF3 hubs, demo widgets, or upstream “recommended” paths you do not use.
- [ ] Replace scattered `plugin://` strings with **wrapper includes** (e.g. `Includes_Velocity_Paths.xml` or similar) defining:
  - `Velocity.Home`
  - `Velocity.List(list_id)`
  - `Velocity.SmartList(type)`
  - `Velocity.ViewShow(id)` / `Velocity.ViewSeason(show_id, season)`
- [ ] **Optional:** Add a build-time check (simple script or grep in CI) that fails if forbidden helper addon ids appear in XML.

### Acceptance criteria

- Grep for legacy helper ids returns **zero** matches in active skin XML (or only in clearly marked optional legacy files).
- All active Velocity entry points resolve through one wrapper layer.

---

## Phase 2 — Contract: pagination, spotlight vs widget vs browse

**Goal:** Fix the class of bugs where **one global behavior** (e.g. “show Next Page”) applies to both widgets and spotlight.

### Problem statement (from your experience)

Velocity today appends a **directory item** `Next Page >>` whenever the list API returns `next_page` — see `lib/client/handlers/lists.py`. That is correct for **full list browsing** but wrong if the **same path** is reused for spotlight or hero strips that should only show the first page (or a fixed N items).

### Work items (addon)

- [ ] **Define query parameters** (names are illustrative — pick and document one set):
  - `paginate=true|false` — when `false`, never append `Next Page >>` even if more items exist server-side (or cap server-side page size to N).
  - Optional: `source=widget|spotlight|browse` for logging and skin-side debugging.
- [ ] **Thread `paginate` through:**
  - `Router.parse_args` already supports `paginate` → boolean (`lib/client/router.py`).
  - `handle_list` must pass `paginate` into repo read and/or HTTP `get_json` for `/api/lists/{id}`.
  - **Daemon:** `get_list_handler` in `lib/daemon/api/routes_list.py` currently always computes `next_page` from full item count vs `page_limit`. Add behavior: if `paginate=false`, return `next_page: null` and optionally slice to `limit` without implying more pages.
- [ ] **Unit/integration tests:** list handler respects `paginate=false` (no next page item in client tests; API returns `next_page: null`).

### Work items (skin)

- [ ] **Widget paths** use `paginate=true` (or default) when you want Next Page in that container.
- [ ] **Spotlight paths** use `paginate=false` and a fixed `limit` aligned with spotlight count (often 5–20 items).
- [ ] Document in skin settings: “Spotlight uses non-paginated feed.”

### Acceptance criteria

- With identical `list_id`, spotlight never shows `Next Page >>`; widget row can still show it when you want pagination.
- No regression: full browse from `action=list` still paginates when `paginate=true`.

### Files likely touched (Velocity)

- `lib/client/handlers/lists.py`
- `lib/client/router.py` (if list fetch path needs `paginate` in query string)
- `lib/daemon/api/routes_list.py`
- `lib/client/repo/*` if `ClientRepo.get_list` mirrors API pagination
- Tests under `tests/client/` and `tests/` for daemon routes

---

## Phase 3 — Spotlight: layout, button size, customization

**Goal:** Spotlight buttons are **skin-controlled**; you need first-class settings and layout variables.

### Reality check

Button dimensions, fonts, and control templates are **Arctic Fuse XML** (Estuary-based skinning). The addon does not set button pixel sizes. Your fix belongs primarily in **skin XML + skin settings**.

### Work items

- [ ] Identify AF3 files defining **spotlight / hero / featured** controls (names vary by version).
- [ ] Introduce **skin settings** (bool/enum) for:
  - Button size preset: `compact | normal | large` (maps to width/height/font).
  - Optional: numeric overrides (advanced).
  - Label visibility: show subtitle / year / rating on/off.
- [ ] Refactor spotlight layout to use **dimension variables**:
  - `Skin.String(Velocity.Spotlight.ButtonWidth)` etc., or AF3’s existing pattern if present.
- [ ] Ensure spotlight uses **non-paginated** Velocity path (Phase 2).
- [ ] **Visual QA** at 1080p and 4K; check text truncation and focus.

### Acceptance criteria

- You can change spotlight button size from skin settings without editing core includes.
- Spotlight does not show pagination artifacts (Phase 2).

---

## Phase 4 — Movie / TV information density

**Goal:** Reduce “wall of cast/crew” and metadata clutter on detail views.

### Where complexity comes from

- **Skin:** AF3 info panels often aggregate cast, studio, genres, etc. from `ListItem` info and/or custom dialogs.
- **Addon:** `lib/client/builder.py::build_list_item` sets a fixed subset of `video` info from `metadata` (title, plot, year, rating, etc.). It does **not** currently push full cast arrays into `setInfo` in the snippet reviewed — but `metadata` JSON from DB/TMDb may still contain large arrays that **skins or scripts** might display if bound.

### Work items

- [ ] **Skin:** Simplify detail layouts:
  - Hide or collapse cast row; “Show cast” expandable section.
  - Reduce number of visible genre tags; show primary only.
- [ ] **Addon (optional but powerful):** add **`info_density`** mode:
  - `minimal`: title, year, plot (trimmed), rating, runtime if available; strip or ignore heavy arrays before any skin binding.
  - `standard`: current behavior.
  - `full`: future-proof for power users.
- [ ] **Daemon/API:** if detail JSON endpoints expose huge cast lists, add `fields=` or `max_cast=` query params for detail views used by skin (only if you add custom info windows fed by API).

### Acceptance criteria

- Detail view matches your mental model: **minimal by default**, optional expansion.
- No performance regression opening info on low-end devices.

---

## Phase 5 — Multi-row widgets + per-widget display shape (poster / landscape / square)

**Goal:** Each widget independently chooses **rows** and **art aspect** without one global skin setting.

### Work items (skin — primary)

- [ ] For each home/widget container, define **template parameters**:
  - `aspect`: `poster | landscape | square` (maps to which art key is preferred: `poster`, `landscape`, `thumb`).
  - `rows`: integer (1–3 typical).
  - `item_limit`: integer (how many items to request from path).
- [ ] Map templates to AF3 widget types / panel layouts (depends on AF3 version — may use includes, `widgetGroup`, or custom `list` layout).
- [ ] Ensure **focus** and **scroll** behavior works for multi-row (test D-pad and mouse).

### Work items (addon — supporting)

- [ ] **Art fallbacks** already exist in `build_list_item` (poster → thumb; landscape → fanart). Extend or document rules:
  - For square: prefer `thumb` or square-cropped art if you add it later.
- [ ] **Optional:** `ListItem` properties for skin:
  - `Velocity.ArtMode=poster|landscape|square` set from widget URL param so one list can hint layout (skin reads `ListItem.Property`).

### Latency note

- Local DB reads should be fast; remaining latency is often **image decode** + **skin layout**. Use:
  - smaller `page_limit` for widgets,
  - `enrich` modes on daemon lists when applicable (`routes_list.py` supports `enrich=none|limited|full`).

### Acceptance criteria

- Two widgets side-by-side can use different aspects and row counts.
- No duplicated Velocity list definitions — only URL/query params differ.

---

## Phase 6 — Settings, documentation, and merge strategy

**Goal:** You can change behavior without spelunking XML every time.

### Work items

- [ ] **Skin settings.xml:** group Velocity-related options (spotlight size, default info density, default widget aspect).
- [ ] **Velocity settings** (`resources/settings.xml`): if you add `info_density` or default `paginate` policy, document defaults.
- [ ] **Changelog** in fork repo: per-release notes when rebasing upstream AF3.
- [ ] **Rebase playbook:** steps to merge upstream AF3 tag into your fork (conflict-prone files called out).

### Acceptance criteria

- Another person (or future you) can install skin + addon and configure behavior from settings + this doc.

---

## Phase 7 — Verification matrix (before “daily driver”)

**Goal:** Formal regression checklist.

### Functional

- [ ] Home loads: pinned lists, smart rails, hubs (as you keep them).
- [ ] Widget: pagination on/off behaves as configured.
- [ ] Spotlight: no pagination; correct item cap; buttons sized per settings.
- [ ] Play: `play` vs `select` per Velocity settings (`default_play_action`).
- [ ] TV hierarchy: show → season → episode.
- [ ] Search hub + execute search.
- [ ] Watch state toggles and context menus still reachable where you care.

### Visual/UX

- [ ] 1080p / 4K spot checks.
- [ ] Light/dark themes if you use them.

### Performance

- [ ] Cold start vs warm: acceptable on target hardware.
- [ ] Widgets: no pathological reload loops (watch skin `onfocus`/`onload`).

---

## Recommended implementation order (fastest path to value)

1. Phase 0 — inventory + fork baseline  
2. Phase 1 — strip helpers + centralize Velocity paths  
3. Phase 2 — pagination vs spotlight/widget split (**fixes Next Page in spotlight**)  
4. Phase 3 — spotlight sizing + settings  
5. Phase 4 — info density  
6. Phase 5 — per-widget layout + multi-row  
7. Phase 6–7 — polish + regression matrix  

---

## Appendix A — Velocity integration quick reference

| User intent | Typical plugin URL shape | Code entry |
|------------|----------------------------|------------|
| Home | `?action=home` | `handle_home` |
| Catalog list | `?action=list&list_id=...&page=1` | `handle_list` |
| Smart rail | `?action=smart_list&type=up_next` (etc.) | `handle_smart_list` |
| Show | `?action=view_show&id=tv-...` | `dispatch` → `Router.get` |
| Season | `?action=view_season&show_id=...&season=...` | `dispatch` → `Router.get` |
| Play | `?action=play&id=...` or `select` | `dispatch_playback` |

**Pagination item:** `build_next_page_item` → label `Next Page >>`, path `?action=list&list_id=...&page=N`.

---

## Appendix B — Known codebase anchors (for implementers)

- Client dispatch: `lib/client/handlers/dispatch.py`
- List item builder: `lib/client/builder.py`
- List pagination UI: `lib/client/handlers/lists.py`
- List API: `lib/daemon/api/routes_list.py` (`get_list_handler`, `page_limit`, `next_page`)
- Smart rails API: `lib/daemon/api/routes_smart.py` (`next_page` always `null`)
- Global pagination setting: `page_limit` in `resources/settings.xml` / `config.get_page_limit()`

---

## Document history

| Date | Change |
|------|--------|
| 2026-04-19 | Initial roadmap: phases, work items, acceptance criteria, file anchors |
