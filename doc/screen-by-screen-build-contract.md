# Screen-by-Screen Build Contract (Skin + Addon)

Status: working implementation spec (derived from `doc/skin-vision-blueprint-v0.md` + `inventory/*`). **Shipped skin progress** is summarized in **§7.9** (splash reliability, Series/Movies hub info panels).

Purpose:
- Convert the agreed UX vision into concrete, buildable contracts.
- Define what the skin must render per surface.
- Define what the Velocity addon must provide per list/widget feed.
- Capture what to remove/simplify in existing skin code.

---

## 1) Navigation and screen architecture

Main hubs:
- `Home`
- `Series`
- `Movies`

Mini-hubs:
- One provider mini-hub per provider in curated roster:
  - Netflix
  - Disney+
  - Prime Video
  - Apple TV+
  - Hulu
  - Max
  - Paramount+
  - Peacock
  - BBC iPlayer

Global UX rules (applies across hubs):
- Spotlight is hero surface, near full-screen height, single item, info-first.
- Spotlight sources must be non-paginated feeds (never show next-page affordance).
- Row cards are image-only (`poster`/`landscape`/`square` with no metadata overlays).
- Row density baseline is `balanced`.
- Row-level paging contract:
  - show max 10 in-row items before row-end `Next Page`
  - row title click opens full list
  - full list page size is 40 per page (not a total-cap)
- Empty state uses explicit `No items available` behavior.

---

## 2) Hub and mini-hub implementation tables

Legend:
- `Skin source`: main surface that renders this row.
- `Addon feed contract`: list contract to implement/provide from addon side.
- `Paginated`: `No` means dedicated non-paginated list; `Yes` uses page contract.

### 2.1 Home hub

Primary skin surfaces:
- `1080i/Home.xml`
- `1080i/Includes_Home.xml`
- `1080i/Includes_Hubs.xml`

| Row/Widget | Order | Card/Layout | Default action | Skin source | Addon feed contract | Paginated | Notes |
|---|---:|---|---|---|---|---|---|
| Home Spotlight | 1 | Hero (single item) | Info primary, Play secondary | `Includes_Hubs.xml` | `home_spotlight_mixed` (movies+series, fixed alternation) | No | Dedicated list only; no next-page artifacts |
| In-progress Series | 2a (tab) | Poster / balanced | Play | `Includes_Hubs.xml` | `home_in_progress_series` sorted by last watched desc | Yes | In-row cap 10; next-page + header-full-list |
| In-progress Movies | 2b (tab) | Poster / balanced | Play | `Includes_Hubs.xml` | `home_in_progress_movies` sorted by last watched desc | Yes | Same paging contract |

Addon work required:
- Provide mixed spotlight feed with deterministic movie/show alternation.
- Ensure spotlight payload has fields needed by hero metadata (`title`, `year`, `runtime`, one `rating`, short `plot`).
- Provide robust recency-sorted in-progress rails for both media families.

### 2.2 Series hub

Primary skin surfaces:
- `1080i/Home.xml`
- `1080i/Includes_Hubs.xml`

| Row/Widget | Order | Card/Layout | Default action | Skin source | Addon feed contract | Paginated | Notes |
|---|---:|---|---|---|---|---|---|
| Series Spotlight | 1 | Hero (single item) | Info primary, Play secondary | `Includes_Hubs.xml` | `series_spotlight_trending` | No | Non-paginated dedicated spotlight feed |
| Continue Watching Episodes | 2 | Landscape / balanced | Play | `Includes_Hubs.xml` | `series_continue_watching_episodes` with logic: prefer in-progress episode; else next unwatched aired | Yes | Addon owns episode-state logic |
| In-progress Shows | 3 | Poster / balanced | Open show details/deep-view | `Includes_Hubs.xml` | `series_in_progress_shows` sorted by last watched desc | Yes | Click opens show page, not direct play |
| Global Trending | 4 | Poster / balanced | Info | `Includes_Hubs.xml` | `series_global_trending` | Yes | Row title copy: `Trending` |
| Provider Icons | 5 | Square / balanced | Open provider mini-hub | `Includes_Hubs.xml` | `series_provider_icons` | No | Fixed curated provider order |
| Genre Navigation Buttons | 6 | Button row | Open filtered list | `Includes_Hubs.xml` | dedicated genre list routes (see contract appendix to create) | Yes | Uses fixed genre set |

Addon work required:
- Expose show vs episode lists with consistent item types.
- Guarantee aired-filter logic for "next unwatched episode".
- Expose provider icon navigation targets in fixed order.
- Expose fixed genre family feeds:
  - Action, Comedy, Drama, Thriller, Romance, Sci-Fi, Crime, Animation.

### 2.3 Movies hub

Primary skin surfaces:
- `1080i/Home.xml`
- `1080i/Includes_Hubs.xml`

| Row/Widget | Order | Card/Layout | Default action | Skin source | Addon feed contract | Paginated | Notes |
|---|---:|---|---|---|---|---|---|
| Movies Spotlight | 1 | Hero (single item) | Info primary, Play secondary | `Includes_Hubs.xml` | `movies_spotlight_trending` | No | Dedicated non-paginated spotlight |
| In Progress | 2 | Poster / balanced | Play | `Includes_Hubs.xml` | `movies_in_progress` sorted by last watched desc | Yes | Label locked: `In Progress` |
| Global Trending | 3 | Poster / balanced | Info | `Includes_Hubs.xml` | `movies_global_trending` | Yes | Row title copy: `Trending` |
| Provider Icons | 4 | Square / balanced | Open provider mini-hub | `Includes_Hubs.xml` | `movies_provider_icons` | No | Same provider roster/order |
| Genre Navigation Buttons | 5 | Button row | Open filtered list | `Includes_Hubs.xml` | dedicated genre list routes | Yes | Main-hub genre entry sits after provider row |

