# 2. Velocity Routing & DB Contracts

## Route Formatting
All new routes mapped to the skin must use this exact format:
`plugin://plugin.video.velocity/?action=<endpoint>[&key=value...]`

## Spotlight & Pagination Rules
- Spotlight feeds (e.g., `series_spotlight_trending`) are STRICTLY non-paginated. Never append `page=` or `next=` to them.
- Row-level paging caps at 10 items in-row, full list pages cap at 40.

## Database Integrity (WSL)
The Velocity SQLite database is located at:
`/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`
- If you are asked to debug missing UI items, use the `wsl-sqlite` MCP tool to run `SELECT` queries on the `catalog_list` and `list_item` tables to verify the data exists before assuming the XML is broken.

## Roadmap Phase Alignment

### Phase 1 Baseline Lock
- IA and navigation: Home/Series/Movies hubs, provider roster, global genre set frozen
- D-003 baseline: Home/1101/1102 hubs use `Combined` mode; 1103/1104 optional; search uses `Custom_1105_Search.xml`
- D-015 baseline: All contract families defined (home/series/movies/provider/search contracts)
- Cross-cutting guarantees: pagination, image-only cards, discovery defaults, progress defaults

### Phase 2 List Alignment
- Reconcile all core hub rows against D-015 contract IDs
- Classify unresolved routes as `missing`, `deviation`, or `deferred`
- Confirm provider icon rows expose stable deep link targets
- Apply generator discipline: source first, regenerate, verify, commit together

### Phase 3 Non-List Surfaces
- Details/context: Info action resolves to full details, lean details rails, D-021 context menu policy
- OSD/playback: Minimal control scope, overlay -> full details transition
- Search chrome: Discover/Movies/TV with Velocity `execute_search` path model
- Removals: NextAired not primary Home rail, submenu/editor policy, PVR/legacy cleanup

### Phase 4 Freeze Verification
- Browse-to-play, search-to-play, info-and-related journeys validated
- D-015 runtime pagination/empty-state behavior verified
- D-003/D-021/D-038 runtime policy conformance verified
- Freeze decision recorded with blocker list

### Phase 5 Debt Closure
- Helper debt: Remove undeclared TMDbHelper dependencies, keep only D-038 exceptions
- PVR policy: Finalize 1107 policy (keep/velocity-only/hybrid) and implement
- D-038 exceptions: All remaining helper hits reconciled into exceptions ledger

## Contract Families Reference

### Home Contracts
- `home_spotlight_mixed`
- `home_in_progress_series`
- `home_in_progress_movies`

### Series Contracts
- `series_spotlight_trending`
- `series_continue_watching_episodes`
- `series_in_progress_shows`
- `series_global_trending`
- `series_provider_icons`

### Movies Contracts
- `movies_spotlight_trending`
- `movies_in_progress`
- `movies_global_trending`
- `movies_provider_icons`

### Provider Families
- `provider_{provider_id}_{media}_{spotlight|trending|popular|genre_{genre}}`

### Search Contracts
- `search_movies`
- `search_tvshows`

## D-003 View Mode Matrix
- Home/1101/1102: `Combined` baseline
- 1103/1104: Optional hub slots (off by default)
- Search: `Custom_1105_Search.xml` with `Combined` layout baseline

## D-015 Contract Schema
- All contract families use consistent payload schema
- Spotlight: non-paginated heroes
- Paginated lists: in-row cap 10, next-page flow, full list 40/page
- Image-only cards on all contracted row families

## D-021 Context Menu Policy
- Curated expanded context menu
- Keep/remove decisions documented in D-021 ledger
- Deferred items routed to Phase 5

## D-038 Legacy Properties
- Batch A: Removals and policy decisions
- Batch B: Actions and paths background
- All exceptions documented with owner and rationale
