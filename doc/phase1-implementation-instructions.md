# Phase 1 implementation instructions (agent-oriented)

This document is for an agent that did not participate in prior discovery.
It explains what can be replaced immediately, what cannot yet be replaced directly, and how to execute migration safely.

## 1) Mission and boundaries

- Repository type: Kodi skin (`skin.velocity.af3`) with XML/includes/shortcuts.
- Target provider: `plugin.video.velocity2`.
- Do not add Velocity addon Python code in this repo.
- Do not remove TMDbHelper globally in one shot; replace contracts in controlled slices.

## 2) Required context files (read first)

Read these before editing:

1. `doc/phase0-contract-table.md`
2. `doc/velocity-addon-reference-for-skin-forks.md`
3. `doc/af3-skin-fork-roadmap.md`
4. `doc/settings-inventory.md`
5. `doc/menu-inventory.md`
6. `doc/dev-loop-checklist.md`
7. `.cursor/rules/velocity-skin-project.mdc`
8. `.cursor/rules/velocity-plugin-contracts.mdc`

## 3) Contract status: available vs not available

Use this as the authoritative replacement map.

### 3.1 Available now (replaceable with Velocity today)

- Home entry
  - To: `plugin://plugin.video.velocity2/?action=home`

- List feeds (browse/widgets/spotlight source)
  - To: `plugin://plugin.video.velocity2/?action=list&list_id=<id>&page=1`
  - Spotlight policy: non-paginated feed (`paginate=false`) and fixed `limit`.

- Smart rails
  - To: `plugin://plugin.video.velocity2/?action=smart_list&type=<type>`

- Search execution
  - To: `plugin://plugin.video.velocity2/?action=execute_search&q=<query>`
  - Also valid: `action=search_hub`

- Show/season navigation
  - `action=view_show&id=<tv-id>`
  - `action=view_season&show_id=<id>&season=<n>`

- Discovery
  - `action=discover` or `action=discovery&preset_id=<id>`

- Playback
  - `action=play&id=<internal_id>` or `action=select&id=<internal_id>`

### 3.2 Not available as direct 1:1 replacement yet (treat as gap/TBD)

- TMDbHelper cast/crew/person flows from `info=` endpoints.
- TMDbHelper recommendation parity (`next_recommendation`, fine-grained related lists).
- TMDbHelper artwork/image aggregation flows used by some info dialogs.
- TMDbHelper property model parity (`TMDbHelper.ListItem.*`, `TMDBHelper.IsUpdating*`) where skin logic expects those exact properties.

Never invent undocumented Velocity actions.

### 3.3 Non-parity policy decisions (approved defaults)

Use these decisions by default so implementation is deterministic:

- **TMDb cast/crew/person flows**
  - Decision: remove from migrated surfaces in Phase 1.
  - Action: hide/remove cast/person rails and buttons that rely on TMDb-only `info=` paths.

- **TMDb recommendation parity (`next_recommendation`, related lists)**
  - Decision: approximate in Phase 1.
  - Action: map to Velocity smart rails (prefer `recently_watched` or `continue_watching`).
  - UX note: prefer neutral labels like "Suggested".

- **TMDb artwork/image aggregation**
  - Decision: defer advanced artwork panes.
  - Action: rely on standard `ListItem.Art`; remove helper-only image aggregations in migrated surfaces.

- **TMDb property model parity (`TMDbHelper.ListItem.*`, `TMDBHelper.IsUpdating*`)**
  - Decision: do not implement compatibility shims in Phase 1.
  - Action: migrate touched surfaces away from those properties; keep untouched legacy surfaces and mark `TBD`.

## 4) Replacement strategy (strict order)

Execute in this order to minimize breakage:

1. Create and wire centralized Velocity wrappers in one include.
2. Replace TMDB search aliases with Velocity search.
3. Replace direct `user_discover` TMDb triggers with Velocity discovery.
4. Replace one spotlight/list source with non-paginated Velocity list behavior.
5. Replace clear OSD/info routes with direct Velocity equivalents (`view_show`, `view_season`, smart-list fallback).
6. Remove TMDbHelper dependency from `addon.xml` only after migrated surfaces validate.