Addon work required:
- Mirror Series contracts where possible for consistency.
- Ensure list shape and metadata parity with Series hub behavior.

### 2.4 Provider mini-hub (applies to each provider)

Primary skin surfaces:
- provider-targeted hub includes in `1080i/Includes_Hubs.xml` and generated shortcut routes.

| Row/Widget | Order | Card/Layout | Default action | Skin source | Addon feed contract | Paginated | Notes |
|---|---:|---|---|---|---|---|---|
| Provider Spotlight | 1 | Hero (single item) | Info primary, Play secondary | `Includes_Hubs.xml` | `provider_{id}_spotlight` | No | Branding subtle (content-artwork dominant) |
| Trending on <Provider> | 2 | Poster / balanced | Info | `Includes_Hubs.xml` | `provider_{id}_trending` | Yes | Row title format locked |
| Most Popular | 3 | Poster / balanced | Info | `Includes_Hubs.xml` | `provider_{id}_popular` | Yes | Keep naming stable across providers |
| Genre Row 1-4 | 4-7 | Poster / balanced | Info | `Includes_Hubs.xml` | `provider_{id}_genre_{genre}` | Yes | Fixed global genre family strategy |

Addon work required:
- Provide one contract family per provider ID.
- Ensure uniform payload schema across providers (same fields/actions).
- Return explicit empty states where provider data is sparse.

### 2.5 Search and discovery screen

Primary skin surfaces:
- `1080i/Custom_1105_Search.xml`
- `1080i/Includes_Search.xml`
- generator sources in `shortcuts/generator/data/setup/search_path.xml`

| Area | Decision | Skin behavior | Addon contract requirement |
|---|---|---|---|
| Search selector tabs | Discover, Movies, TV Shows only | Keep current selector behavior with reduced tab family | Stable contracts for discover + media-type search |
| Search mode | Combined for movies and series | Use combined widgets as primary UX | Feeds must support combined layout expectations |
| Discovery empty behavior | Keep current | No forced new empty rendering policy | Keep list responses consistent with current skin handling |
| Autocomplete | Keep current | No immediate UX removal | No addon dependency change required |
| Alias scope | Trim to used aliases only | Remove unused legacy/music alias families | Keep only aliases needed for Discover/Movies/TV |

---

## 3) Details, context, OSD, and playback contracts

### 3.1 Details screen (full-screen info, no small info dialog UX)

Primary skin surfaces:
- `1080i/DialogVideoInfo.xml`
- `1080i/Includes_DialogInfo.xml`
- `1080i/Dialog_DialogPlot.xml`
- `1080i/Custom_1114_Dialog_CustomPlot.xml`

| Topic | Locked behavior | Addon requirement |
|---|---|---|
| "Info" action semantics | Open full details screen (not popup dialog) | Resolve full details path consistently for movies/shows |
| Content depth | Keep key metadata + plot + trailer + limited related only | Provide lean details payload; avoid dependency on person/crew deep rails |
| Removed extras | Remove Wikipedia/person/cast/crew-heavy rails and extra buttons | No requirement to provide these legacy helper-style datasets |

### 3.2 Context menu policy

Primary skin surface:
- `1080i/Dialog_DialogContextMenu.xml`

Locked direction:
- Keep context menu surface.
- Remove deprecated/undesired items.
- Align actions with no-small-info-dialog rule and curated details flow.

Addon requirement:
- Keep only context actions still used by target UX (details, trailer, discovery jumps as retained).

### 3.3 OSD/playback policy

Primary skin surfaces:
- `1080i/Includes_OSD.xml`
- `1080i/Custom_1193_VideoOSDInfo.xml`
- `1080i/Custom_1140_OSD_Playlist.xml`
- `1080i/Custom_1141_OSD_Cast.xml`
- `1080i/Dialog_DialogPVRInfo.xml`

| Topic | Locked behavior | Addon requirement |
|---|---|---|
| OSD baseline | During playback show normal media controls only | None beyond normal playback integration |
| Pause info | On pause show minimal title + plot | Provide title/plot fields consistently |
| OSD details bridge | First details action is lightweight minimal overlay; second goes full details page | Keep item resolution stable between playback item and details route |
| Playlist OSD dialog | Remove | None |
| OSD cast dialog | Remove | None |
| PVR functionality | Remove all PVR functionality in this fork | None |
| OSD next recommendation | Remove | Remove dependency on recommendation feed in playback OSD |

---

## 4) Existing code changes required (remove / edit list)

This section is implementation-focused and grouped by intent.

### 4.1 Remove/hide surfaces

- Remove/hide home submenu static items surface:
  - `1080i/Includes_Home.xml`
  - generator companion: `shortcuts/generator/data/base/home_submenu.xml`
- Remove nextaired home rails from main UX:
  - `1080i/Includes_NextAired.xml`
- Remove/hide shortcut editor flow from user-facing settings:
  - `1080i/Custom_1115_Window_Shortcuts.xml`
  - `1080i/Custom_1116_Dialog_Shortcuts.xml`
  - `1080i/Dialog_DialogShortcuts.xml`
  - `1080i/Custom_1124_Dialog_Shortcut_Settings.xml`
- Remove all PVR-related UI/actions:
  - `1080i/Dialog_DialogPVRInfo.xml`
  - PVR entries in settings surfaces.
- Remove OSD extras:
  - `1080i/Custom_1140_OSD_Playlist.xml`
  - `1080i/Custom_1141_OSD_Cast.xml`

### 4.2 Simplify details/context surfaces

- Keep full details screen as canonical info destination:
  - `1080i/DialogVideoInfo.xml`
  - `1080i/Includes_DialogInfo.xml`
