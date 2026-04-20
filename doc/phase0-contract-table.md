# Phase 0 contract table (second pass)

This second pass expands from the first-pass migration table into a broader contract inventory covering active runtime contracts in `1080i/`, `shortcuts/`, startup defaults, and dependency gates.

Implementation playbook for agents: [`phase1-implementation-instructions.md`](phase1-implementation-instructions.md).

## A) First-pass migration table (kept)

| Surface | UI source key | Current path/action | Current dependency | Target Velocity action | Params needed | Pagination mode | Notes / migration risk |
|---|---|---|---|---|---|---|---|
| Home | `HomeSwitcher.Home.Shortcut.Path` (startup default) | `ActivateWindow(1181)` | AF3 window routing | `plugin://plugin.video.velocity2/?action=home` | none | browse | Current default is internal AF3 window activation, not Velocity. |
| Spotlight | `HomeSwitcher.Home.Spotlight.Path` (startup default) | `special://skin/extras/playlists/RandomMovies.xsp` | local Kodi smart playlist | `plugin://plugin.video.velocity2/?action=list&list_id=<spotlight_list>&page=1&paginate=false` | `list_id`, `paginate=false`, optional `limit` | spotlight | Needs dedicated non-paginated feed to avoid `Next Page >>` leakage into hero. |
| Home widgets | `HomeSwitcher.<window>.Shortcut.Path` and `HomeSwitcher.<window>.Spotlight.Path` | Dynamic Skin.String-driven sources (currently mixed legacy/plugin paths) | AF3 + TMDbHelper-era assumptions | `plugin://plugin.video.velocity2/?action=list&list_id=<id>&page=1` or `?action=smart_list&type=<type>` | `list_id` or `type`, optional `page` | widget | Container logic is ready, but path sources must be migrated to Velocity wrappers. |
| Search widget: Movies (TMDb) | `DefaultSearch-TMDBMovies` alias | `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=movie&query=` | TMDbHelper alias resolver | `plugin://plugin.video.velocity2/?action=execute_search&q=<query>` | `q` | browse | Replace alias mapping in search resolver/generator config. |
| Search widget: TV (TMDb) | `DefaultSearch-TMDBShows` alias | `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=tv&query=` | TMDbHelper alias resolver | `plugin://plugin.video.velocity2/?action=execute_search&q=<query>` | `q` | browse | Same endpoint as movie search; filtering strategy can be phase-2 refinement. |
| Search discover trigger | `RunPlugin(...info=user_discover...)` in search includes | `RunPlugin(plugin://plugin.video.themoviedb.helper/?info=user_discover...)` | TMDbHelper runtime call | `plugin://plugin.video.velocity2/?action=discovery` | optional `preset_id` | browse | Replace direct `RunPlugin` call with Velocity discovery entry. |
| OSD episodes rail | `Path_OSD_Episodes` fallback | `plugin://plugin.video.themoviedb.helper/?info=episodes...` | TMDbHelper | `plugin://plugin.video.velocity2/?action=view_season&show_id=<id>&season=<n>` | `show_id`, `season` | browse | Requires reliable `show_id` source from current playing item context. |
| OSD cast rail | `Path_OSD_Cast` | `plugin://plugin.video.themoviedb.helper/?info=<cast/crew>...` | TMDbHelper | `TBD` | TBD | browse | No direct cast endpoint in current Velocity plugin contract; likely skin-level simplification in Phase 4. |
| OSD next recommendation | `Path_OSD_NextRecommendation` | `plugin://plugin.video.themoviedb.helper/?info=next_recommendation...` | TMDbHelper | `plugin://plugin.video.velocity2/?action=smart_list&type=recently_watched` (interim) | `type` | widget | True recommendation parity is not contract-defined yet; use smart rail as interim behavior. |
| Info online seasons | `Path_VideoInfo_OnlineSeasons` | `plugin://plugin.video.themoviedb.helper/?info=seasons...` | TMDbHelper | `plugin://plugin.video.velocity2/?action=view_show&id=<tv-id>` | `id` | browse | Use show view as canonical season entry point. |
| Info online recommendations | `Path_VideoInfo_OnlineRecommendations` | `plugin://plugin.video.themoviedb.helper/?info=recommendations...` | TMDbHelper | `plugin://plugin.video.velocity2/?action=discover` (interim) | optional `preset_id` | browse | Recommendation-specific parity still TBD in Velocity contract. |
| Skin dependency gate | `addon.xml` import | `<import addon="plugin.video.themoviedb.helper" .../>` | hard dependency | keep TMDbHelper for transition, then remove in Phase 1 | none | n/a | Must be removed only after route/property parity is good enough to avoid startup breakage. |

## B) Full contract inventory (second pass)

### B1) Plugin URL contract families in active runtime

