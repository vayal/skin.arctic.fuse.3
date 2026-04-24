# Skin Vision Blueprint v1 (structured target draft)

Purpose: define the target IA/UX in a reviewable structure before final freeze.

## 1) Navigation Model

- Main hubs: `Home`, `Series`, `Movies`.
- Mini-hubs: one provider mini-hub per provider in curated roster.
- Design principle: `Series` and `Movies` follow the same interaction philosophy as `Home` where possible.

Provider roster (target order):
1. Netflix
2. Disney+
3. Prime Video
4. Apple TV+
5. Hulu
6. Max
7. Paramount+
8. Peacock
9. BBC iPlayer

Fixed global genre set:
- Action
- Comedy
- Drama
- Thriller
- Romance
- Sci-Fi
- Crime
- Animation

---

## 2) Home Hub

### 2.1 Spotlight

- Content: mixed trending movies + series.
- Presentation: hero area, single item at a time.
- Action hierarchy:
  - Primary: `Info`
  - Secondary: `Play`
- UX intent: discovery-first (`Info` first) while preserving direct play.
- Feed behavior:
  - fixed alternation for mixed media.
  - non-paginated feed only (no next-page artifact in hero).

### 2.2 Widgets

Target rows after spotlight:
1. In-progress Series
   - Card: `poster`
   - Density: `balanced`
   - Default click: `play`
2. In-progress Movies
   - Card: `poster`
   - Density: `balanced`
   - Default click: `play`

---

## 3) Series Hub

### 3.1 Spotlight

- Content: trending TV series.
- Presentation and button hierarchy: same as Home spotlight.
- Actions:
  - Primary: `Info`
  - Secondary: `Play`

### 3.2 Widgets

Target row order after spotlight:
1. Continue Watching Episodes
   - Card: `landscape`
   - Density: `balanced`
   - Default click: `play`
   - Data rule (addon-owned):
     - show in-progress episode OR next unwatched aired episode.
     - priority: in-progress episode first when both exist.
2. In-progress Shows
   - Card: `poster`
   - Density: `balanced`
   - Default click: open show deep-view (not direct play).
   - Sort intent: last watched desc.
3. Global Trending
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
4. Provider Icons
   - Card: `square`
   - Density: `balanced`
   - Default click: open provider mini-hub.
5. Genre Navigation Buttons
   - Type: button row
   - Behavior: open filtered list for selected genre.

---

## 4) Movies Hub

### 4.1 Spotlight

- Content: trending movies.
- Presentation and button hierarchy: same as Home/Series spotlight.
- Actions:
  - Primary: `Info`
  - Secondary: `Play`

### 4.2 Widgets

Target row order after spotlight:
1. In Progress
   - Card: `poster`
   - Density: `balanced`
   - Default click: `play`
2. Global Trending
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
3. Provider Icons
   - Card: `square`
   - Density: `balanced`
   - Default click: open provider mini-hub.
4. Genre Navigation Buttons
   - Type: button row
   - Behavior: open filtered list for selected genre.

---

## 5) Provider Mini-Hub (applies per provider)

### 5.1 Spotlight

- Purpose: contextual provider entry hero (content-first, subtle branding).
- Actions:
  - Primary: `Info`
  - Secondary: `Play`

### 5.2 Widgets