- Remove/de-scope person/crew deep rails and helper-era extras:
  - `1080i/Includes_DialogInfo.xml`
  - `1080i/Dialog_DialogView.xml`
  - `1080i/Dialog_DialogPlot.xml`
  - `1080i/Custom_1114_Dialog_CustomPlot.xml`
- Curate expanded context menu actions (remove undesired items, keep useful core):
  - `1080i/Dialog_DialogContextMenu.xml`

### 4.3 Search/generator cleanup

- Keep search UX in combined mode and core tab set:
  - `1080i/Includes_Search.xml`
  - `1080i/Custom_1105_Search.xml`
- Trim alias families to only Discover/Movies/TV:
  - `shortcuts/generator/data/setup/search_path.xml`
  - `shortcuts/skinvariables-shortcut-searchwidgets.json`
- Maintain generator pipeline, but hardcode default outputs for primary hubs:
  - `shortcuts/skinvariables-generator.json`
  - `shortcuts/generator/data/base/*.xml`
  - `shortcuts/generator/data/setup/*.xml`
  - `1080i/Includes.xml` (generated include load contract)
  - **Important:** `1080i/script-skinvariables-generator-includes.xml` is **output** of that pipeline — edit **`shortcuts/`** sources and regenerate; see **§8.0** in this document so changes are not lost on the next generator run.

### 4.4 Contract and property-model cleanup

- Apply medium action-dispatch simplification:
  - `1080i/Includes_Actions.xml`
- Retire legacy property-model references where possible, document exceptions before final lock:
  - `1080i/Includes_Paths.xml`
  - `1080i/Includes_Expressions.xml`
  - cross-surface `TMDbHelper.*`/`TMDBHelper.*` usages
- Keep required media info labels (watched/in-progress/unwatched semantics) during cleanup:
  - ensure these labels are preserved while removing helper-specific settings clutter.

---

## 5) Addon work package checklist (to execute in addon repo)

Create a dedicated addon implementation document and track these packages:

1. Hub spotlight contracts
- `home_spotlight_mixed` (alternating mixed media)
- `series_spotlight_trending`
- `movies_spotlight_trending`
- `provider_{id}_spotlight`
- all non-paginated.

2. Progress/continue contracts
- `home_in_progress_series`
- `home_in_progress_movies`
- `series_continue_watching_episodes` (aired + progress priority logic)
- `series_in_progress_shows`
- `movies_in_progress`

3. Discovery/trending/provider contracts
- `series_global_trending`
- `movies_global_trending`
- `provider_{id}_trending`
- `provider_{id}_popular`
- provider icon navigation target mapping in fixed curated order.

4. Genre contract family
- main hub genre routes
- per-provider genre routes
- fixed genre set: Action, Comedy, Drama, Thriller, Romance, Sci-Fi, Crime, Animation.

5. Paging contract support
- expose list pagination compatible with:
  - in-row cap 10
  - row-end next page affordance
  - header click full list
  - 40 items per full-list page.

6. Details payload consistency
- ensure all hero/details/paused-overlay fields are available and normalized.

---

## 6) Open implementation follow-ups before freeze

- Finalize D-003 matrix:
  - enumerate all available hub/list display modes and lock one per hub/list family.
- Finalize D-021 concrete keep/remove action set in expanded context menu.
- Finalize D-038 explicit list of legacy property references + documented exceptions.
- Finalize D-045 freeze checklist wording and trigger condition.
- Create and link a dedicated addon work doc once skin-side contract set is accepted.

---

## 7) Implementation status (code review vs this contract)

**Scope of this review:** Current trees under `skin.velocity.af3` and `plugin.video.velocity2` as present in the workspace, including recent session work: hub spotlight / `Velocity.WidgetContainer` alignment on `Home` (`1080i/Includes_Hubs.xml`), Home menu down-to-spotlight behavior (`1080i/Includes_Home.xml`), poster fallbacks and `Velocity_Image_Poster` wiring (`Includes_Images.xml`, `Includes_Widgets.xml`, `Includes_Lists.xml`, `Includes_Layouts.xml`, skinvariables image includes), populated `skinvariables-1101widgets-standard` / `1102widgets-standard` in `1080i/script-skinvariables-generator-includes.xml`, **Series/Movies hub widget info panels** (`Hub_Combined_Info` / `Hub_Wall_Info` + shortcut menus for generator parity — see **§7.9**), **startup splash safety** (`Startup.xml`, `Home.xml`, `Custom_1195_SkinUserLoginScreen.xml`, `skinvariables-splash.json` — see **§7.9**), and addon list normalization / artwork from metadata (`plugin.video.velocity2` `smart_lists.py`, `lib/rails/common.py`, `phase02_contracts.py`).

**Legend**

| Status | Meaning |
|--------|---------|
| **Yes** | Implemented in code in a way that matches the contract row or rule (skin and/or addon as required). |
| **Partial** | Present but incomplete, uses a legacy or alternate path, only one layer (skin vs addon), or not verified end-to-end against UX wording. |
| **No** | Not implemented, still explicitly present contrary to remove list, or no wiring found. |

### 7.1 Global rules (§1)