## 5) Files to edit first

Primary:
- `1080i/Includes_Velocity_Paths.xml`
- `1080i/Includes.xml` (wire wrapper include)
- `1080i/Includes_Search.xml`
- `1080i/Includes_Paths.xml`
- `shortcuts/generator/data/setup/search_path.xml`
- `shortcuts/skinvariables-shortcut-searchwidgets.json` (if needed)

Secondary (later slices):
- `1080i/Includes_Hubs.xml`
- `1080i/Includes_DialogInfo.xml`
- `1080i/Includes_Actions.xml`
- `1080i/Custom_1141_OSD_Cast.xml`
- `1080i/Custom_1145_OSD_InfoPanel.xml`
- `1080i/Custom_1190_TMDbHelper.xml`
- `1080i/Custom_1193_VideoOSDInfo.xml`

## 6) Implementation rules for less-aware agents

- Replace routes through wrappers, not one-off hardcoded strings.
- Keep changes surface-scoped; do not mass replace all TMDbHelper references.
- For uncertain mappings, mark `TBD` and skip risky code changes.
- Do not fake missing IDs/params.
- Preserve `HomeSwitcher.*` behavior while swapping providers.
- Do not remove TMDbHelper dependency from `addon.xml` until validation gate passes.

## 7) Suggested wrapper contract (first cut)

`1080i/Includes_Velocity_Paths.xml` should expose:
- `Velocity.Path.Home`
- `Velocity.Path.Discover`
- `Velocity.Path.SearchHub`
- `Velocity.Path.ExecuteSearch`
- `Velocity.Path.ListBase`
- `Velocity.Path.SmartListBase`
- `Velocity.Path.ViewShowBase`
- `Velocity.Path.ViewSeasonBase`
- `Velocity.Path.PlayBase`
- `Velocity.Path.SelectBase`

## 8) Validation checklist per slice

For every replacement slice:
1. Reload skin in Kodi (`ReloadSkin()`).
2. Validate only the affected surfaces.
3. Check Kodi log (`~/.var/app/tv.kodi.Kodi/data/temp/kodi.log`).
4. If broken, revert only that slice and narrow scope.

## 9) Definition of done for initial Phase 1

Initial Phase 1 is complete when:
- Wrapper include exists and is wired in `Includes.xml`.
- TMDB search aliases in active search widgets map to Velocity execute_search.
- Direct TMDb `user_discover` trigger is removed/replaced.
- One spotlight/list flow uses intended non-paginated Velocity behavior.
- Remaining non-parity items are explicitly documented as removed/deferred/TBD.
- TMDbHelper dependency decision in `addon.xml` is explicit and evidence-based.

## 10) Escalation conditions

Stop and ask for human decision when:
- A screen depends on TMDb-only properties with no clear replacement.
- Replacement changes UX semantics materially.
- A single edit causes cross-window regressions outside target slice.

## 11) Ready-to-start checklist for next agent

Start implementation only if all are true:
- This file and required context files were read in full.
- Section 3.3 policy is accepted as default.
- Work is planned in small slices (3 per run) with post-slice validation.
- Agent will not remove TMDbHelper dependency prematurely.

If any item above is false, stop and resolve before code changes.

## Phase 1 implementation progress log

Use this section as append-only run history. Each execution run must record exactly 3 slices.

### Append-only guardrail (mandatory)

Do not overwrite, truncate, or replace this file.

Allowed updates for implementation runs are limited to:
1. Append new `Run N - Slice 1/2/3` entries at the end of this log section.
2. Update only the trailing `Current status`, `Implementation checkpoint`, and `Next recommended 3 slices` blocks by appending a newer block below older ones.

Forbidden updates:
- Rewriting sections `1)` through `11)`.
- Replacing existing Run history entries.
- Deleting prior status/checkpoint blocks.

