# List contracts — implementation status (skin + addon)

**Truth document 3 of 3.** Tracks **current** alignment between `skin.velocity.af3` wiring and [LIST_CONTRACTS_TARGET.md](./LIST_CONTRACTS_TARGET.md), plus list-focused open work. For addon internals, see [LIST_ADDON_THEORY.md](../context/LIST_ADDON_THEORY.md). **Topic IDs** `lists` / `widgets-rails`: [traceability-by-topic.md](../traceability-by-topic.md).

**Update rule:** when wiring or addon routes change, edit this file first; do not scatter list status across roadmap appendices.

---

## Current status (workspace)

Legend: **Yes** = matches contract; **Partial** = incomplete, alternate path, or not fully verified; **No** = missing or contrary to target.

| Area | Item | Status | Notes (factual) |
|------|------|--------|-----------------|
| **§1 Global** | Main hubs 1100 / 1101 / 1102 | Yes | `Home.xml`, `Custom_1101/1102_Hub.xml`, `Includes_Hubs.xml` |
| | Provider mini-hubs as dedicated skin surfaces | Partial | Addon: `PROVIDER_ORDER`, `provider_*_*` resolvers. Skin: no per-provider hub windows; rails report lists “not used” on skin |
| | Spotlight hero + non-paginated spotlight | Partial / Yes | Layout audit Partial; addon non-paginated spotlight + caps Yes |
| | Image-only row cards | Partial | Not all rows/layouts audited |
| | `balanced` density | Partial | Not all rows verified |
| | Paging: 10 / next / header / 40 | Partial | Addon `full_page_size=40`; skin `browse` via `Defs_BrowseLimitedLists`; cap-10 not enforced in XML alone |
| | Empty state copy / behavior | Partial | Patterns exist; not every row verified |
| | Startup / splash dismiss safety | Yes | `SplashTimeOut`, `Home.xml` alarm split (no `ClearProperty`+comma in one `AlarmClock`) |
| | 1101/1102 widget info (combined + wall) | Yes | `Hub_Combined_Info` / `Hub_Wall_Info` for 1101 **501–505**, 1102 **501–504**; shortcut JSONs for regen |
| **§2.1 Home** | `home_spotlight_mixed` | Yes | |
| | `home_in_progress_series` / `…_movies` (D-015 URLs on Home) | Partial | Lists exist; Home **501/502** still `smart_list&type=…` in generated home widgets |
| **§2.2 Series** | `series_spotlight_trending` | Yes | |
| | `series_continue_watching_episodes` (landscape 501) | Yes | |
| | `series_in_progress_shows`, `series_global_trending` | Yes | Rows 502, 503 |
| | `series_provider_icons` | Yes | Row 504, square |
| | Genre navigation (fixed set → `genre_global_*`) | Yes | Row 505, `list_link` strip; not separate `List_Button_Row` |
| **§2.3 Movies** | `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending` | Yes | |
| | `movies_provider_icons` | Yes | Row 503, square |
| | Genre navigation | Yes | Row 504 |
| **§2.4** | `provider_{id}_*` rows on mini-hub surface | Partial | Resolver-side exists; **skin** mini-hubs not built |
| **§2.5 Search** | Tabs: Discover, Movies, TV only | Partial | |
| | Combined search mode | Yes | |
| | Alias trim (no music cruft in product) | Partial | Generator search fragments may still include music paths |
| **§5 Add-on** | Pkg 1 spotlights (incl. provider on skin) | Partial | Home/Series/Movies ok; `provider_*_spotlight` not skin-wired |
| | Pkg 2 progress (incl. Home D-015) | Partial | 1101 continue ok; **Home** URL parity open |
| | Pkg 3–4 discover / provider / genre (main hubs) | Yes | |
| | Pkg 5 paging UX | Partial | |
| | Pkg 6 details payload matrix | Partial | |

---

## Contract alignment matrix (skin vs D-015)

This section tracks what the skin actually calls today and how that aligns to
[LIST_CONTRACTS_TARGET.md](./LIST_CONTRACTS_TARGET.md).

Legend:
- **Used**: actively referenced by skin routes in current XML.
- **Not used**: contract exists in D-015 but is not referenced by current skin routes.
- **Missing**: required by D-015 but not present as a dedicated contract route in current implementation.
- **Out of D-015 scope**: route is used by skin but is not a D-015 list contract ID.

### 12.1 D-015 contracts currently used by skin

| Contract ID | D-015 section | Current status |
|---|---|---|
| `home_spotlight_mixed` | Home | Used |
| `home_in_progress_series` | Home | Used |
| `home_in_progress_movies` | Home | Used |
| `series_spotlight_trending` | Series | Used |
| `series_continue_watching_episodes` | Series | Used |
| `series_in_progress_shows` | Series | Used |
| `series_global_trending` | Series | Used |
| `series_provider_icons` | Series | Used |
| `movies_spotlight_trending` | Movies | Used |
| `movies_in_progress` | Movies | Used |
| `movies_global_trending` | Movies | Used |
| `movies_provider_icons` | Movies | Used |