| Item | Status | Notes |
|------|--------|-------|
| Main hubs: `Home`, `Series` (1101), `Movies` (1102) | **Yes** | `Home.xml`, `Custom_1101_Hub.xml`, `Custom_1102_Hub.xml` + `Includes_Hubs.xml`. |
| Provider mini-hubs (Netflix … BBC iPlayer) as dedicated surfaces | **Partial** | Addon: `PROVIDER_ORDER` + `provider_*_*` resolver in `phase02_contracts.py`. Skin: `doc/velocity-addon-list-rails-report.md` marks provider mini-hub lists **not used** in skin wiring; no per-provider hub windows in §1 sense. |
| Spotlight = hero, near full-screen, single item, info-first | **Partial** | Spotlight stack exists; exact layout vs wording not audited. |
| Spotlight sources non-paginated (no next-page) | **Yes** | Addon `_non_paginated_spotlight` + `SPOTLIGHT_MAX_ITEMS` in `phase02_contracts.py`. |
| Row cards image-only (no metadata overlays) | **Partial** | Depends on row includes / widget mode; not fully audited per row. |
| Row density baseline `balanced` | **Partial** | Not verified against all hub rows. |
| In-row max 10 + row-end next page + header full list + full list page 40 | **Partial** | Addon paginates with `full_page_size = 40`. Skin uses `browse="$VAR[Defs_BrowseLimitedLists]"` (`never`/`auto` in `Includes_Defaults.xml`); explicit cap-10 not enforced in skin XML alone. |
| Empty state: explicit “No items available” behavior | **Partial** | `Widget_NoResults` patterns exist; not verified for every contract row. |

### 7.2 Hub rows and feeds (§2.1–§2.3)

| Contract row / feed | Status | Notes |
|---------------------|--------|-------|
| **§2.1** Home Spotlight → `home_spotlight_mixed` | **Yes** | `Startup.xml` + shortcuts; addon `PHASE02_EXACT` + resolver. |
| **§2.1** In-progress Series → `home_in_progress_series` | **Partial** | Addon list exists. Generated `skinvariables-homewidgets-standard` row 501 uses `action=smart_list&type=active_shows`, not `list_id=home_in_progress_series`. |
| **§2.1** In-progress Movies → `home_in_progress_movies` | **Partial** | Addon list exists. Home row 502 uses `smart_list&type=in_progress_movies`, not `list_id=home_in_progress_movies`. |
| **§2.2** Series Spotlight → `series_spotlight_trending` | **Yes** | `Startup.xml` for 1101; addon handler. |
| **§2.2** Continue Watching → `series_continue_watching_episodes` | **No** | Addon + `PHASE02_EXACT`; not present in `skinvariables-1101widgets-standard` (only in-progress + trending rows wired). |
| **§2.2** In-progress Shows → `series_in_progress_shows` | **Yes** | `script-skinvariables-generator-includes.xml` row 501; addon resolver. |
| **§2.2** Global Trending → `series_global_trending` | **Yes** | Generator include row 502; addon resolver. |
| **§2.2** Provider Icons → `series_provider_icons` | **No** | Addon + icons route; no row in current `1101widgets-standard` include. |
| **§2.2** Genre Navigation Buttons (fixed genre set) | **No** | No dedicated genre button row wired to `genre_global_*` (or equivalent) in inspected `1101` standard widgets. |
| **§2.3** Movies Spotlight → `movies_spotlight_trending` | **Yes** | `Startup.xml` for 1102; hub list 301; addon. |
| **§2.3** In Progress → `movies_in_progress` | **Partial** | Addon `movies_in_progress`. `1102widgets-standard` row 501 uses `smart_list&type=in_progress_movies` (router maps kind; not the named `list_id` URL). |
| **§2.3** Global Trending → `movies_global_trending` | **Yes** | Generator row 502; addon. |
| **§2.3** Provider Icons → `movies_provider_icons` | **No** | Addon; not in `1102widgets-standard`. |
| **§2.3** Genre Navigation Buttons | **No** | Same as Series hub. |

### 7.3 Provider mini-hub rows (§2.4)

| Row / pattern | Status | Notes |
|---------------|--------|-------|
| `provider_{id}_spotlight` | **Partial** | Resolved in addon (`PROVIDER_RE`); skin generator not wired per `velocity-addon-list-rails-report.md`. |
| `provider_{id}_trending` | **Partial** | Same. |
| `provider_{id}_popular` | **Partial** | Same. |
| `provider_{id}_genre_{genre}` | **Partial** | Same. |

### 7.4 Search & discovery (§2.5)

| Area | Status | Notes |
|------|--------|-------|
| Selector tabs: Discover, Movies, TV only | **Partial** | Search stack exists (`Custom_1105_Search.xml`, `Includes_Search.xml`); exact tab set not re-verified against “only”. |
| Combined mode for movies + series | **Yes** | Combined widgets / generator paths present. |
| Discovery empty behavior | **Partial** | “Keep current” — unchanged by definition. |
| Autocomplete | **Partial** | “Keep current”. |
| Alias scope trimmed to Discover/Movies/TV | **Partial** | `search_path.xml` / generator still include music search paths in `script-skinvariables-generator-includes.xml` fragments; full trim not confirmed. |

### 7.5 Details, context, OSD (§3)

| Item | Status | Notes |
|------|--------|-------|
| §3.1 Info → full details (not small dialog only) | **Partial** | Surfaces exist (`DialogVideoInfo.xml`, etc.); full semantics not audited. |
| §3.1 Lean details / remove heavy rails | **Partial** | Files still large; de-scope depth not proven. |
| §3.2 Context menu curated | **Partial** | `Dialog_DialogContextMenu.xml` exists; D-021 “keep/remove” set not finalized (§6). |
| §3.3 OSD baseline (normal controls) | **Yes** | `Includes_OSD.xml` and related. |
| §3.3 Pause minimal title + plot | **Partial** | Not audited line-by-line. |
| §3.3 OSD details bridge (overlay then full) | **Partial** | Not audited. |
| §3.3 Remove Playlist OSD (`Custom_1140_OSD_Playlist.xml`) | **No** | File present; `Includes_Actions.xml` still routes to `1140` when enabled. |
| §3.3 Remove OSD cast dialog | **Partial** | `Custom_1141_OSD_Cast.xml` absent, but `Includes_Expressions.xml` / `DialogSeekBar.xml` still reference window `1141`. |
| §3.3 Remove PVR in fork | **Partial** | Some `Dialog_DialogPVR*.xml` / `DialogPVRInfo.xml` remain; scope of removal incomplete. |
| §3.3 Remove OSD next recommendation | **Partial** | `Custom_1143_OSD_NextOverlay.xml` exists; contract says remove — not fully retired. |