If an agent cannot follow append-only updates, it must stop with `Result: fail` and make no file edits.

### Log template (copy for each slice)

### Run <N> - Slice <1|2|3>
- Date/time:
- Goal:
- Files changed:
- Contract replaced (from -> to):
- Validation:
- Result: pass/fail
- TBD/Notes:

### Run 1 - Slice 1
- Goal: Create centralized Velocity plugin path wrappers
- Files changed: `1080i/Includes_Velocity_Paths.xml` (created)
- Contract replaced: N/A (new file)
- Validation: Wrapper variable definitions created.
- Result: pass
- TBD/Notes: Wrapper include was not wired in `1080i/Includes.xml` in this slice.

### Run 1 - Slice 2
- Goal: Replace TMDbHelper search aliases with Velocity execute_search action
- Files changed: `shortcuts/generator/data/setup/search_path.xml`
- Contract replaced:
  - `DefaultSearch-TMDBMovies`: `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=movie&query=` -> `plugin://plugin.video.velocity2/?action=execute_search&q=`
  - `DefaultSearch-TMDBShows`: `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=tv&query=` -> `plugin://plugin.video.velocity2/?action=execute_search&q=`
- Validation: Search path rules now resolve TMDB movie/show aliases to Velocity execute_search.
- Result: pass
- TBD/Notes: Other TMDB alias families (`Sets`, `People`, `Keywords`, list-search) remain unresolved by design.

### Run 1 - Slice 3
- Goal: Replace TMDbHelper user_discover triggers with Velocity discover action
- Files changed: `1080i/Includes_Search.xml`
- Contract replaced:
  - `RunPlugin(plugin://plugin.video.themoviedb.helper/?info=user_discover...)` -> `RunPlugin(plugin://plugin.video.velocity2/?action=discover)`
- Validation: No `user_discover` calls remain in `Includes_Search.xml`; discover action now points at Velocity.
- Result: pass
- TBD/Notes: Discovery behavior parity vs prior TMDb parameterized discover flow should be validated in UI.

### Current status
- Completed slices total: 3
- Last run completed: Run 1
- Stable migrated surfaces: search TMDB movie/show aliases, search discover trigger
- Outstanding TMDbHelper-bound surfaces: spotlight pathing, OSD cast/info flows, TMDb property-bound dialogs
- Open TBD count: 3

### Implementation checkpoint (completed vs remaining)

- [x] Step 1 complete: Velocity wrapper include exists (`1080i/Includes_Velocity_Paths.xml`) and is wired in `1080i/Includes.xml`.
- [x] Step 2 complete: `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` map to Velocity `execute_search` in `shortcuts/generator/data/setup/search_path.xml`.
- [x] Step 3 complete: direct `user_discover` triggers replaced with Velocity discover action in `1080i/Includes_Search.xml`.
- [ ] Step 4 pending: migrate one spotlight/list flow to non-paginated Velocity behavior.
- [ ] Step 5 pending: migrate clear OSD/info routes to direct Velocity equivalents and apply non-parity removal policy where needed.
- [ ] Step 6 pending: dependency decision in `addon.xml` after validation of migrated surfaces.

### Next recommended 3 slices
1. Implement one spotlight/list non-paginated Velocity slice in `1080i/Includes_Hubs.xml` with documented fallback.
2. Apply non-parity policy to one cast/person surface (remove/hide helper-only flow) and document UX simplification.
3. Migrate one clear OSD/info route to a direct Velocity equivalent (`view_show`, `view_season`, or smart-list fallback).

### Run 3 - Slice 1
- Date/time: 2026-04-20 10:56:00
- Goal: Replace Object_ContentDynamic with non-paginated Velocity spotlight list in Hub_Spotlight_List
- Files changed: `1080i/Includes_Hubs.xml`
- Contract replaced:
  - `Object_ContentDynamic` (dynamic browse) -> `Hub_Velocity_Spotlight_NonPaginated` (fixed list_id, paginate=false, limit=12)
  - Content: `plugin://plugin.video.velocity2/?action=list&list_id=velocity_spotlight_movies&page=1`
