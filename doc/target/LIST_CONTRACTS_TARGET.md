# List contracts — target (required lists)

**Truth document 2 of 3.** Frozen **what** the product and skin expect: `contract_id` / `list_id` families, pagination rules, hub row order, and cross-cutting guarantees. For **how the addon implements** lists internally, see [LIST_ADDON_THEORY.md](../context/LIST_ADDON_THEORY.md). For **what is wired today**, see [LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md).

**Historical inputs:** [skin vision v0](../archive/skin-vision-blueprint-v0.md) (archive), [skin vision v1](./skin-vision-blueprint-v1.md) (current narrative).

---

## Skin surface mapping (main hubs)

**Architecture**

- **Main hubs:** `Home`, `Series` (1101), `Movies` (1102). Primary wiring: `Home.xml`, `Custom_1101_Hub.xml`, `Custom_1102_Hub.xml`, `Includes_Hubs.xml`, `Includes_Home.xml`.
- **Provider mini-hubs (curated):** One logical surface per provider in the agreed roster (Netflix, Disney+, Prime Video, Apple TV+, Hulu, Max, Paramount+, Peacock, BBC iPlayer).
- **Search / discovery:** `Custom_1105_Search.xml`, `Includes_Search.xml`, generator under `shortcuts/generator/…`.

**Global UX rules (list-related)**

| Rule | |
|------|---|
| Spotlight | Hero, near full-screen, **single** item, info-first; **non-paginated** (no next-page). |
| Row cards | **Image-only** (poster / landscape / square) — no metadata overlays on cards. |
| Row density | Baseline `balanced`. |
| Paging | In-row **≤10** → row-end “next” → row title / header opens **full** list; full list **40 items per page** (not a total cap). |
| Empty | Explicit **“No items available”** (or product string) via shared empty/now-results patterns. |

**Main hub row contracts (feeds + layout)**

| Hub | Order | Row | Card / layout | Addon contract (`list_id` or family) | Pag. |
|-----|------:|-----|---------------|----------------------------------------|:----:|
| **Home** | 1 | Spotlight | Hero | `home_spotlight_mixed` | No |
| | 2a / 2b | In-progress Series / Movies | Poster | `home_in_progress_series` / `home_in_progress_movies` | Yes |
| **Series** | 1 | Spotlight | Hero | `series_spotlight_trending` | No |
| | 2 | Continue watching | Landscape | `series_continue_watching_episodes` | Yes |
| | 3 | In-progress shows | Poster | `series_in_progress_shows` | Yes |
| | 4 | Global trending | Poster | `series_global_trending` | Yes |
| | 5 | Provider icons | Square | `series_provider_icons` | No |
| | 6 | Genre | Square strip / navigation to discover | `series_genre_navigation` → `genre_global_{slug}` (`media_type=show`) | Yes |
| **Movies** | 1 | Spotlight | Hero | `movies_spotlight_trending` | No |
| | 2 | In progress | Poster | `movies_in_progress` | Yes |
| | 3 | Global trending | Poster | `movies_global_trending` | Yes |
| | 4 | Provider icons | Square | `movies_provider_icons` | No |
| | 5 | Genre | Square strip / navigation to discover | `movies_genre_navigation` → `genre_global_{slug}` (`media_type=movie`) | Yes |

**Provider mini-hub (per provider) — target rows:** `provider_{id}_spotlight` (No), `provider_{id}_trending` / `popular` / `genre_{genre}` (Yes). Skin: dedicated mini-hub surface(s) TBD. Addon: `phase02_contracts` family.

**Search:** Tab set Discover / Movies / TV; combined movie+series mode supported; trim aliases to product; generator/search paths should not pull dead music rows.

---

## D-015 — contract schema (applies to every list below)

For each list/feed, define:
- `contract_id`: stable identifier used by skin routing.
- `media_scope`: `movie` / `show` / `episode` / `mixed` (only where explicitly required, such as Home mixed spotlight).
- `surface_usage`: where it appears in skin (hub row, spotlight, mini-hub row, search/discover, etc.).
- `sort_rule`: explicit sort semantics (user-facing labels remain `Trending`/`Popular`; backend window targets past 30 days where applicable).
- `pagination`:
  - `none` for spotlight feeds
  - paginated for list rows and full-list views
- `pagination_payload` for paginated lists:
  - `items`
  - `page`
  - `has_more`
  - `next_page`
  - omit `next_page` when there is no further page
- `page_size`: 40 for full-list page contract.
- `required_item_fields`:
  - strict canonical IDs for navigation/play/info/deep-view
  - canonical provider/genre identifiers where applicable
  - title/plot/art/rating/year/runtime fields as needed by target surface
- `default_action_semantics`: what skin should do when clicked (play/info/open-show/open-hub).
- `empty_behavior`: return clean empty lists (`items=[]`) and let skin render `No items available`.

---

## D-015 — Home contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | required_item_fields (minimum) | notes |
|---|---|---|---|---|---|---|
| `home_spotlight_mixed` | mixed movie+show | Home spotlight hero | fixed alternation movie/show | none | id, media_type, title, short_plot, year, runtime, rating, artwork | non-paginated only |
| `home_in_progress_series` | show/episode-linked | Home row tab A | last watched desc | paginated | id, title, artwork, is_in_progress, percent_watched, resume_point, last_watched_at, play target | in-row cap 10, full-list paging 40 |
| `home_in_progress_movies` | movie | Home row tab B | last watched desc | paginated | id, title, artwork, is_in_progress, percent_watched, resume_point, last_watched_at, play target | in-row cap 10, full-list paging 40 |

