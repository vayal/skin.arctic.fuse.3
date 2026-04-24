# List Contracts Comparison Table

**Purpose:** Compare what lists the Velocity addon exposes naturally, what the skin code currently expects, and what lists the roadmap names (D-015 contract families).

**Last updated:** 2026-04-24

---

## Column Definitions

| Column | Description |
|--------|-------------|
| **Addon-Natural Lists** | All lists/actions the Velocity addon exposes via plugin URLs and HTTP API (from `velocity-addon-reference-for-skin-forks.md`) |
| **Skin Code Expects** | What the skin currently uses via `Includes_Velocity_Paths.xml` wrapper variables and actual XML usages |
| **Roadmap Contract Names** | D-015 contract family names from `.clinerules/02-velocity-contracts.md` and roadmap |

---

## Full Comparison Table

| Addon-Natural Lists (Velocity API) | Skin Code Expects (Current Usage) | Roadmap Contract Names (D-015) |
|-----------------------------------|-----------------------------------|--------------------------------|
| `home` | `Velocity.Path.Home` | `home_spotlight_mixed` |
| `movies_hub` | — | `movies_spotlight_trending` |
| `tv_hub` | — | `series_spotlight_trending` |
| `browse_genres` (kind=movie\|tv) | — | `movies_global_trending` / `series_global_trending` |
| `list` (list_id, page) | `Velocity.Path.ListBase` | `home_in_progress_series` / `home_in_progress_movies` |
| `smart_list` (type=...) | `Velocity.Path.SmartListBase` | `series_continue_watching_episodes` |
| `discovery` / `discover` | `Velocity.Path.Discover` | `search_movies` / `search_tvshows` |
| `discovery_cat` (cat_id) | — | — |
| `my_lists` | — | — |
| `my_collections` | — | — |
| `search_hub` | `Velocity.Path.SearchHub` | — |
| `execute_search` (q=...) | `Velocity.Path.ExecuteSearch` | — |
| `search` | — | — |
| `view_show` (id=tv-...) | `Velocity.Path.ViewShowBase` | — |
| `view_season` (show_id, season) | `Velocity.Path.ViewSeasonBase` | — |
| `play` / `select` (id=...) | `Velocity.Path.PlayBase` / `Velocity.Path.SelectBase` | — |
| `sync_trakt` | — | — |
| `details` (tmdb_id, tmdb_type) | — | — |
| `crew_in_both` / `stars_in_both` | — | — |
| `toggle_watched` | — | — |
| `refresh_metadata` | — | — |
| `import_item` | — | — |
| `subscribe_list` / `delete_sub` | — | — |
| `create_custom_list` / `delete_custom_list` | — | — |
| `add_to_custom_list` / `remove_from_custom_list` | — | — |
| `discovery_pick` | — | — |
| `smart_wizard` | — | — |
| `settings_clear_cache` | — | — |
| `settings_wipe_db` | — | — |
| `settings_select_player` | — | — |
| *(empty/unknown)* → `handle_home()` | — | — |
| `in_progress_movies` / `movies_in_progress` | — | `movies_in_progress` |
| `recently_watched` | — | — |
| `up_next` / `continue_watching` | — | — |
| `active_shows` | — | — |
| `new_episodes` | — | — |
| `provider_*` (dynamic) | — | `provider_{provider_id}_{media}_{spotlight\|trending\|popular\|genre_{genre}}` |

---

## Contract Families by Category

### Home Hub Contracts

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| `home_spotlight_mixed` | `action=home` | `Velocity.Path.Home` | Home hub spotlight | ✅ Implemented |
| `home_in_progress_series` | `action=smart_list&type=in_progress_episodes` | `Velocity.Path.SmartListBase` | Not used on Home | ⚠️ Unused |
| `home_in_progress_movies` | `action=home_in_progress_movies` | `Velocity.Path.SmartListBase` | Home hub widget 501 | ✅ Implemented |

### Series Hub Contracts (1101)

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| `series_spotlight_trending` | `action=smart_list&type=active_shows` | `Velocity.Path.SmartListBase` | Not used on 1101 | ⚠️ Unused |
| `series_continue_watching_episodes` | `action=list&list_id=series_continue_watching_episodes` | `Velocity.Path.ListBase` | 1101 widget 501 | ✅ Implemented |
| `series_in_progress_shows` | `action=list&list_id=series_in_progress_shows` | `Velocity.Path.ListBase` | 1101 widget 502 | ✅ Implemented |
| `series_global_trending` | `action=list&list_id=series_global_trending` | `Velocity.Path.ListBase` | 1101 widget 503 | ✅ Implemented |
| `series_provider_icons` | `action=list&list_id=series_provider_icons` | `Velocity.Path.ListBase` | 1101 widget 504 | ✅ Implemented |
| `series_genre_navigation` | `action=list&list_id=series_genre_navigation` | `Velocity.Path.ListBase` | 1101 widget 505 | ✅ Implemented |

### Movies Hub Contracts (1102)

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| `movies_spotlight_trending` | `action=list&list_id=movies_spotlight_trending` | `Velocity.Path.ListBase` | Not used on 1102 | ⚠️ Unused |
| `movies_in_progress` | `action=list&list_id=movies_in_progress` | `Velocity.Path.ListBase` | 1102 widget 501 | ✅ Implemented |
| `movies_global_trending` | `action=list&list_id=movies_global_trending` | `Velocity.Path.ListBase` | 1102 widget 502 | ✅ Implemented |
| `movies_provider_icons` | `action=list&list_id=movies_provider_icons` | `Velocity.Path.ListBase` | 1102 widget 503 | ✅ Implemented |
| `movies_genre_navigation` | `action=list&list_id=movies_genre_navigation` | `Velocity.Path.ListBase` | 1102 widget 504 | ✅ Implemented |