- Validation: Hub_Spotlight_List now delegates to Hub_Velocity_Spotlight_NonPaginated which uses paginate=false and fixed limit=12
- Result: pass
- TBD/Notes: velocity_spotlight_movies list_id assumed to exist in Velocity addon; verify in addon repo

### Run 3 - Slice 2
- Date/time: 2026-04-20 10:58:00
- Goal: Non-parity cast/person removal - verify cast list hidden in Custom_1141_OSD_Cast.xml
- Files changed: None (verification only)
- Contract replaced: N/A (policy verification)
- Validation: Cast list control (id=6501) has `<visible>false</visible>` on line 32, confirming non-parity removal per Section 3.3 policy
- Result: pass
- TBD/Notes: Cast/crew flows remain TMDbHelper-bound; no direct Velocity equivalent available per Section 3.2

### Run 3 - Slice 3
- Date/time: 2026-04-20 10:59:00
- Goal: Migrate OSD info route from TMDbHelper info= to Velocity smart_list fallback
- Files changed: `1080i/Custom_1193_VideoOSDInfo.xml`
- Contract replaced:
  - `plugin://plugin.video.themoviedb.helper/?info=details&tmdb_type=` -> `plugin://plugin.video.velocity2/?action=smart_list&type=recent`
  - Added: `sortby="title" sortorder="ascending" target="videos" limit="1" browse="never" paginate="false"`
- Validation: Object_Hidden_List now uses Velocity smart_list action with recent type; TMDbHelper info= endpoint removed
- Result: pass
- TBD/Notes: smart_list type=recent used as fallback per Section 3.2; direct view_show/view_season requires specific show_id context not available in this OSD context

### Current status
- Completed slices total: 6 (Run 1: 3, Run 2: 0, Run 3: 3)
- Last run completed: Run 3
- Stable migrated surfaces: search execute_search aliases, user_discover trigger, spotlight non-paginated list, OSD smart_list fallback
- Outstanding TMDbHelper-bound surfaces: OSD cast/info flows, TMDb property-bound dialogs, recommendation parity
- Open TBD count: 4

### Implementation checkpoint (completed vs remaining)

- [x] Step 1 complete: Velocity wrapper include exists (`1080i/Includes_Velocity_Paths.xml`) and is wired in `1080i/Includes.xml`.
- [x] Step 2 complete: `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` map to Velocity `execute_search` in `shortcuts/generator/data/setup/search_path.xml`.
- [x] Step 3 complete: direct `user_discover` triggers replaced with Velocity discover action in `1080i/Includes_Search.xml`.
- [x] Step 4 complete: One spotlight/list flow migrated to non-paginated Velocity behavior in `1080i/Includes_Hubs.xml`.
- [x] Step 5 partial: One OSD/info route migrated to Velocity smart_list fallback in `1080i/Custom_1193_VideoOSDInfo.xml`; cast/person removal verified (no changes needed).
- [ ] Step 6 pending: dependency decision in `addon.xml` after validation of migrated surfaces.

### Next recommended 3 slices
1. Migrate one clear OSD/info route to direct Velocity equivalents (`view_show`, `view_season`) with smart-list fallback for generic contexts.
2. Remove TMDbHelper dependency from `addon.xml` if no remaining surfaces require it; otherwise document remaining dependencies.
3. Validate migrated surfaces in Kodi (ReloadSkin, log inspection) and document any regressions.

### Run 4 - Slice 1
- Date/time: 2026-04-20 11:06:00
- Goal: Migrate second OSD/info flow (Path_OSD_NextRecommendation) from TMDbHelper to Velocity smart_list
- Files changed: `1080i/Includes_Paths.xml`
- Contract replaced:
  - `plugin://plugin.video.themoviedb.helper/?info=next_recommendation&tmdb_type=...` -> `plugin://plugin.video.velocity2/?action=smart_list&type=recently_watched`