Target row order after spotlight:
1. Trending on `<Provider>`
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
2. Most Popular
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
3. Genre Row 1
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
4. Genre Row 2
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
5. Genre Row 3
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`
6. Genre Row 4
   - Card: `poster`
   - Density: `balanced`
   - Default click: `info`

---

## 6) Lists (Cross-Hub Rules)

### 6.1 Pagination and limits

- In-row max before paging affordance: `10` items.
- Use both:
  - row-end `Next Page` item,
  - row-header click to full filtered list.
- Full-list page size target: `40`.
- Spotlight exception: spotlight lists must be non-paginated and never show next-page affordances.

### 6.2 Click policy baseline

- Discovery rows default: `info`.
- Progress rows default: `play`.
- Show-level progress rows: open deep-view (not direct play).

### 6.3 Empty-state behavior

- Keep row visible and show explicit message: `No items available`.

### 6.4 Metadata visibility policy on cards

- Poster cards: image-only.
- Landscape cards: image-only.
- Square cards: image-only.

---

## 7) Info / Details

### 7.1 Info action semantics

- `Info` means full-screen details page (not small popup dialog).

### 7.2 Spotlight info fields

- Title
- Year
- Runtime
- One rating
- Short plot

### 7.3 Series deep-view behavior

- Reuse existing series deep-view layout:
  - combined landscape layout,
  - metadata/info area,
  - season tab strip,
  - episode row.
- Episode focus fallback order:
  1. next episode after most recently completed
  2. most recently watched in-progress episode
  3. first episode

---

## 8) OSD

### 8.1 OSD control scope

- Minimal controls:
  - play/pause
  - seek
  - subtitles
  - audio
  - details entry

### 8.2 OSD to details transition target

- First details action from OSD: lightweight overlay (minimal title + plot strip).
- Second details action (or explicit more-details): full details page.
- Closing full details returns to playback.

---

## 9) Working assumptions / open refinement points

- Provider taxonomy is provider-centric (global trending remains separate).
- Movies and Series keep symmetry unless an explicit exception is accepted.
- Addon/skin boundary:
  - addon owns list semantics and advanced selection logic,
  - skin owns layout, interaction hierarchy, and defaults.
- Remaining refinements should now be made section-by-section against this structure.

---

## 10) Target Matrix (Detail + Status + User Verification)

How to use:
- `Implemented (Yes/No)` is current code-state assessment.
- `Verification` is intentionally blank for your one-pass QA.
- One row = one characteristic, so you can validate line-by-line.
- `Owner` clarifies primary implementation surface:
  - `Skin` = XML/layout/navigation behavior.
  - `Addon` = list semantics/data contract behavior.
  - `Both` = needs coordinated changes.

### 10.1 Home Hub

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Home Spotlight | Content | Feed composition | Mixed trending movies + series | Addon | Yes |  |
| Home Spotlight | Layout | Hero behavior | Single-item hero spotlight | Skin | Yes |  |
| Home Spotlight | Action | Primary action | Info | Skin | Yes |  |
| Home Spotlight | Action | Secondary action | Play | Skin | Yes |  |
| Home Spotlight | Feed rule | Pagination | Non-paginated; no next-page artifact | Both | Yes |  |
| Home Widgets | In-progress Series | Card type | Poster | Skin | Yes |  |
| Home Widgets | In-progress Series | Density | Balanced | Skin | No |  |
| Home Widgets | In-progress Series | Default click | Play | Skin | Yes |  |
| Home Widgets | In-progress Movies | Card type | Poster | Skin | Yes |  |
| Home Widgets | In-progress Movies | Density | Balanced | Skin | No |  |
| Home Widgets | In-progress Movies | Default click | Play | Skin | Yes |  |
| Home Widgets | Home row set | Row count | Exactly 2 rows (series + movies) | Skin | Yes |  |

### 10.2 Series Hub

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Series Spotlight | Content | Feed source | Trending TV series | Addon | Yes |  |
| Series Spotlight | Action | Primary action | Info | Skin | Yes |  |
| Series Spotlight | Action | Secondary action | Play | Skin | Yes |  |
| Series Widgets | Continue Watching Episodes | Row presence | Present as row 1 after spotlight | Skin | No |  |
| Series Widgets | Continue Watching Episodes | Card type | Landscape | Skin | No |  |
| Series Widgets | Continue Watching Episodes | Density | Balanced | Skin | No |  |
| Series Widgets | Continue Watching Episodes | Default click | Play | Skin | No |  |
| Series Widgets | Continue Watching Episodes | Data rule | In-progress OR next unwatched aired; in-progress priority | Addon | Yes |  |
| Series Widgets | In-progress Shows | Card type | Poster | Skin | Yes |  |
| Series Widgets | In-progress Shows | Density | Balanced | Skin | No |  |
| Series Widgets | In-progress Shows | Default click | Open show deep-view (not direct play) | Both | No |  |
| Series Widgets | In-progress Shows | Sort intent | Last watched desc | Addon | Yes |  |
| Series Widgets | Global Trending | Card type | Poster | Skin | Yes |  |
| Series Widgets | Global Trending | Density | Balanced | Skin | No |  |
| Series Widgets | Global Trending | Default click | Info | Skin | Yes |  |
| Series Widgets | Provider Icons | Card type | Square | Skin | Yes |  |
| Series Widgets | Provider Icons | Density | Balanced | Skin | No |  |
| Series Widgets | Provider Icons | Default click | Open provider mini-hub | Both | Yes |  |
| Series Widgets | Genre Navigation Buttons | Row type | Button row | Skin | No |  |
| Series Widgets | Genre Navigation Buttons | Behavior | Open filtered genre list | Both | Yes |  |
| Series Widgets | Row order | Sequence | Continue -> In-progress -> Trending -> Providers -> Genre buttons | Skin | No |  |

### 10.3 Movies Hub

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Movies Spotlight | Content | Feed source | Trending movies | Addon | Yes |  |
| Movies Spotlight | Action | Primary action | Info | Skin | Yes |  |
| Movies Spotlight | Action | Secondary action | Play | Skin | Yes |  |
| Movies Widgets | In Progress | Card type | Poster | Skin | Yes |  |
| Movies Widgets | In Progress | Density | Balanced | Skin | No |  |
| Movies Widgets | In Progress | Default click | Play | Skin | Yes |  |
| Movies Widgets | Global Trending | Card type | Poster | Skin | Yes |  |
| Movies Widgets | Global Trending | Density | Balanced | Skin | No |  |
| Movies Widgets | Global Trending | Default click | Info | Skin | Yes |  |
| Movies Widgets | Provider Icons | Card type | Square | Skin | Yes |  |
| Movies Widgets | Provider Icons | Density | Balanced | Skin | No |  |
| Movies Widgets | Provider Icons | Default click | Open provider mini-hub | Both | Yes |  |
| Movies Widgets | Genre Navigation Buttons | Row type | Button row | Skin | No |  |
| Movies Widgets | Genre Navigation Buttons | Behavior | Open filtered genre list | Both | Yes |  |
| Movies Widgets | Row order | Sequence | In Progress -> Global Trending -> Providers -> Genre buttons | Skin | Yes |  |

### 10.4 Provider Mini-Hub

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Provider Mini-Hub Spotlight | Presentation | Hero behavior | Content-first spotlight with subtle provider context | Skin | No |  |
| Provider Mini-Hub Spotlight | Action | Primary action | Info | Skin | No |  |
| Provider Mini-Hub Spotlight | Action | Secondary action | Play | Skin | No |  |
| Provider Mini-Hub Widgets | Trending on Provider | Card type | Poster | Skin | No |  |
| Provider Mini-Hub Widgets | Most Popular | Card type | Poster | Skin | No |  |
| Provider Mini-Hub Widgets | Genre rows | Count | 4 genre rows | Both | No |  |
| Provider Mini-Hub Widgets | Genre rows | Card type | Poster | Skin | No |  |
| Provider Mini-Hub Widgets | Discovery rows | Default click | Info | Skin | No |  |

### 10.5 Lists (Cross-Hub)

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Lists | Row pagination | In-row max | 10 items before paging affordance | Both | No |  |
| Lists | Pagination affordance | Row-end affordance | Explicit `Next Page` row-end item | Both | No |  |
| Lists | Pagination affordance | Header behavior | Row header click opens full filtered list | Skin | No |  |
| Lists | Full list | Page size | 40 items | Addon | Yes |  |
| Lists | Spotlight exception | Paging | Spotlight never paginated | Both | Yes |  |
| Lists | Click baseline | Discovery rows | Default click = Info | Skin | Yes |  |
| Lists | Click baseline | Progress rows | Default click = Play | Skin | Yes |  |
| Lists | Show-level progress | Click behavior | Open deep-view, not direct play | Both | No |  |
| Lists | Empty state | Message | `No items available` | Skin | No |  |
| Lists | Card metadata | Poster cards | Image-only | Skin | No |  |
| Lists | Card metadata | Landscape cards | Image-only | Skin | No |  |
| Lists | Card metadata | Square cards | Image-only | Skin | No |  |

### 10.6 Info / Details

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| Info | Info action semantics | Destination | Full-screen details page (not small popup) | Both | No |  |
| Info | Spotlight fields | Field set | Title, Year, Runtime, one rating, short plot | Both | No |  |
| Info | Series deep-view | Layout model | Metadata + season tabs + episode row reuse | Skin | No |  |
| Info | Series deep-view | Focus fallback order | Next-after-completed -> in-progress -> first episode | Both | No |  |

### 10.7 OSD

| Scope | Item | Characteristic | Target Details | Owner | Implemented (Yes/No) | Verification |
|---|---|---|---|---|---|---|
| OSD | Control scope | Allowed controls | Play/Pause, Seek, Subtitles, Audio, Details | Skin | No |  |
| OSD | Details transition | First details action | Lightweight overlay | Both | No |  |
| OSD | Details transition | Second details action | Full details page | Both | No |  |
| OSD | Playback continuity | Return path | Closing full details returns to playback | Both | No |  |

