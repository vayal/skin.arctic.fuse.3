# Screen-by-Screen Build Contract (Skin + Addon)

Status: working implementation spec (derived from `doc/skin-vision-blueprint-v0.md` + `inventory/*`).

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