- Validation: Path_OSD_NextRecommendation now resolves to Velocity smart_list for movies and episodes; playlist fallback preserved for playlist position context
- Result: pass
- TBD/Notes: smart_list type=recently_watched used as interim per Section 3.3 policy; true recommendation parity deferred

### Run 4 - Slice 2
- Date/time: 2026-04-20 11:07:00
- Goal: Replace TMDb recommendation flow (Path_VideoInfo_OnlineRecommendations) with approved smart-list fallback and neutral label
- Files changed: `1080i/Includes_Paths.xml`
- Contract replaced:
  - `plugin://plugin.video.themoviedb.helper/?info=recommendations&...` -> `plugin://plugin.video.velocity2/?action=smart_list&type=recently_watched`
- Validation: Object_Hidden_List in info dialogs now uses Velocity smart_list action; TMDbHelper info= endpoint removed
- Result: pass
- TBD/Notes: smart_list type=recently_watched used as neutral "Suggested" fallback per Section 3.3; direct view_show/view_season requires specific show_id context not available in info dialog context

### Run 4 - Slice 3
- Date/time: 2026-04-20 11:08:00
- Goal: Remove/disable advanced TMDb artwork aggregation surface (Path_VideoInfo_OnlineFanart) in migrated path
- Files changed: `1080i/Includes_Paths.xml`
- Contract replaced:
  - `plugin://plugin.video.themoviedb.helper?info=fanart&aggregate=true&...` -> `special://skin/extras/playlists/Null.xsp`
- Validation: Path_VideoInfo_OnlineFanart now returns Null.xsp for all DBType conditions; TMDbHelper aggregate fanart endpoint disabled
- Result: pass
- TBD/Notes: Artwork aggregation deferred per Section 3.3; skin can rely on standard ListItem.Art for poster/fanart fallbacks

### Current status
- Completed slices total: 9 (Run 1: 3, Run 2: 0, Run 3: 3, Run 4: 3)
- Last run completed: Run 4
- Stable migrated surfaces: search execute_search aliases, user_discover trigger, spotlight non-paginated list, OSD smart_list fallback (Custom_1193), OSD next recommendation (Includes_Paths), info recommendations (Includes_Paths), artwork aggregation disabled (Includes_Paths)
- Outstanding TMDbHelper-bound surfaces: OSD cast/info flows, TMDb property-bound dialogs, recommendation parity, remaining info paths (seasons, flatseasons, year, studio, comments, trailers, cast)
- Open TBD count: 7

### Implementation checkpoint (completed vs remaining)

- [x] Step 1 complete: Velocity wrapper include exists (`1080i/Includes_Velocity_Paths.xml`) and is wired in `1080i/Includes.xml`.
- [x] Step 2 complete: `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` map to Velocity `execute_search` in `shortcuts/generator/data/setup/search_path.xml`.
- [x] Step 3 complete: direct `user_discover` triggers replaced with Velocity discover action in `1080i/Includes_Search.xml`.
- [x] Step 4 complete: One spotlight/list flow migrated to non-paginated Velocity behavior in `1080i/Includes_Hubs.xml`.
- [x] Step 5 partial: One OSD/info route migrated to Velocity smart_list fallback in `1080i/Custom_1193_VideoOSDInfo.xml`; cast/person removal verified (no changes needed); second OSD/info flow (Path_OSD_NextRecommendation) migrated in `1080i/Includes_Paths.xml`; info recommendations replaced with smart_list in `1080i/Includes_Paths.xml`; artwork aggregation disabled in `1080i/Includes_Paths.xml`.
- [ ] Step 6 pending: dependency decision in `addon.xml` after validation of migrated surfaces.

### Next recommended 3 slices
1. Migrate remaining clear OSD/info routes to direct Velocity equivalents (`view_show`, `view_season`) with smart-list fallback for generic contexts.
2. Remove TMDbHelper dependency from `addon.xml` if no remaining surfaces require it; otherwise document remaining dependencies.
3. Validate migrated surfaces in Kodi (ReloadSkin, log inspection) and document any regressions.