| Contract family | Current base/action style | Primary files | Notes |
|---|---|---|---|
| TMDbHelper `plugin://` contracts | `plugin://plugin.video.themoviedb.helper/?info=...` | `1080i/Includes_Paths.xml`, `1080i/Includes_DialogInfo.xml`, `1080i/Includes_Search.xml`, `1080i/Includes_NextAired.xml`, `1080i/Dialog_DialogView.xml`, `1080i/Custom_1114_Dialog_CustomPlot.xml` | Dominant media metadata and discovery surface. |
| SkinVariables helper contracts | `plugin://script.skinvariables/?info=...` | `1080i/Includes_Search.xml`, `1080i/Dialog_DialogShortcuts.xml`, `1080i/Custom_1117_Dialog_IconSelector.xml`, `1080i/DialogMusicInfo.xml` | Used for shortcut editing and encoded query flows. |
| Autocomplete plugin contracts | `plugin://plugin.program.autocompletion?...` | `1080i/Includes_Search.xml` | Search assist contract. |
| YouTube plugin contracts | `plugin://plugin.video.youtube/...` | `1080i/Includes_Paths.xml`, `1080i/Includes_DialogInfo.xml` | Non-core but wired into some discovery/info paths. |
| Velocity plugin contracts in active XML | `plugin://plugin.video.velocity2/?...` | none in active `1080i` | Important gap: documented target exists, active runtime does not. |

### B2) `RunPlugin` and `RunScript` command contracts

| Contract type | Current command patterns | Primary files | Migration relevance |
|---|---|---|---|
| TMDbHelper `RunPlugin` | `RunPlugin(plugin://plugin.video.themoviedb.helper/?info=user_discover...)` | `1080i/Includes_Search.xml` | Direct browse/discovery trigger to replace. |
| TMDbHelper `RunScript` | `RunScript(plugin.video.themoviedb.helper,...)` with args like `playmedia`, `call_path`, `add_tmdb`, `related_lists`, `sync_trakt`, `restart_service`, `blur_image` | `1080i/Includes_Actions.xml`, `1080i/Dialog_DialogPlot.xml`, `1080i/Dialog_DialogContextMenu.xml`, `1080i/DialogVideoInfo.xml`, `1080i/Dialog_DialogPVRInfo.xml`, `1080i/Dialog_DialogCustom.xml` | High-risk behavior contract layer, not just paths. |
| SkinVariables `RunPlugin` action API | `func=do_move|do_new|do_list_add|do_delete|do_refresh|do_edit|do_toggle|do_numeric|do_icon` | `1080i/Dialog_DialogShortcuts.xml`, `1080i/Includes_Actions.xml`, `1080i/Custom_1117_Dialog_IconSelector.xml` | Keep; not Velocity replacement target. |

### B3) Property contracts (state model contracts)

| Property namespace | Contract examples | Primary files | Notes |
|---|---|---|---|
| `TMDbHelper.*` / `TMDBHelper.*` | `TMDbHelper.ListItem.Monitor.*`, `TMDbHelper.Player.*`, `TMDbHelper.UserDiscover.*`, `TMDbHelper.WidgetContainer`, `TMDBHelper.IsUpdating*`, `TMDBHelper.CurrentWindow` | Widespread across `1080i/*.xml`, especially `Includes_Paths.xml`, `Includes_DialogInfo.xml`, `Includes_Hubs.xml`, `Includes_Widgets.xml`, `Includes_Overlay.xml`, `Custom_1193_VideoOSDInfo.xml` | Core blindspot: property parity is as important as URL parity. |
| `HomeSwitcher.*` | `HomeSwitcher.Home.Shortcut.Path`, `HomeSwitcher.Home.Spotlight.Path/Target/Label`, `HomeSwitcher.<window>.Mode`, `HomeSwitcher.IsVisible` | `shortcuts/skinvariables-startup.json`, `1080i/Includes_Hubs.xml`, `1080i/Includes_Home.xml`, `1080i/Includes_SkinSettings.xml` | Home/spotlight contract surface to preserve while swapping providers. |

### B4) Path variable contracts (`Path_*`)

Primary definition hub: `1080i/Includes_Paths.xml`.

Most migration-critical families:
- OSD: `Path_OSD_Episodes`, `Path_OSD_Cast`, `Path_OSD_NextRecommendation`
- Info/detail: `Path_VideoInfo_OnlineSeasons`, `Path_VideoInfo_OnlineFlatSeasons`, `Path_VideoInfo_OnlineRecommendations`, `Path_VideoInfo_OnlineComments`, `Path_VideoInfo_OnlineFanart`, `Path_VideoInfo_OnlineCast`, `Path_VideoInfo_OnlineCollection`, `Path_VideoInfo_Trailers`
- Query typing/context: `Path_Param_Query`, `Path_Param_Type`, `Path_Param_Number`, `Path_InfoParams_TMDbType`, `Path_InfoParams_TMDbID`, `Path_ContextParams_TMDbType`
- People expansion: `Path_FromWriter`, `Path_FromDirector`

### B5) Alias contracts (`DefaultSearch-*`) and resolver contracts

Authoritative resolver file: `shortcuts/generator/data/setup/search_path.xml` (`widget_path`, `widget_path_end`, `widget_target`, `widget_search_variable` rules).

Aliases currently exposed/configured in `shortcuts/skinvariables-shortcut-config.json`:

- Kodi/library-oriented: `DefaultSearch-Movies`, `DefaultSearch-TvShows`, `DefaultSearch-Episodes`, `DefaultSearch-MovieActors`, `DefaultSearch-TVShowActors`, `DefaultSearch-MovieDirectors`, `DefaultSearch-Plot`, `DefaultSearch-Tagline`, `DefaultSearch-Outline`, `DefaultSearch-Tags`, `DefaultSearch-Genres`, `DefaultSearch-Year`, `DefaultSearch-Studio`, `DefaultSearch-Country`, `DefaultSearch-Actor`, `DefaultSearch-Director`
- Music-oriented: `DefaultSearch-Albums`, `DefaultSearch-Artists`, `DefaultSearch-Songs`, `DefaultSearch-MusicVideos`, `DefaultSearch-MusicVideoArtists`
- External provider-oriented: `DefaultSearch-Youtube`, `DefaultSearch-Netflix`, `DefaultSearch-Hulu`, `DefaultSearch-DisneyPlus`, `DefaultSearch-ABCiView`, `DefaultSearch-7plus`, `DefaultSearch-9now`, `DefaultSearch-10play`, `DefaultSearch-SpotifyArtists`, `DefaultSearch-SpotifyAlbums`, `DefaultSearch-SpotifySongs`, `DefaultSearch-SpotifyPlaylists`, `DefaultSearch-RadioDE`
- TMDbHelper-oriented: `DefaultSearch-TMDBMovies`, `DefaultSearch-TMDBShows`, `DefaultSearch-TMDBSets`, `DefaultSearch-TMDBPeople`, `DefaultSearch-TMDBKeywords`, `DefaultSearch-TMDBListsTrakt`, `DefaultSearch-TMDBListsMDBList`

Search widget presets in `shortcuts/skinvariables-shortcut-searchwidgets.json` currently include both library aliases and TMDb aliases:
- `DefaultSearch-Movies`, `DefaultSearch-TvShows`, `DefaultSearch-Albums`, `DefaultSearch-Artists`, `DefaultSearch-TMDBMovies`, `DefaultSearch-TMDBShows`

### B6) Startup default contracts

From `shortcuts/skinvariables-startup.json`:
- `HomeSwitcher.Home.Shortcut.Path = ActivateWindow(1181)`
- `HomeSwitcher.Home.Spotlight.Path = special://skin/extras/playlists/RandomMovies.xsp`
- `HomeSwitcher.Home.Spotlight.Target = videos`
- `HomeSwitcher.Home.Spotlight.Label = Random Movies`
- TMDbHelper startup flags and calls are set during init (`TMDbHelper.EnableData`, `TMDbHelper.Service`, and `RunScript(plugin.video.themoviedb.helper,...)` patterns).

### B7) Dependency contracts

- Compile/install dependency in `addon.xml`:
  - `<import addon="plugin.video.themoviedb.helper" version="6.14.3" />`
- Runtime gating in shortcuts:
  - `System.HasAddon(plugin.video.themoviedb.helper)` guarded menu entries.
- Runtime calls in startup and UI actions:
  - Multiple `RunScript(plugin.video.themoviedb.helper,...)` and TMDbHelper plugin URLs.

### B8) Documented target Velocity contracts (source of truth)

Target action set is documented in `doc/velocity-addon-reference-for-skin-forks.md` and includes:
- `action=home`
- `action=list&list_id=<id>&page=<n>`
- `action=smart_list&type=<type>`
- `action=discovery` / `action=discover`
- `action=search_hub` / `action=execute_search&q=<query>`
- `action=view_show&id=<tv-id>`
- `action=view_season&show_id=<id>&season=<n>`
- `action=play&id=<internal_id>` / `action=select&id=<internal_id>`

## Phase 0 readiness verdict (second pass)

- **Coverage:** Required surfaces are now mapped in one place (home, widgets, spotlight, info, OSD).
- **Second-pass finding:** Active contracts are broader than first pass (URL + script command + property-state + alias-resolver + startup defaults + dependency gates).
- **Biggest blocker:** Active runtime is still TMDbHelper-centric across all those contract layers.
- **Velocity status:** Velocity contract is documented, but not yet wired into active XML/shortcut contracts.
- **Outcome:** We now have both the migration table and a broader contract inventory to guide a staged replacement without hidden assumptions.

## Phase 1 handoff backlog (ordered)

1. Create `Includes_Velocity_Paths.xml` wrapper variables and switch one representative route per surface to wrapper usage.
2. Replace search aliases `DefaultSearch-TMDBMovies` and `DefaultSearch-TMDBShows` with Velocity search mappings.
3. Replace direct search discover `RunPlugin(plugin.video.themoviedb.helper...)` calls with Velocity discovery actions.
4. Migrate spotlight to explicit non-paginated Velocity list contract (`paginate=false`, fixed `limit`).
5. Replace OSD/info routes that have clear Velocity equivalents first (`view_show`, `view_season`, smart rails), mark cast/recommendation parity as temporary `TBD`.
6. After routes stabilize, remove hard TMDbHelper dependency from `addon.xml` and clean residual helper-only settings.