### 7.6 Remove / simplify list (§4)

| Item | Status | Notes |
|------|--------|-------|
| §4.1 Hide/remove home submenu static items | **No** | `Includes_Home.xml` still includes `skinvariables-$PARAM[window]submenu-staticitems`; `home_submenu.xml` generator data still drives lists. |
| §4.1 Remove nextaired home rails from main UX | **Partial** | `Includes_NextAired.xml` remains in `Includes.xml` and powers window `1106` / reused info on other hubs; contract target is **no NextAired on Home main rail** — `Home.xml` does not pull NextAired as primary home content (spotlight + standard widgets use Velocity paths). |
| §4.1 Remove shortcut editor from user-facing settings | **No** | `Settings.xml` / `Includes_SkinSettings.xml` still `ActivateWindow(1115)`. |
| §4.1 Remove all PVR UI/actions | **Partial** | PVR-related XML still in tree; extent of user reachability not fully mapped. |
| §4.1 Remove `Custom_1140_OSD_Playlist.xml` | **No** | File still in `1080i/`. |
| §4.1 Remove `Custom_1141_OSD_Cast.xml` | **Partial** | File absent; references may linger (§3.3). |
| §4.2 Simplify details/context per contract | **Partial** | Ongoing; not closed against §3.1 list. |
| §4.3 Search/generator cleanup | **Partial** | Generator + `script-skinvariables-generator-includes.xml` maintained; music search snippets still appear in generated search includes. |
| §4.4 Actions / property-model cleanup | **Partial** | Hub property model improved this session; global `TMDbHelper` retirement / D-038 not done. |

### 7.7 Addon checklist packages (§5)

| Package | Status | Notes |
|---------|--------|-------|
| 1 Hub spotlight contracts | **Partial** | Core `home_*` / `series_*` / `movies_*` spotlights implemented; `provider_*_spotlight` family not skin-wired. |
| 2 Progress/continue contracts | **Partial** | Addon lists exist; Home/Series rows partly use `smart_list` or omit `series_continue_watching_episodes`. |
| 3 Discovery/trending/provider | **Partial** | Trending + provider resolver in addon; provider icon rows missing on main hubs in skin. |
| 4 Genre contract family | **Partial** | `GENRE_SLUGS` + `genre_global_*` style support in addon; main-hub genre button rows not in skin standard widgets. |
| 5 Paging contract (10 / next / header / 40) | **Partial** | 40-page slices in addon; skin row cap and affordances not fully locked in XML. |
| 6 Details payload consistency | **Partial** | Normalization improvements in addon; full matrix not audited. |

### 7.8 Open follow-ups (§6)

| Follow-up | Status |
|-----------|--------|
| D-003 matrix finalized | **No** |
| D-021 context menu keep/remove set | **No** |
| D-038 legacy property list + exceptions | **No** |
| D-045 freeze checklist | **No** |
| Dedicated linked addon work doc | **No** |

---

## 8) Full implementation plan (Home hub as baseline)

This plan finishes every **Partial** / **No** item in §7 by repeating the **Home** pattern: `Hub_Window` + `Home_Control` navigation, `Hub_Onload` / `Velocity.WidgetContainer` on `Home`, `skinvariables-*widgets-standard` built from `Widget_Row` + `Hub_Widgets_Grouplist`, spotlight paths in `Startup.xml` / `HomeSwitcher.*`, `plugin://plugin.video.velocity2/?action=list&list_id=<D015_id>&page=1` for contract lists, `browse="$VAR[Defs_BrowseLimitedLists]"`, `Widget_NoResults`, and addon `phase02_contracts.py` (+ list handlers) as single source of truth.

**Before changing any hub widget XML, read §8.0.** It explains why editing `script-skinvariables-generator-includes.xml` alone is unsafe.

### 8.0 SkinVariables generator — sources vs output (non-negotiable workflow)

The file `1080i/script-skinvariables-generator-includes.xml` is **generated output**, not the authoritative place to define hub widgets long-term. Treat it like a **build artifact** (e.g. a compiled bundle): it is **rewritten from scratch** whenever the SkinVariables generator runs.

**Canonical inputs (edit these, then regenerate):**

| Input | Role |
|-------|------|
| `shortcuts/skinvariables-generator.json` | Names the **output file** (`"output": "script-skinvariables-generator-includes.xml"`, `"folder": "1080i"`), lists **`genxml`** fragments to merge, and holds **`getnfo`** default plugin URLs (e.g. `default_home_in_progress_series`) used when building includes. |
| `shortcuts/generator/data/base/*.xml` (and any `setup/*.xml` referenced from those) | Blueprint data the generator expands into `<include name="skinvariables-homewidgets-standard">` … `</include>` blocks and related skinvariables includes. |

**What the generator does:** Kodi’s **script.skinvariables** (or your repo’s equivalent batch step) reads the JSON + XML inputs and **writes** `1080i/script-skinvariables-generator-includes.xml`. Any manual change made **only** in that XML file is **lost on the next regeneration** — CI, another developer, or you re-running the tool will overwrite it.

**This fork’s load order:** `1080i/Includes.xml` includes **`script-skinvariables-generator-includes.xml` directly**. There is **no** `script-skinvariables-generator-overrides.xml` in that chain today, so you cannot rely on “overrides after the fact” unless you add that pattern yourself.