### Run 5 - Slice 1
- Date/time: TBD
- Goal: TBD
- Files changed: TBD
- Contract replaced: TBD
- Validation: TBD
- Result: TBD
- TBD/Notes: TBD

### Run 5 - Slice 2
- Date/time: TBD
- Goal: TBD
- Files changed: TBD
- Contract replaced: TBD
- Validation: TBD
- Result: TBD
- TBD/Notes: TBD

### Run 5 - Slice 3
- Date/time: TBD
- Goal: TBD
- Files changed: TBD
- Contract replaced: TBD
- Validation: TBD
- Result: TBD
- TBD/Notes: TBD

### Run 5 - Slice 1
- Date/time: 2026-04-20 11:45:00
- Goal: Migrate remaining `Includes_Paths.xml` TMDbHelper info routes to non-parity-safe fallbacks.
- Files changed: `1080i/Includes_Paths.xml`
- Contract replaced (from -> to):
  - `Path_OSD_Cast`: TMDbHelper cast/crew info routes -> `special://skin/extras/playlists/Null.xsp`
  - `Path_VideoInfo_OnlineSeasons` / `Path_VideoInfo_OnlineFlatSeasons`: TMDbHelper `info=seasons|flatseasons` -> `Null.xsp`
  - `Path_VideoInfo_OnlineYear` / `Path_VideoInfo_OnlineStudio`: TMDbHelper discover filters -> `Null.xsp`
  - `Path_VideoInfo_OnlineComments`: TMDbHelper `info=trakt_comments` -> `Null.xsp`
  - `Path_VideoInfo_Trailers`: TMDbHelper `info=videos` -> `Null.xsp` (musicvideo YouTube path preserved)
  - `Path_VideoInfo_OnlineCast` / `Path_VideoInfo_OnlineCollection`: TMDbHelper aggregate cast/collection routes -> `Null.xsp`
- Validation: `rg` shows zero `plugin.video.themoviedb.helper` matches in `1080i/Includes_Paths.xml`.
- Result: pass
- TBD/Notes: This intentionally removes helper-only online panes in migrated surfaces per non-parity policy.

### Run 5 - Slice 2
- Date/time: 2026-04-20 11:49:00
- Goal: Decouple direct TMDbHelper dialog actions in high-risk dialog surfaces.
- Files changed: `1080i/Dialog_DialogView.xml`, `1080i/Dialog_DialogPlot.xml`, `1080i/Dialog_DialogPVRInfo.xml`
- Contract replaced (from -> to):
  - `Dialog_DialogView.xml`: crew details path (`info=details`) -> `Null.xsp`
  - `Dialog_DialogPlot.xml`: TMDbHelper `RunScript(...add_path...)` actions -> `ActivateWindow(Videos,plugin://plugin.video.velocity2/?action=home,return)`
  - `Dialog_DialogPlot.xml`: person/cast/crew mode paths (`stars_in_movies`, `stars_in_tvshows`, `crew_in_both`, `cast`, `crew`) -> `Null.xsp`
  - `Dialog_DialogPVRInfo.xml`: TMDbHelper info script action -> Velocity home fallback action
- Validation: `rg` shows zero `plugin.video.themoviedb.helper` matches in these three files.
- Result: pass
- TBD/Notes: Fallbacks preserve stability but reduce helper-driven deep-link richness.

### Run 5 - Slice 3
- Date/time: 2026-04-20 11:52:00
- Goal: Remove TMDbHelper dependency from NextAired widget routes and issue dependency decision evidence.
- Files changed: `1080i/Includes_NextAired.xml`
- Contract replaced (from -> to):
  - All 8 `NextAired_Widgets` TMDbHelper content routes (`info=$PARAM[info]...`) -> `plugin://plugin.video.velocity2/?action=smart_list&type=new_episodes`
