# 1. Generator Boundaries & Constraints

## The Golden Rule
Arctic Fuse 3 is generator-driven. 
- **NEVER** edit files in the `1080i/` directory directly (e.g., `Includes_Home.xml`, `Includes_Hubs.xml`).
- **ONLY** edit files in `shortcuts/generator/data/` or the `skinvariables-*.json` files.

## Edit and Replace Contract
When updating XML blueprints:
- Preserve layout and structure perfectly. DO NOT change `<control>`, `<visible>`, `<posx>`, `<width>`, etc.
- Your sole job in these files is to swap out legacy `plugin.video.themoviedb.helper` routes and `$INFO` properties with Velocity equivalents.

## Roadmap Phase Alignment

### Phase 2 & 3 Generator Discipline
- All list contract changes (D-015) must be applied via generator source files first
- Regenerate includes after any generator source modification
- Commit source + generated output together to prevent drift
- Generator output can overwrite direct XML edits if source discipline is skipped

### Phase 3 Generator Pipeline
- `generator-root-config`: Align with D-015 contract families
- `generator-setup-transform-rules`: Apply D-003 view-mode mappings
- `search-widget-alias-family`: Remove or gate legacy alias families per Phase 3 decisions

## D-003 View Mode Locks
- Home/1101/1102 hubs use `Combined` as baseline mode
- `1103`/`1104` remain optional hub slots (off by default after bootstrap)
- Search primary UX uses `Custom_1105_Search.xml`; search layout baseline is `Combined`

## D-015 Contract Families
- Home: `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`
- Series: `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`
- Movies: `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`
- Provider families: `provider_{provider_id}_{media}_{spotlight|trending|popular|genre_{genre}}`
- Search contracts: `search_movies`, `search_tvshows`

## Pagination Guarantees
- Spotlight feeds are STRICTLY non-paginated. Never append `page=` or `next=` to them.
- Row-level paging caps at 10 items in-row with next-page flow
- Full list pages cap at 40 items per page

## Card/Interaction Guarantees
- Image-only cards on all contracted row families
- Discovery defaults to info action
- Progress defaults to play action
- Show progress opens deep-view

## Legacy Property Policy
- See [D-038 ledger](../context/d038-legacy-properties-and-mapping.md) for legacy property mappings
- Batch A: Removals and policy decisions
- Batch B: Actions and paths background
- List-related batches handled in Phase 2

## Generator Verification
- After regeneration, verify generated output matches intended route updates
- Commit source + generated output together
- No stale smart-rail aliases in core contract rows
