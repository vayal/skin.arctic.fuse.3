# Property Mapping Dictionary

Purpose: define non-guessy translation targets for legacy `TMDbHelper`/`TMDBHelper` properties before XML migration.

Sources:

- [d038-legacy-property-ledger.md](d038-legacy-property-ledger.md)
- [phase-01-02-gap.md](../next/gap-analysis/phase-01-02-gap.md)
- [phase-03-04-gap.md](../next/gap-analysis/phase-03-04-gap.md)
- [phase-05-07-gap.md](../next/gap-analysis/phase-05-07-gap.md)

## Mapping Table

| Legacy property / pattern | Replacement target | Class | Notes |
|---|---|---|---|
| `TMDbHelper.ListItem.Title` | `ListItem.Title` | Native Kodi | Prefer native label first. |
| `TMDbHelper.ListItem.TVShowTitle` | `ListItem.TVShowTitle` | Native Kodi | TV episode/show title chain. |
| `TMDbHelper.ListItem.Year` | `ListItem.Year` | Native Kodi | Use standard year label. |
| `TMDbHelper.ListItem.Plot` | `ListItem.Plot` | Native Kodi | If detailed addon metadata is required, use mapped `tmdb_` property fallback. |
| `TMDbHelper.ListItem.Tagline` | `ListItem.Tagline` | Native Kodi | Direct native field. |
| `TMDbHelper.ListItem.Premiered` | `ListItem.Premiered` | Native Kodi | Date label remains native. |
| `TMDbHelper.ListItem.Genre` | `ListItem.Genre` | Native Kodi | Comma-delimited native genre text. |
| `TMDbHelper.ListItem.Country` | `ListItem.Country` | Native Kodi | Native country label. |
| `TMDbHelper.ListItem.Language` | `ListItem.Property(tmdb_language)` | Velocity/Addon property | Use property form when native language field is not populated consistently. |
| `TMDbHelper.ListItem.Status` | `ListItem.Property(tmdb_status)` | Velocity/Addon property | Used in status badge logic. |
| `TMDbHelper.ListItem.Next_Aired*` | `ListItem.Property(tmdb_next_aired*)` | Velocity/Addon property | Preserve suffix segment (`Date`, `Long`, `Episode`, etc.). |
| `TMDbHelper.ListItem.Last_Aired*` | `ListItem.Property(tmdb_last_aired*)` | Velocity/Addon property | Preserve suffix segment. |
| `TMDbHelper.ListItem.Network.*` | `ListItem.Property(tmdb_network_*)` | Velocity/Addon property | Includes names/logo key style fields. |
| `TMDbHelper.ListItem.Studio.*` | `ListItem.Studio` or `ListItem.Property(tmdb_studio_*)` | Native/Velocity hybrid | Prefer `ListItem.Studio`; use `tmdb_studio_*` when indexed fields are needed. |
| `TMDbHelper.ListItem.Director*` | `ListItem.Director` or `ListItem.Property(tmdb_director_*)` | Native/Velocity hybrid | Crew lists with numbered roles use property namespace. |
| `TMDbHelper.ListItem.Writer*` | `ListItem.Writing` or `ListItem.Property(tmdb_writer_*)` | Native/Velocity hybrid | Same rule as director mapping. |
| `TMDbHelper.ListItem.Creator*` | `ListItem.Property(tmdb_creator_*)` | Velocity/Addon property | No single robust native equivalent for indexed creator roles. |
| `TMDbHelper.ListItem.Cast*` | `ListItem.Cast` or `ListItem.Property(tmdb_cast_*)` | Native/Velocity hybrid | Use native cast where possible, property for indexed role output. |
| `TMDbHelper.ListItem.Provider.*` | `ListItem.Property(tmdb_provider_*)` | Velocity/Addon property | Provider chips/rows use indexed provider fields. |
| `TMDbHelper.ListItem.RottenTomatoes_*` | `ListItem.Property(tmdb_rottentomatoes_*)` | Velocity/Addon property | Covers image/rating/user meter/consensus variants. |
| `TMDbHelper.ListItem.IMDb_*` | `ListItem.Property(tmdb_imdb_*)` | Velocity/Addon property | Ratings and top250 fields. |
| `TMDbHelper.ListItem.TMDb_*` | `ListItem.Property(tmdb_tmdb_*)` | Velocity/Addon property | TMDb score fields. |
| `TMDbHelper.ListItem.Trakt_*` | `ListItem.Property(tmdb_trakt_*)` | Velocity/Addon property | Trakt score fields. |
| `TMDbHelper.ListItem.MDBList_*` | `ListItem.Property(tmdb_mdblist_*)` | Velocity/Addon property | MDBList score fields. |
| `TMDbHelper.ListItem.MetaCritic_*` | `ListItem.Property(tmdb_metacritic_*)` | Velocity/Addon property | Metacritic fields. |
| `TMDbHelper.ListItem.Oscar_*` | `ListItem.Property(tmdb_oscar_*)` | Velocity/Addon property | Awards counters. |
| `TMDbHelper.ListItem.Awards*` | `ListItem.Property(tmdb_awards*)` | Velocity/Addon property | Keep suffix (`_Won`, `_Nominated`, etc.). |
| `TMDbHelper.ListItem.base_*` | `ListItem.Property(tmdb_base_*)` | Velocity/Addon property | Base context payload in details/context surfaces. |
| `TMDbHelper.ListItem.Monitor.*` | `ListItem.Property(tmdb_monitor_*)` | Velocity/Addon property | Monitor payload (`tmdb_id`, `tmdb_type`, season, episode). |
| `TMDbHelper.ListItem.CropImage` | `ListItem.Art(clearlogo)` or `ListItem.Property(tmdb_cropimage)` | Native/Velocity hybrid | Prefer art first, then property fallback. |
| `TMDbHelper.ListItem.BlurImage*` | `ListItem.Property(tmdb_blurimage*)` | Velocity/Addon property | Preserve `.Original` suffix when present. |
| `TMDbHelper.ListItem.Fanart` | `ListItem.Art(fanart)` | Native Kodi | Primary fanart path. |
| `TMDbHelper.ListItem.Landscape` | `ListItem.Art(landscape)` | Native Kodi | Landscape art path. |
| `TMDbHelper.ListItem.Poster` | `ListItem.Art(poster)` | Native Kodi | Poster art path. |
| `TMDbHelper.Player.Title` | `VideoPlayer.Title` | Native Kodi | Player-scoped title. |
| `TMDbHelper.Player.TVShowTitle` | `VideoPlayer.TVShowTitle` | Native Kodi | Player TV show title. |
| `TMDbHelper.Player.Plot` | `VideoPlayer.Plot` | Native Kodi | Player plot text. |
| `TMDbHelper.Player.Status` | `VideoPlayer.Property(Velocity.Status)` | Velocity player property | No canonical native enum match for helper status strings. |
| `TMDbHelper.Player.CropImage` | `VideoPlayer.Art(clearlogo)` or `VideoPlayer.Property(Velocity.CropImage)` | Native/Velocity hybrid | Matches OSD crop-logo use case. |
| `TMDbHelper.Player.ClearArt` | `VideoPlayer.Art(clearart)` | Native Kodi | Primary replacement for clearart image. |
| `TMDbHelper.Player.Network.*` | `VideoPlayer.Property(Velocity.Network_*)` | Velocity player property | Indexed network fields in playback overlays. |
| `TMDbHelper.Player.Studio.*` | `VideoPlayer.Studio` or `VideoPlayer.Property(Velocity.Studio_*)` | Native/Velocity hybrid | Native studio first, indexed fallbacks via property. |
| `TMDbHelper.Player.Director*` | `VideoPlayer.Director` or `VideoPlayer.Property(Velocity.Director_*)` | Native/Velocity hybrid | Crew role expansion may require properties. |
| `TMDbHelper.Player.Writer*` | `VideoPlayer.Property(Velocity.Writer_*)` | Velocity player property | Use property form for indexed writer role bindings. |
| `TMDbHelper.Player.RottenTomatoes_*` | `VideoPlayer.Property(Velocity.RottenTomatoes_*)` | Velocity player property | Ratings badges during playback. |
| `TMDbHelper.WidgetContainer` | `Window(Home).Property(Velocity.WidgetContainer)` | Velocity window property | Canonical replacement per migration rule. |
| `TMDBHelper.WidgetContainer` | `Window(Home).Property(Velocity.WidgetContainer)` | Velocity window property | Case-variant alias of same legacy key. |
| `TMDbHelper.IsData` | `Window(Home).Property(Velocity.IsData)` | Velocity window property | Canonical replacement per migration rule. |
| `TMDbHelper.EnableExtendedProperties` | `Window(Home).Property(Velocity.IsData)` | Velocity window property | Consolidated to same data-availability gate. |
| `TMDbHelper.Instance` | `Window(Home).Property(Velocity.Instance)` | Velocity window property | Replace helper instance tracker. |
| `TMDbHelper.Position` | `Window(Home).Property(Velocity.Position)` | Velocity window property | Replace helper position tracker. |
| `TMDbHelper.UserDiscover.FolderPath` | `Window(Home).Property(Velocity.UserDiscover.FolderPath)` | Velocity window property | Deferred rename target in ledger; keep key migration explicit. |
| `TMDbHelper.UserDiscover.FolderPath.Name` | `Window(Home).Property(Velocity.UserDiscover.FolderPath.Name)` | Velocity window property | Paired discover label key. |
| `TMDbHelper.ContextMenu` | `Window(Home).Property(Velocity.ContextMenu)` | Velocity window property | Use only where context dialog path is retained; otherwise remove surface per ledger. |
| `TMDbHelper.Corner.Radius` | `Skin.String(Velocity.Corner.Radius)` | Skin setting namespace | Startup/Home legacy skin string mapping. |
| `TMDbHelper.UseLocalWindowIDs` | `Skin.String(Velocity.UseLocalWindowIDs)` | Skin setting namespace | Keep semantics, rename namespace. |
| `TMDbHelper.EnableBlur` | `Skin.HasSetting(Velocity.EnableBlur)` | Skin bool namespace | Legacy bool currently keep-temporary in ledger; target rename in cleanup. |

## Usage Rules

- Apply native fields first when a stable Kodi field exists (`ListItem.*`, `VideoPlayer.*`, `Player.*`, `ListItem.Art(*)`).
- Use `ListItem.Property(tmdb_*)` and `VideoPlayer.Property(Velocity.*)` for indexed/extended metadata where native fields are insufficient.
- Preserve semantic suffixes during migration (`Status`, `Monitor`, `Next_Aired`, `Awards`, etc.) to avoid data-loss in labels.
- If a legacy key is marked `remove` in D-038, delete usage instead of mapping.