**Do / don’t:**

| Do | Don’t |
|----|--------|
| Change widget rows, labels, `list_id` URLs, and row order in **`shortcuts/generator/data/...`** and/or **`skinvariables-generator.json`** (`getnfo` / templates as applicable), **then** run the generator so `script-skinvariables-generator-includes.xml` reflects the change. | Edit **`1080i/script-skinvariables-generator-includes.xml`** as the **only** change and expect it to survive the next generator run. |
| Commit **both** updated sources **and** regenerated output in the same change (or document “run generator” in PR checklist) so the tree stays consistent. | Assume hand-edited generated XML is permanent without updating sources. |

**Phases A–D and H below** all touch generated hub/search includes: **always** trace the fragment back to `shortcuts/generator/` or `skinvariables-generator.json`, fix the source, regenerate, and commit the regenerated `script-skinvariables-generator-includes.xml` together with the source diff.

### 8.1 Home baseline checklist (copy to other hubs)

Use this as a **definition of done** when porting work:

| Layer | What Home already does | Other hubs must match |
|-------|-------------------------|-------------------------|
| **Window shell** | `Home.xml` → `Hub_Window` with `window` param (`home` / `1101` / …) | Same for `Custom_1101_Hub.xml` / `1102` / optional `1103`–`1104`. |
| **Onload / state** | `Hub_Onload` + `Hub_Onload_SyncWidgetContainerToHome` + `Hub_Onload_Window` defaults | Same include chain per hub `window_id`. |
| **Menu → spotlight** | `Home_Control` `ondown` → `310` when `Exp_Hubs_Spotlight_HasItems` + spotlight target set | Already aligned for 1101/1102 after recent hub work; re-verify after any `Home_Control` edits. |
| **Spotlight content** | `Skin.String(HomeSwitcher.<id>.Spotlight.*)` + `Hub_Spotlight_List` | Each hub has its own `HomeSwitcher.1101.*` keys in `Startup.xml` / skinvariables bootstrap. |
| **Widget rows** | `skinvariables-homewidgets-standard`: `Widget_Row` ids `501+`, `List_*_Row`, `onup` → `310` when spotlight has items | Mirror for `1101widgets-standard`, `1102widgets-standard`, etc. |
| **Where to edit widget XML** | Generated include appears in `script-skinvariables-generator-includes.xml`, but you **edit `shortcuts/generator/` + `skinvariables-generator.json` and regenerate** — see **§8.0** | Same for every hub; never treat the 1080i generated file as the only source of truth. |
| **Feed URLs** | Prefer **`list_id=<contract>`** over legacy `smart_list&type=…` when a D-015 list exists | Ensures paging, metadata, and empty states match `phase02_contracts.py`. |
| **Art / empty** | `Velocity_Image_Poster`, default `icon` on widget/list/layout | Any new row uses same includes to avoid blank tiles. |
| **Addon** | Resolver in `phase02_contracts.py` + rails for progress/trending | Add handlers only when a **new** `list_id` is introduced; otherwise wire skin only. |

### 8.2 Phase A — Contract URL parity on Home (§2.1, §5.2)

**Goal:** Home in-progress rows call `home_in_progress_series` / `home_in_progress_movies` exactly like spotlight uses `home_spotlight_mixed`.

| Step | Work | Files / artifacts | Acceptance |
|------|------|-------------------|--------------|
| A1 | Replace `smart_list&type=active_shows` with `?action=list&list_id=home_in_progress_series&page=1` on row 501 | **Sources only** per **§8.0** (`shortcuts/generator/data/...`, `skinvariables-generator.json` `getnfo` if that feeds the row), then regenerate `script-skinvariables-generator-includes.xml` | Row loads same data as API `/api/lists/home_in_progress_series`; pagination `has_more` works; regen does not revert the fix. |
| A2 | Replace `smart_list&type=in_progress_movies` with `list_id=home_in_progress_movies` on row 502 | Same as A1 (**§8.0**) | Same for movies tab row. |
| A3 | If Home uses **tab** UX in product copy but skin uses **two visible rows**, either (product) document as “two rows” or (skin) merge into one container + selector — align §2.1 wording with XML | `Includes_Home.xml` / selector includes | Behavior matches contract table (“2a tab / 2b tab”). |
| A4 | Regression: `Hub_Onload_SyncWidgetContainerToHome`, poster fallbacks, `Widget_NoResults` | Kodi manual pass | No regression on Down/Up between menu, spotlight, row 501/502. |

### 8.3 Phase B — Series hub complete row stack (§2.2)

**Baseline:** `skinvariables-1101widgets-standard` already has `series_in_progress_shows` (501) and `series_global_trending` (502) with Home-like `onup` / `Widget_NoResults`.

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| B1 | Add **Continue Watching** row: `list_id=series_continue_watching_episodes`, **landscape** row per contract | Extend **`1101widgets-standard` in generator sources** (**§8.0**), assign new id `503` (or reorder 502→503 and insert at 2), then regenerate `script-skinvariables-generator-includes.xml` | Order matches contract: Spotlight (301) → Continue (next row) → In-progress shows → Trending → … |
| B2 | Re-sequence row **labels** and **container ids** to match §2.2 order; update `Hub_Combined_Info` / selector entries if Combined mode exposes these ids | **§8.0** generator sources → regen `script-skinvariables-generator-includes.xml`; plus any `skinvariables-1101widgets-combined*` fragments if those are also generated from tracked inputs | Info panel visibility follows `Window(Home).Property(Velocity.WidgetContainer)` for new id. |
| B3 | Default actions: episode row → Play; in-progress shows → deep view (folderpath / onclick from addon item) | Addon `build_list_item` / router if paths wrong | Matches “Play” vs “Open show details” in contract. |
| B4 | QA same navigation baseline as Home: menu Down → spotlight, spotlight Down → first widget, widget Up → spotlight | `Includes_Home.xml`, `Includes_Hubs.xml` | Parity with Home after row insert (no focus trap). |

