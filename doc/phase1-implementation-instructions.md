# Phase 1: Velocity Plugin Migration (Search & Discovery)

## Overview
Migrate search and discovery flows from TMDbHelper addon to Velocity plugin (`plugin.video.velocity2`).

## Phase 1 implementation progress log

### Run 1 - Slice 1
- **Goal:** Create centralized Velocity plugin path wrappers
- **Files changed:** `1080i/Includes_Velocity_Paths.xml` (created)
- **Contract replaced:** N/A (new file)
- **Validation:** File created with 11 Velocity path variables (Home, Discover, SearchHub, ExecuteSearch, ListBase, SmartListBase, ViewShowBase, ViewSeasonBase, PlayBase, SelectBase)
- **Result:** pass
- **TBD/Notes:** None

### Run 1 - Slice 2
- **Goal:** Replace TMDbHelper search aliases with Velocity execute_search action
- **Files changed:** `shortcuts/generator/data/setup/search_path.xml`
- **Contract replaced:**
  - `DefaultSearch-TMDBMovies`: `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=movie&query=` → `plugin://plugin.video.velocity2/?action=execute_search&q=`
  - `DefaultSearch-TMDBShows`: `plugin://plugin.video.themoviedb.helper?info=search&tmdb_type=tv&query=` → `plugin://plugin.video.velocity2/?action=execute_search&q=`
  - `DefaultSearch-TMDBMovies` end: `&nextpage=false&cacheonly=true` → `` (empty)
  - `DefaultSearch-TMDBShows` end: `&nextpage=false&cacheonly=true` → `` (empty)
  - `DefaultSearch-TMDBMovies` target: `videos` → `videos` (unchanged)
  - `DefaultSearch-TMDBShows` target: `videos` → `videos` (unchanged)
  - `DefaultSearch-TMDBMovies` search_variable: `Path_SearchTerm_DoubleEncoded` → `Path_SearchTerm_DoubleEncoded` (unchanged)
  - `DefaultSearch-TMDBShows` search_variable: `Path_SearchTerm_DoubleEncoded` → `Path_SearchTerm_DoubleEncoded` (unchanged)
- **Validation:** grep for `plugin.video.velocity2` in search_path.xml confirms 2 new rules; grep for `plugin.video.themoviedb.helper` shows no matches in TMDB search rules
- **Result:** pass
- **TBD/Notes:** None

### Run 1 - Slice 3
- **Goal:** Replace TMDbHelper user_discover triggers with Velocity discover action
- **Files changed:** `1080i/Includes_Search.xml`
- **Contract replaced:**
  - Line 131: `RunPlugin(plugin://plugin.video.themoviedb.helper/?info=user_discover$INFO[Window(Home).Property(TMDbHelper.UserDiscover.Folderpath.ParamString),&,])` → `RunPlugin(plugin://plugin.video.velocity2/?action=discover)`
  - Line 284: `RunPlugin(plugin://plugin.video.themoviedb.helper/?info=user_discover$INFO[Window(Home).Property(TMDbHelper.UserDiscover.Folderpath.ParamString),&,])` → `RunPlugin(plugin://plugin.video.velocity2/?action=discover)`
- **Validation:** grep for `user_discover` in Includes_Search.xml shows 0 matches; grep for `plugin.video.velocity2` shows 2 matches (the new discover actions)
- **Result:** pass
- **TBD/Notes:** None

## Current status
- **Slices completed:** 3/3
- **Files edited:** 3
  - `1080i/Includes_Velocity_Paths.xml` (created)
  - `shortcuts/generator/data/setup/search_path.xml` (modified)
  - `1080i/Includes_Search.xml` (modified)
- **Validations:** All passed (grep confirmations)
- **Remaining blockers/TBDs:** None

## Next recommended 3 slices
1. **Spotlight/hero non-paginated slice**: Replace TMDbHelper spotlight widget in Home.xml with Velocity smart_list fallback
2. **Clear OSD direct mappings**: Remove TMDbHelper references from OSD windows (Custom_1141_OSD_Cast.xml, Custom_1145_OSD_InfoPanel.xml)
3. **Info direct mappings**: Remove TMDbHelper references from info dialogs (Custom_1190_TMDbHelper.xml, Custom_1193_VideoOSDInfo.xml)