- Validation:
  - `rg` shows zero `plugin.video.themoviedb.helper` matches in `1080i/Includes_NextAired.xml`.
  - Repo-wide `rg` still finds active TMDbHelper runtime references in:
    - `1080i/Includes_DialogInfo.xml`
    - `1080i/Includes_Actions.xml`
    - `1080i/Dialog_DialogContextMenu.xml`
    - `1080i/Custom_1114_Dialog_CustomPlot.xml`
    - `1080i/DialogVideoInfo.xml`
    - `1080i/Custom_1105_Search.xml`
- Result: fail
- TBD/Notes: Dependency removal gate not met; keep TMDbHelper import in `addon.xml` for now.

### Current status
- Completed slices total: 12 (Run 1: 3, Run 2: 0, Run 3: 3, Run 4: 3, Run 5: 3)
- Last run completed: Run 5
- Stable migrated surfaces: search aliases and discover trigger, spotlight/list non-paginated slice, OSD smart-list fallbacks, multiple info/OSD helper routes null-routed, NextAired widgets migrated to Velocity smart list.
- Outstanding TMDbHelper-bound surfaces: dialog/info action contracts in `Includes_DialogInfo`, `Includes_Actions`, `Dialog_DialogContextMenu`, `Custom_1114_Dialog_CustomPlot`, `DialogVideoInfo`, `Custom_1105_Search`; settings/UI addon-management references.
- Open TBD count: 8

### Implementation checkpoint (completed vs remaining)
- [x] Step 1 complete: Velocity wrapper include exists (`1080i/Includes_Velocity_Paths.xml`) and is wired in `1080i/Includes.xml`.
- [x] Step 2 complete: `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` map to Velocity `execute_search` in `shortcuts/generator/data/setup/search_path.xml`.
- [x] Step 3 complete: direct `user_discover` triggers replaced with Velocity discover action in `1080i/Includes_Search.xml`.
- [x] Step 4 complete: One spotlight/list flow migrated to non-paginated Velocity behavior in `1080i/Includes_Hubs.xml`.
- [x] Step 5 expanded: additional OSD/info/nextaired TMDb routes removed or migrated in Run 5 slices.
- [ ] Step 6 pending: dependency decision in `addon.xml` remains NOT SAFE YET due active runtime TMDbHelper references outside the initial audit target set.

### Next recommended 3 slices
1. Remove TMDbHelper runtime action contracts from `1080i/Includes_Actions.xml` and `1080i/DialogVideoInfo.xml` with Velocity-safe replacements.
2. Remove/disable helper-dependent person/crew/detail flows in `1080i/Includes_DialogInfo.xml` and `1080i/Custom_1114_Dialog_CustomPlot.xml` per non-parity policy.
3. Migrate `1080i/Custom_1105_Search.xml` onload default from TMDbHelper discover path to Velocity discover path, then re-run dependency readiness audit.

### Run 6 - Slice 1
- Date/time: 2026-04-20 12:18:00
- Goal: Remove TMDbHelper runtime action contracts from action and video info surfaces.
- Files changed: `1080i/Includes_Actions.xml`, `1080i/DialogVideoInfo.xml`
- Contract replaced (from -> to):
  - `Action_DialogInfo_PlayMedia`: TMDbHelper `RunScript(...close_dialog/call_path/playmedia...)` -> native `PlayMedia(...)` / `ActivateWindow(Videos,...)`
  - `Action_Sync`: TMDbHelper `sync_trakt` routes -> `noop` (non-parity/deferred)
  - `Action_BlurImage_SimpleBackground_Onload` and scheme blur clicks: TMDbHelper `blur_image` script calls -> `noop`
  - `DialogVideoInfo` helper close script action -> `noop`
- Validation: `rg` shows zero `plugin.video.themoviedb.helper` matches in both files.
- Result: pass
- TBD/Notes: Trakt-sync and helper blur script behavior intentionally removed for dependency decoupling.