### 12.2 D-015 contracts not currently wired by skin

| Contract group | D-015 section | Current status |
|---|---|---|
| `provider_{provider_id}_{media}_spotlight` | Provider mini-hubs | Not used |
| `provider_{provider_id}_{media}_trending` | Provider mini-hubs | Not used |
| `provider_{provider_id}_{media}_popular` | Provider mini-hubs | Not used |
| `provider_{provider_id}_{media}_genre_{genre}` | Provider mini-hubs | Not used |
| `genre_global_*` | Global genre discovery | Not used (skin uses `action=browse_genres`) |
| `search_movies` | Search | Not used |
| `search_tvshows` | Search | Not used |

### 12.3 Skin-used rails/routes outside D-015 list IDs

These are used in skin routing but are not modeled as D-015 list contract IDs.

| Route/rail | Current status | Notes |
|---|---|---|
| `action=discover` | Used | Used as row items; discovery action route, not a list_id contract |
| `action=browse_genres&kind=tv` | Used | Genre entry route, not explicit `genre_global_*` contract ID |
| `action=browse_genres&kind=movie` | Used | Genre entry route, not explicit `genre_global_*` contract ID |
| Smart rails (`continue_watching`, `recently_watched`, `up_next`, `active_shows`, `new_episodes`, `in_progress_movies`) | Partially used outside core hubs | Still used in non-core/legacy surfaces (for example next-aired, OSD, path helpers), but no longer used in core Home/1101/1102 contract rows |

### 12.4 Key discrepancy summary

1. **Old alias mapping is obsolete**  
   Current core hub wiring now calls explicit D-015 contract IDs directly (for example `series_in_progress_shows`, `movies_global_trending`) instead of aliasing to smart rails.

2. **Provider mini-hub contract families remain unimplemented/unwired**  
   D-015 defines them, but current skin wiring intentionally does not consume them in this hard-replacement pass.

3. **Genre/search contract IDs vs action routes**  
   D-015 lists explicit `genre_global_*`, `search_movies`, and `search_tvshows` contracts; current skin uses `browse_genres` and `discover` routes instead.

---

## List-focused remaining work (historical note: formerly bundled in monolithic non-list doc)

### Home hub — URL parity (D-015)

- [ ] Generator / `getnfo`: **501** `?action=list&list_id=home_in_progress_series&page=1` (replace `smart_list&type=active_shows`); regen `script-skinvariables-generator-includes.xml`
- [ ] Same for **502** → `home_in_progress_movies` (replace `smart_list&type=in_progress_movies`); regen
- [ ] Reconcile product copy (tabs vs two visible rows) with `Includes_Home` if needed
- [ ] QA: `Hub_Onload` / `Velocity.WidgetContainer`, pagination, `Widget_NoResults`, focus

### Main hubs — product hardening

- [ ] **In-row cap 10:** enforce in addon first page and/or `limit` on row `<content>` — document single source of truth
- [ ] **Row-end next + header full list:** same `list_id` with `page=`; confirm header onclick and `browse` mode
- [ ] **Image-only + balanced:** audit `List_*_Row` / layout includes; strip overlays where contract says image-only
- [ ] **Empty copy:** one shared string for “No items available” (or product string) on all contract rows

### Provider icon rows → mini-hubs

- [ ] Confirm each `series_provider_icons` / `movies_provider_icons` item exposes stable `ActivateWindow`-compatible path
- [ ] `Widget_NoResults` / empty for icon strip
- [ ] Skin: spotlight + trending + popular + genre rows per provider; bootstrap spotlight paths; back nav to parent hub

### Genre / search

- [ ] Shipped: square **`list_link`** strip after contract; if product insists on `List_Button_Row`, document deviation in D-003
- [ ] Tab inventory: only Discover, Movies, TV reachable
- [ ] Remove music / unused search **content** from `search_path.xml` and shortcut JSON; **regen**

### Verification (lists)

- [ ] Menu **Down** → spotlight **310** when spotlight has items and is configured
- [ ] Spotlight **Down** → first widget; **Up** back
- [ ] `Window(Home).Property(Velocity.WidgetContainer)` matches row for info/fanart
- [ ] Empty list: explicit empty UI, poster/icon fallbacks
- [ ] If widget XML: **shortcuts/ generator sources updated** + regen; output committed

### File index (lists)

| Concern | Typical files |
|--------|----------------|
| Hubs / widgets | `1080i/Includes_Hubs.xml`, `Includes_Home.xml`, `Includes_Widgets.xml`, `Includes_Lists.xml` |
| Generated includes | `1080i/script-skinvariables-generator-includes.xml` (output) |
| Generator inputs | `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/`, `shortcuts/skinvariables-shortcut-*.json` |
| Search | `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`, `shortcuts/generator/data/setup/search_path.xml` |
| Addon | `plugin.video.velocity2` — `lib/daemon/phase02_contracts.py`, `lib/client/handlers/lists.py`, `lib/client/builder.py` |