### 8.4 Phase C — Movies hub contract IDs (§2.3)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| C1 | Row 501: `list_id=movies_in_progress` instead of `smart_list&type=in_progress_movies` | **§8.0** sources + regenerated `script-skinvariables-generator-includes.xml` | Label remains **In Progress**; data via D-015. |
| C2 | Keep `movies_global_trending` on row 502; verify label **Trending** | Skin label string | Matches contract copy. |
| C3 | QA navigation + posters | Same as B4 | — |

### 8.5 Phase D — Provider icon rows on Series / Movies (§2.2–2.3, §5.3)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| D1 | Add `Widget_Row` with **square** layout (or reuse existing square list include if present) bound to `list_id=series_provider_icons` / `movies_provider_icons` | **`1101widgets-standard` / `1102widgets-standard` via §8.0 sources** + regen; plus `Includes_Lists.xml` / `Includes_Layouts.xml` if new layout | Items show provider art; click executes `ListItem.FolderPath` / addon route to mini-hub or ActivateWindow. |
| D2 | Addon: confirm each list item exposes **ActivateWindow**-compatible path for target mini-hub (see Phase F) | `phase02_contracts.py` + icon list builder | Fixed order matches `PROVIDER_ORDER`. |
| D3 | Empty state: `Widget_NoResults` or inline empty label for icon strip | Same pattern as Home rows | No crash when provider list empty. |

### 8.6 Phase E — Genre navigation (§2.2, §2.3, §5.4)

**Prerequisite:** Addon exposes stable routes (already have `GENRE_SLUGS` / `genre_global_*` patterns in `phase02_contracts.py` — confirm list ids or `ActivateWindow` paths).

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| E1 | Document canonical **`list_id` or action** per genre for **main hub** (Action, Comedy, …) | `doc/d015-addon-required-lists-contract.md` or new appendix | One row per genre or one multi-item list — pick one and lock. |
| E2 | Skin: add **button row** (not poster) — mirror Categories / `List_ButtonMenu_Row` pattern used elsewhere, or dedicated `genre` strip | New include under `Includes_Hubs.xml` or generator fragment for `1101`/`1102` **above** or **below** provider row per contract order | §2.3 says genre **after** provider row; §2.2 order says genre is **6** after provider **5** — match table. |
| E3 | Wire each button to `ActivateWindow(videos,<plugin path>,return)` | Buttons + skin strings | Each opens correct filtered list with paging. |

### 8.7 Phase F — Provider mini-hubs (§2.4, §1 mini-hub list)

**Decision point (record in D-003):** Either **(F-a)** one shell window (e.g. reuse `1103`) with `HomeSwitcher.1103.*` / dynamic label, or **(F-b)** one XML include parameterized by `provider_id` included from multiple `Custom_11xx` windows.

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| F1 | Add skin window(s) or parameterized hub include: spotlight + trending + popular + 4× genre rows per §2.4 | `1080i/Custom_11xx_Hub.xml`, `Includes_Hubs.xml`, generator lists | From provider icon row, user lands on correct provider + media (movie vs show) if split by media in addon contract. |
| F2 | `Startup.xml` / `skinvariables-startup.json`: bootstrap `HomeSwitcher.<mini>.Spotlight.Path` etc. for each provider slug | Shortcuts + startup onloads | Each mini-hub has non-empty spotlight path. |
| F3 | Wire `provider_{slug}_{media}_*` URLs consistently with `PROVIDER_RE` | Addon already resolves — skin only paths | `velocity-addon-list-rails-report.md` updated from “Not used” to “Used”. |
| F4 | Navigation back to parent Series/Movies hub | `Home_Control` / `ReplaceWindow` chain | Back does not strand user. |

### 8.8 Phase G — Global UX hardening (§1, §5.5)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| G1 | **In-row cap 10:** set explicit `limit="10"` on **row** `<content>` where contract requires in-row preview, **or** enforce in addon first page only — pick one source of truth; document in D-015 | `Widget_Row` / list defaults vs `phase02_contracts` | Row never shows >10 without “show more” / next page. |
| G2 | **Row-end next page + header full list:** ensure `browse` mode and header onclick use same `list_id` with `page=` increment; full list uses page size **40** (addon already uses `full_page_size = 40`) | `Includes_Lists.xml`, row onclick variables | Matches §1 paging bullets. |
| G3 | **Image-only cards:** audit `List_Poster_Row` / `List_Landscape_Row` / square layout for metadata overlays; strip labels where contract says image-only | Layout includes | Visual audit checklist per hub. |
| G4 | **Balanced density:** lock `HomeSwitcher.*.Mode` defaults + skin setting text to **Standard** (or Combined) per D-003 | `skinvariables-startup.json`, `Startup.xml` | D-003 matrix row filled. |
| G5 | **Empty state copy:** standardize on `$LOCALIZE[…]` string = “No items available” (or product string) in `Widget_NoResults` | Shared include | All contract rows show explicit empty behavior. |

### 8.9 Phase H — Search & discovery (§2.5, §4.3)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| H1 | Inventory tabs in `Includes_Search.xml` / `Custom_1105_Search.xml` | — | Only **Discover, Movies, TV Shows** reachable (hide or remove other tabs). |
| H2 | Remove music (and other unused) search widget **content** from generator inputs | `shortcuts/generator/data/setup/search_path.xml`, `skinvariables-shortcut-searchwidgets.json`; then **regenerate** per **§8.0** so `script-skinvariables-generator-includes.xml` is updated from sources | Generated XML contains no dead music search rows for Velocity product. |
| H3 | Combined mode remains default; document | `skinvariables-startup.json` | §2.5 satisfied. |