---

## D-015 — Series hub contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | required_item_fields (minimum) | notes |
|---|---|---|---|---|---|---|
| `series_spotlight_trending` | show | Series spotlight | trending | none | id, title, short_plot, year, rating, artwork | no next-page semantics |
| `series_continue_watching_episodes` | episode | Continue watching episodes row | priority logic (in-progress episode first, else next unwatched aired) then recency | paginated | episode id, show id, season/episode numbers, aired state, is_in_progress, percent_watched, resume_point, last_watched_at, title, artwork | addon-owned guaranteed ordering behavior |
| `series_in_progress_shows` | show | In-progress shows row | last watched desc | paginated | show id, title, artwork, is_in_progress, percent_watched, last_watched_at, deep-view target | default click opens show/details |
| `series_global_trending` | show | Global trending row | trending desc | paginated | show id, title, artwork, info target | label `Trending` |
| `series_provider_icons` | provider entities | Provider icon row | fixed curated provider order | none | provider id, provider label, provider icon, target hub/list route | no "all providers" item |

---

## D-015 — Movies hub contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | required_item_fields (minimum) | notes |
|---|---|---|---|---|---|---|
| `movies_spotlight_trending` | movie | Movies spotlight | trending | none | id, title, short_plot, year, runtime, rating, artwork | non-paginated spotlight |
| `movies_in_progress` | movie | In Progress row | last watched desc | paginated | id, title, artwork, is_in_progress, percent_watched, resume_point, last_watched_at, play target | label locked: `In Progress` |
| `movies_global_trending` | movie | Global trending row | trending desc | paginated | id, title, artwork, info target | label `Trending` |
| `movies_provider_icons` | provider entities | Provider icon row | fixed curated provider order | none | provider id, icon, label, route target | same provider roster |

---

## D-015 — Provider mini-hub contracts

Provider IDs (curated roster):
- `netflix`
- `disney_plus`
- `prime_video`
- `apple_tv_plus`
- `hulu`
- `max`
- `paramount_plus`
- `peacock`
- `bbc_iplayer`

Required contract families per provider `{provider_id}`:

| contract_id pattern | media_scope | surface_usage | sort_rule | pagination | notes |
|---|---|---|---|---|---|
| `provider_{provider_id}_{media}_spotlight` | media-specific (`movie` or `show`) | provider spotlight | trending/editorial (30-day basis where applicable) | none | subtle provider branding, content-first |
| `provider_{provider_id}_{media}_trending` | media-specific (`movie` or `show`) | provider trending row | trending desc (30-day basis where applicable) | paginated | row title `Trending on <Provider>` |
| `provider_{provider_id}_{media}_popular` | media-specific (`movie` or `show`) | provider most popular row | popularity desc (30-day basis where applicable) | paginated | naming consistency across providers |
| `provider_{provider_id}_{media}_genre_{genre}` | media-specific (`movie` or `show`) | provider genre rows | genre + trending/popularity (30-day basis where applicable) | paginated | fixed genre family; long-form standardized route family |

---

## D-015 — Genre discovery contracts (global + provider)

Fixed genre set:
- Action
- Comedy
- Drama
- Thriller
- Romance
- Sci-Fi
- Crime
- Animation

Recommended explicit global contract IDs:
- `genre_global_action`
- `genre_global_comedy`
- `genre_global_drama`
- `genre_global_thriller`
- `genre_global_romance`
- `genre_global_scifi`
- `genre_global_crime`
- `genre_global_animation`

Provider genre contract IDs:
- `provider_{provider_id}_genre_{genre_slug}`

Decision locked:
- Each genre contract is media-specific and standardized per provider/genre route family.
- Keep the fixed 8 genres now, with optional future extension.

---

## D-015 — Search contracts

Selector tabs:
- Discover
- Movies
- TV Shows

Required contracts:
- `search_movies`
- `search_tvshows`
- optional additional explicit routes only when directly required by frozen hub/mini-hub/search surfaces (no generic `discover_root` requirement)

Search parameter model:
- `query`
- `media_type`
- `page`
- `sort`

Alias policy:
- keep only aliases required for Discover/Movies/TV
- remove unused legacy/music alias families

---

## D-015 — Cross-cutting contract guarantees

1. Pagination guarantees:
- Spotlight contracts: non-paginated.
- Row contracts: compatible with in-row 10 cap + row-end next-page affordance.
- Full-list contracts: 40 items per page.

2. Item identity guarantees:
- stable canonical internal IDs for play, info/details, and deep-view navigation.
- include canonical provider/genre identifiers where required for routing.

3. Metadata guarantees by surface:
- Spotlight: title/year/runtime/rating/short_plot/artwork.
- Row cards (image-only): artwork still mandatory; metadata available for focused info panel/details transitions.
- Pause strip: title + short plot.

4. Empty list guarantees:
- clean empty list response (no fake next-page item in spotlight feeds).

5. Project versioning:
- no explicit contract versioning in this unpublished project.

---

## D-015 — Completion criteria

D-015 can move from `modify` to `accept` when:
- Every contract above has an implemented addon route or mapped equivalent.
- Route naming/parameters are frozen and documented.
- Skin path wiring references only these frozen contracts.
- Paging and metadata guarantees are validated on hub, mini-hub, and search surfaces.