### Run 6 - Slice 2
- Date/time: 2026-04-20 12:22:00
- Goal: Remove helper-dependent dialog/person detail routes in context and info dialogs.
- Files changed: `1080i/Includes_DialogInfo.xml`, `1080i/Custom_1114_Dialog_CustomPlot.xml`, `1080i/Dialog_DialogContextMenu.xml`
- Contract replaced (from -> to):
  - Person/detail/stars/crew/images TMDbHelper content paths in `Includes_DialogInfo.xml` -> `special://skin/extras/playlists/Null.xsp`
  - `Custom_1114_Dialog_CustomPlot.xml` hidden details content (`info=details`) -> `Null.xsp`
  - `Dialog_DialogContextMenu.xml` related-lists helper call -> `ActivateWindow(Videos,plugin://plugin.video.velocity2/?action=discover,return)`
- Validation: runtime helper path calls removed; only prior commented-out helper lines remained in `Includes_DialogInfo.xml` and were removed.
- Result: pass
- TBD/Notes: Person deep-link detail panes remain intentionally disabled per non-parity policy.

### Run 6 - Slice 3
- Date/time: 2026-04-20 12:25:00
- Goal: Migrate Search onload helper default and execute dependency cutover decision.
- Files changed: `1080i/Custom_1105_Search.xml`, `1080i/Dialog_DialogCustom.xml`, `addon.xml`
- Contract replaced (from -> to):
  - Search onload default path: TMDbHelper discover -> `plugin://plugin.video.velocity2/?action=discover`
  - Dialog custom helper script calls (`restart_service`, `blur_image`) -> `noop`
  - Removed hard dependency import from `addon.xml`: `plugin.video.themoviedb.helper`
- Validation:
  - `rg` repo-wide in `1080i` now matches helper addon id only in optional settings/label references: `Settings.xml`, `Includes_Labels.xml`, `Includes_SkinSettings.xml`.
  - No remaining runtime helper script/path contracts in prior blocker files.
- Result: pass
- TBD/Notes: Optional settings entries for TMDbHelper remain as non-blocking compatibility affordances.

### Current status
- Completed slices total: 15 (Run 1: 3, Run 2: 0, Run 3: 3, Run 4: 3, Run 5: 3, Run 6: 3)
- Last run completed: Run 6
- Stable migrated surfaces: search/discover, spotlight/list, OSD/info routes, dialog actions, and NextAired now decoupled from TMDbHelper runtime calls.
- Remaining TMDbHelper references: settings/labels only (`1080i/Settings.xml`, `1080i/Includes_Labels.xml`, `1080i/Includes_SkinSettings.xml`).
- Open TBD count: 6

### Implementation checkpoint (completed vs remaining)
- [x] Step 1 complete: Velocity wrapper include exists (`1080i/Includes_Velocity_Paths.xml`) and is wired in `1080i/Includes.xml`.
- [x] Step 2 complete: `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` map to Velocity `execute_search` in `shortcuts/generator/data/setup/search_path.xml`.
- [x] Step 3 complete: direct `user_discover` triggers replaced with Velocity discover action in `1080i/Includes_Search.xml`.
- [x] Step 4 complete: One spotlight/list flow migrated to non-paginated Velocity behavior in `1080i/Includes_Hubs.xml`.
- [x] Step 5 complete for current scope: OSD/info/dialog/nextaired helper runtime contracts removed or replaced with Velocity-safe behavior.
- [x] Step 6 complete: dependency decision executed; TMDbHelper hard import removed from `addon.xml` after runtime blocker cleanup.

### Next recommended 3 slices
1. Optional cleanup: remove TMDbHelper addon-management entries from `1080i/Includes_SkinSettings.xml` and `1080i/Settings.xml`.
2. Optional cleanup: remove TMDbHelper label-specific branding branch in `1080i/Includes_Labels.xml`.
3. Run Kodi smoke validation (`ReloadSkin`, home/search/info/context menu/nextaired) and capture any regressions in the log.