### 8.10 Phase I — OSD & playback cleanup (§3.3, §4.1)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| I1 | Remove **Playlist OSD** `1140`: delete `Custom_1140_OSD_Playlist.xml`; remove `ActivateWindow(1140)` / `Action_OSD_1140` branches | `Includes_Actions.xml`, `Includes_Expressions.xml`, `DialogSeekBar.xml`, any OSD button map | No reference to `1140`; build still loads. |
| I2 | **Cast OSD `1141`:** remove all `Window(1141)` / `1141` references; confirm no XML file required | Same sweep | Clean grep for `1141`. |
| I3 | **Next overlay `1143`:** remove or gate off per contract | `Custom_1143_OSD_NextOverlay.xml`, seekbar visibility | No recommendation UI if contract says remove. |
| I4 | **Pause / details bridge:** align `Custom_1193_VideoOSDInfo.xml` + primary OSD buttons with §3.3 (minimal pause info; first Info → overlay, second → full details) | `Includes_OSD.xml` | Documented behavior + Kodi QA. |

### 8.11 Phase J — PVR removal (§3.3, §4.1)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| J1 | Map all entry points: `Home_1107_onright` PVR conditions, `ActivateWindow(tvchannels)`, `Dialog_DialogPVR*.xml`, `DialogPVRInfo.xml`, settings links | `Includes_Home.xml`, `Settings.xml`, `Includes_SkinSettings.xml`, `Includes.xml` | No user-visible PVR path in Velocity fork (or explicitly gated behind impossible condition removed). |
| J2 | Remove or stub PVR window includes from `Includes.xml` if safe for Kodi core | `Includes.xml` | Skin starts without missing include errors. |
| J3 | Document “Kodi core PVR dialogs may still exist on disk but are unreachable” vs “delete files” — pick fork policy | `doc/screen-by-screen-build-contract.md` or D-045 | Team agreement. |

### 8.12 Phase K — Submenu & shortcut editor (§4.1)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| K1 | Remove or permanently hide `skinvariables-homesubmenu-staticitems` from `Includes_Home.xml` (and hub equivalents if any) | `Includes_Home.xml`, generator `home_submenu.xml` | No static submenu strip on Home. |
| K2 | Remove **ActivateWindow(1115)** from `Settings.xml` / `Includes_SkinSettings.xml` (or move to developer skin setting) | Settings includes | Casual users cannot open full shortcut editor if contract says remove. |
| K3 | If internal devs still need editor, document hidden gesture or separate dev addon | Doc | §4.1 satisfied for “user-facing”. |

### 8.13 Phase L — Details & context (§3.1–3.2, §4.2, §6)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| L1 | **D-021:** Produce table of context menu IDs → **Keep / Remove** | `Dialog_DialogContextMenu.xml` + meeting notes | PR removes only agreed items. |
| L2 | **Details lean pass:** Remove Wikipedia / heavy cast rails per §3.1 | `Includes_DialogInfo.xml`, `DialogVideoInfo.xml`, related | Full details still opens; no removed dependency crashes. |
| L3 | **D-003:** Lock one **Mode** (Standard / Combined / Wall) per hub family | Matrix doc + `skinvariables-startup.json` | No ambiguous multi-mode for same hub without user toggle. |
| L4 | **D-038:** grep `TMDbHelper` / legacy props; list exceptions | `Includes_Paths.xml`, `Includes_Expressions.xml` | Doc + code comments for allowed leftovers. |

### 8.14 Phase M — Addon + docs closure (§5.6, §6, §7.8)

| Step | Work | Files | Acceptance |
|------|------|-------|--------------|
| M1 | **Details payload matrix:** list required ListItem labels for hero, rows, pause overlay; verify `normalize_item_for_skin` / list builders populate all | `plugin.video.velocity2` list code + doc table | Gaps fixed or documented as optional. |
| M2 | **Dedicated addon work doc** linked from §5 header | `doc/` new file + link from this contract | Single entry point for feed ownership. |
| M3 | **D-045 freeze checklist** — trigger + wording | Doc | Release process defined. |

### 8.15 Suggested sequencing (dependencies)

1. **A → C → B** (URL parity Home & Movies first, then Series row insert) — unblocks consistent paging QA.  
2. **D → E** (provider icons before genre row order).  
3. **F** can start after D2 (targets exist); parallel with **G** (global UX).  
4. **H** independent of hub rows; good parallel track.  
5. **I → J** (OSD cleanup before PVR sweep — shared `Includes_Expressions` / seekbar).  
6. **K** early if product wants less clutter quickly.  
7. **L → M** last gates before freeze.

### 8.16 Verification matrix (each phase exit)

For every hub / window touched:

- [ ] Menu **Down** → spotlight **310** when `Exp_Hubs_Spotlight_HasItems` and spotlight configured.  
- [ ] Spotlight **Down** → first widget row; **Up** returns to spotlight when visible.  
- [ ] `Window(Home).Property(Velocity.WidgetContainer)` matches focused row for fanart / info (`Includes_Images.xml` / info panels).  
- [ ] Empty list: explicit empty UI, no white tiles (`Velocity_Image_Poster` + `icon` defaults).  
- [ ] `xmllint` / skin reload; addon `pytest` for any handler change.  
- [ ] If widget XML changed: **sources** under `shortcuts/` updated, generator run completed, and **`script-skinvariables-generator-includes.xml` matches sources** (§8.0) — re-run generator after merge if unsure.

---