### Smart Rail Contracts

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| `up_next` / `continue_watching` | `action=smart_list&type=up_next` | `Velocity.Path.SmartListBase` | Not used | ⚠️ Unused |
| `recently_watched` | `action=smart_list&type=recently_watched` | `Velocity.Path.SmartListBase` | Not used | ⚠️ Unused |
| `active_shows` | `action=smart_list&type=active_shows` | `Velocity.Path.SmartListBase` | Home hub widget 502 | ✅ Implemented |
| `new_episodes` | `action=smart_list&type=new_episodes` | `Velocity.Path.SmartListBase` | Not used | ⚠️ Unused |

### Search Contracts

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| `search_movies` | `action=execute_search&q=...` | `Velocity.Path.ExecuteSearch` | Search hub widget 510 | ✅ Implemented |
| `search_tvshows` | `action=execute_search&q=...` | `Velocity.Path.ExecuteSearch` | Search hub widget 511 | ✅ Implemented |

### Discovery Contracts

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| Discovery Hub | `action=discover` | `Velocity.Path.Discover` | Discovery hub | ✅ Implemented |
| Discovery Category | `action=discovery_cat&cat_id=...` | — | Discovery categories | ✅ Implemented |
| Discovery Preview | `action=discover&preset_id=...` | `Velocity.Path.Discover` | Discovery presets | ✅ Implemented |

### TV Hierarchy Contracts

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| View Show | `action=view_show&id=tv-...` | `Velocity.Path.ViewShowBase` | Show detail pages | ✅ Implemented |
| View Season | `action=view_season&show_id=...&season=...` | `Velocity.Path.ViewSeasonBase` | Season pages | ✅ Implemented |

### Search Extended Widgets (1105)

| Contract Name | Addon Path | Skin Variable | Actual Usage in Skin | Status |
|--------------|------------|---------------|---------------------|--------|
| Search Movies (Videodb) | `videodb://movies/titles/` | `Velocity.Path.ExecuteSearch` | Search hub widget 502 | ✅ Implemented |
| Search TV Shows (Videodb) | `videodb://tvshows/titles/` | `Velocity.Path.ExecuteSearch` | Search hub widget 503 | ✅ Implemented |
| Search Albums | `musicdb://albums/` | `Velocity.Path.ExecuteSearch` | Search hub widget 504 | ✅ Implemented |
| Search Artists | `musicdb://artists/` | `Velocity.Path.ExecuteSearch` | Search hub widget 505 | ✅ Implemented |
| Search Movies (TMDb) | `plugin://plugin.video.velocity2/?action=search_movies` | `Velocity.Path.ExecuteSearch` | Search hub widget 510 | ✅ Implemented |
| Search TV Shows (TMDb) | `plugin://plugin.video.velocity2/?action=search_tvshows` | `Velocity.Path.ExecuteSearch` | Search hub widget 511 | ✅ Implemented |

---

## Implementation Notes

### Addon-Natural Lists (20+)
These are all the actions the Velocity addon exposes via its plugin URL contract and HTTP API. They include:
- Core navigation (`home`, `list`, `smart_list`, `view_show`, etc.)
- Smart rails (`up_next`, `continue_watching`, `recently_watched`, etc.)
- Discovery and search flows
- User list management (`my_lists`, `my_collections`, custom lists)
- Media operations (`sync_trakt`, `refresh_metadata`, `import_item`)
- Playback and state (`play`, `select`, `toggle_watched`)

### Skin-Expected Lists (10 base paths)
These are the wrapper variables defined in `Includes_Velocity_Paths.xml`:
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

### Roadmap Contract Names (D-015)
These are the contract family names defined in the D-015 specification:
- **Home:** `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`
- **Series:** `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`
- **Movies:** `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`
- **Provider families:** `provider_{provider_id}_{media}_{spotlight|trending|popular|genre_{genre}}`
- **Search:** `search_movies`, `search_tvshows`

---

## Alignment Status

| Category | Aligned | Notes |
|----------|---------|-------|
| Core navigation | ✅ | All base paths implemented |
| Smart rails | ✅ | All smart_list types available |
| Discovery | ✅ | Hub and category flows working |
| Search | ✅ | execute_search path implemented |
| TV hierarchy | ✅ | view_show/view_season implemented |
| Provider icons | ✅ | Dynamic list_id routing |
| Search extended widgets | ✅ | Videodb and TMDb sources implemented |
| User lists | ⚠️ | API exists, skin usage TBD |
| Pagination | ⚠️ | Phase 2 work item |
| Spotlight vs widget | ⚠️ | Phase 2 work item |

---

## Work Items

### Phase 1 (Contract and IA baseline)
- [x] Map all skin list usages to D-015 contract families
- [x] Document any deviations from contract schema
- [x] Freeze baseline matrix

### Phase 2 (List implementation alignment)
- [ ] Implement `paginate=false` for spotlight feeds
- [ ] Implement `limit=N` for widget feeds
- [ ] Verify no `Next Page >>` in spotlight rows

### Phase 3 (Non-list surfaces)
- [ ] Verify info action resolves to full details
- [ ] Verify lean details rails
- [ ] Verify search chrome tab/alias policy

---

## References

- **Addon reference:** `plugin.video.velocity2/plans/velocity-addon-reference-for-skin-forks.md`
- **Skin roadmap:** `plugin.video.velocity2/plans/af3-skin-fork-roadmap.md`
- **D-015 contracts:** `.clinerules/02-velocity-contracts.md`
- **D-003 view modes:** `.clinerules/02-velocity-contracts.md` (D-003 section)
- **Legacy properties:** `.clinerules/03-workflow-verification.md` (D-038 section)