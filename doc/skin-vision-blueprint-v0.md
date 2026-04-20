# Skin Vision Blueprint v0 (draft)

Status: draft for discussion (not frozen)

This document captures the initial product vision before inventory decisions are finalized.

## 1) Primary navigation model

Main hubs (3 total):
- Home
- Series
- Movies

Philosophy note:
- Series and Movies hubs should follow the same overall philosophy and interaction model.

## 2) Home hub blueprint

### 2.1 Spotlight
- Content: trending movies and trending shows.
- Primary button: Info.
- Secondary button: Play.
- Intent: encourage "learn before watch" while keeping direct play available.
- Clarification: "Spotlight" here means the hero visual area at the top of the hub.
- Explicit behavior definition:
  - spotlight is a hero image zone that occupies nearly full screen height until user scrolls down.
  - it displays one media item at a time.
- UI direction from screenshot reference:
  - Swap button positions so Info is first.
  - Remove "More Information" text label in button copy.
  - Reduce Play button size/visual weight.
  - Keep both actions available, but make Info the default user tendency.
- Feed ordering rule (current decision):
  - use fixed alternation pattern for mixed media in Home spotlight.

### 2.2 Multipath widget (2 tabs)
- Tab A: In-progress series.
- Tab B: In-progress movies.
- Sorting: last watched (most recent first).
- Tab default behavior:
  - restore last used tab.

## 3) Series hub blueprint

### 3.1 Spotlight
- Content: trending TV shows.
- Layout: same interaction pattern as Home spotlight.
- Primary button: Info.
- Secondary button: Play.

### 3.2 Continue watching episodes (single row)
- Behavior: show either
  - in-progress episodes, or
  - next unwatched episode (only if already aired) for an in-progress show.
- Responsibility: this selection logic should be handled in the Velocity addon contract layer; skin should consume the exposed list.
- Priority rule (addon-side):
  - if both candidates exist, prefer in-progress episode.

### 3.3 In-progress shows (single row)
- Content: in-progress shows.
- Sorting: last watched date.

### 3.4 Trending networks (multipath tabs)
Updated direction (preferred):
- On Series hub, use a dedicated **global trending** widget first.
- Under it, add a **provider icon/widget row** for provider navigation.
- Provider selection should open a **provider mini-hub**.
- Each provider mini-hub should be part of a larger provider architecture:
  - one screen/menu item per provider,
  - structured similarly to core hubs (home-like philosophy).
- Provider set target size:
  - keep between 8 and 9 providers.
  - preferred popular services include: Netflix, Disney+, Amazon, Apple TV+, Hulu, plus additional major providers to complete the set.
- Provider icon row ordering:
  - fixed curated order.
- "All providers" entry:
  - no dedicated all-providers icon item.
- Empty-provider fallback:
  - if provider row/list unexpectedly has no content, show fallback behavior rather than leaving broken navigation.

## 4) Movies hub blueprint

Current direction:
- Should follow the same philosophy as Series hub.
- Exact rail composition still TBD and requires explicit definition.
- Clarification from discussion:
  - Movies hub should mirror Series philosophy.
  - Continue Watching / In-Progress duplication:
    - keep only one row (not both).

Candidate structure (subject to confirmation):
- Spotlight (trending movies; info-first action model).
- In-progress/continue movies (single row; final naming TBD).
- Global trending movies (single row).
- Provider icon/widget row -> provider mini-hub.

## 5) UX intent inferred from draft

- Navigation should stay simple and predictable.
- Spotlight is editorial/discovery-first with strong info action.
- Continue-watching should be practical and recency-aware.
- Multipath tabs are used where they reduce clutter (not everywhere).
- Addon/skin separation should be strict:
  - Addon defines advanced list semantics (for example "next unwatched but aired").
  - Skin controls layout, hierarchy, affordances, and interaction defaults.

## 6) Potential blindspots / dead-ends to resolve

1. Mixed media in Home spotlight
- A combined movie+show spotlight can be great for discovery, but may create inconsistent info/play behavior if metadata quality differs by type.

2. "Next unwatched but aired" logic
- This requires precise episode state and air-date filtering in provider contracts.
- If this logic is not reliable upstream, UI may look inconsistent.

3. "Trending networks/providers" source semantics
- Network, provider, channel, and service are often different taxonomies.
- Decision needed on exact dimension and fallback behavior when data is sparse.
- There may be a conflict between "cross-provider discovery in one place" and "provider-specific drilldown", requiring a two-layer structure (mixed discovery rail + provider submenu).

4. Missing Movies hub definition
- Without a concrete Movies hub design, parity between Series and Movies may drift.

5. Info-first spotlight interaction
- Strong choice, but needs clear remote-control defaults and focus behavior consistency across hubs.
- Button order, copy, and button size hierarchy should be intentionally consistent between Home/Series/Movies hero zones.

6. Over-customization risk
- If this stays personal-use-focused, too many toggles may conflict with the simplicity goal.

## 7) Decision placeholders (to fill after discussion)

- Hub IA frozen: no / yes
- Spotlight card action model frozen: no / yes
- Continue-watching episode rule frozen: no / yes
- Provider/network taxonomy frozen: no / yes
- Movies hub design frozen: no / yes
- "Hardcoded vs configurable" policy frozen: no / yes

## 8) Open questions for v1 refinement

1. Home spotlight composition
- Should Home spotlight be mixed (movies + series) in one feed, or alternate by day/session?

2. Spotlight defaults
- Should remote focus default to Info button or to the content card itself?

3. Spotlight metadata density
- Keep current spotlight metadata for now (no immediate change).

4. Series hub row order
- Confirm final order after spotlight:
  1) continue watching episodes
  2) in-progress shows
  3) global trending series
  4) provider icon/widget row

5. Provider taxonomy
- Decision trend: move toward provider-based navigation with global trending separate.
- Exact provider list still needs explicit definition (8-9).

6. "Dive deeper" behavior
- Should provider submenu buttons open:
  - provider mini-hub by default (selected direction),
  - with architecture support for one provider hub/screen per provider.

7. Movies hub symmetry
- Direction selected: Movies should mirror Series philosophy.

8. Hardcoding policy for personal fork
- Which areas should remain configurable versus hardcoded from day one?

## 9) Interim decisions captured from discussion

- Home spotlight feed: mixed movies + series (single feed).
- Home spotlight sequencing: fixed alternation pattern.
- Spotlight default focus: Info button.
- Spotlight metadata: keep current for now.
- Series trending strategy:
  - Row 1: global trending series.
  - Row 2: provider icon/widget navigation.
  - Provider click: open provider mini-hub.
  - Architecture target: one provider hub/screen per provider menu item.
  - Continue-watching selection priority: in-progress episode first when both candidates exist (addon logic).
  - In-progress shows sort: last watched date.
- Movies hub: mirror Series philosophy.
  - Use only one row and name it "In Progress".
- Initial implementation feeling target:
  - use single-line widgets/rows first and evaluate UX feel before increasing visual density.
- Home simplification policy:
  - keep extra rows minimal for now and refine with user feedback.
- Data source boundary:
  - global trending and "next unwatched aired" semantics should come from Velocity addon contracts/lists.

## 10) Provider hub visual direction (initial)

- Current idea: show a distinct provider identity when inside a provider hub.
- Possible implementation vector: use spotlight/hero treatment to expose current provider branding/context.
- Open UX point: define how strong branding should be versus content prominence.
- Provider hub layout (current decision):
  - Spotlight/provider context (current workaround accepted for now),
  - trending shows,
  - most popular,
  - 4 genre rows.
- Navigation model:
  - no submenu buttons inside provider hub; rely on stacked widgets/rows for controller usability.

## 11) Planning scope policy (discussion stage)

- At this stage, optimize for a complete UI/UX target state definition.
- Do not split into implementation phases until vision is declared frozen.

## 12) Additional decisions captured

### 12.1 Provider roster (proposed v1 set, 9 items)

Fixed curated order (proposal):
1. Netflix
2. Disney+
3. Prime Video
4. Apple TV+
5. Hulu
6. Max
7. Paramount+
8. Peacock
9. BBC iPlayer

Status: proposed for confirmation.

### 12.2 Naming and labels

- Main/global rows:
  - `Trending Now` (global)
- Provider rows:
  - `Trending on <Provider>`
- Movies progress row:
  - `In Progress`

### 12.3 Empty-state behavior

- If a provider list unexpectedly has no items, show explicit message:
  - `No items available`

### 12.4 Genre discovery direction

- On main Series and Movies hubs:
  - add a genre navigation widget (buttons) to enter genre-specific global trending lists.
- Inside provider mini-hubs:
  - keep dedicated genre rows (4 rows as previously decided).

## 13) Required detailed UI spec still to define

The following still needs explicit definition before freeze:

1. Per-widget visual layout
- card style per row (`poster`, `landscape`, `square`, etc.)
- row height/density
- item count/peek behavior

2. Per-widget click behavior
- default click action per row (`info`, `play`, `open details`, `open list`)
- long-press/context behavior (if any)

3. Media info field strategy by surface
- which labels/metadata are shown in spotlight vs row cards vs details pages
- differences for movies vs series vs episodes

4. OSD behavior model
- which OSD actions are available
- what info is shown and when
- transitions from OSD to details pages

5. Fallback rules by surface
- what to hide vs what to show when data is missing
- consistency of "No items available" messaging

6. Pagination and deep-dive behavior
- max items shown per widget row before "Next Page" style affordance
- whether "Next Page" should always open full list view
- page size defaults per list family

## 14) Widget spec decisions (first pass)

### 14.1 Home hub

- Home spotlight:
  - Type: hero spotlight (single-item full-height style; not a standard row)
  - Density: hero
  - Default click/focus intent: Info-first interaction model
- Home in-progress series:
  - Card type: `poster`
  - Density: `balanced`
  - Default click: `play`
- Home in-progress movies:
  - Card type: `poster`
  - Density: `balanced`
  - Default click: `play`

### 14.2 Series hub

- Series spotlight:
  - Type: hero spotlight (single-item full-height style)
  - Card/click tuple: same as Home spotlight (Info primary, Play secondary, same visual hierarchy)
- Series continue watching episodes:
  - Card type: `landscape`
  - Density: `balanced`
  - Default click: `play`
- Series in-progress shows:
  - Card type: `poster`
  - Density: `balanced`
  - Default click: `play`
- Series global trending:
  - Card type: `poster`
  - Density: `balanced`
  - Default click: `info`
- Series provider icon row:
  - Card type: `square`
  - Density: `balanced`
  - Default click: `Open Provider Hub`

### 14.3 Notes

- Single-line rows are the current baseline for feel testing.
- Spotlight behavior is distinct from row cards and should be treated as a dedicated interaction surface.

## 15) Movies hub structure and behavior decisions

### 15.1 Row order

Selected order: `A2`
- Spotlight
- In Progress
- Global Trending
- Provider Icons
- Genre Navigation Buttons

### 15.2 Genre navigation behavior

Selected behavior: `B2`
- Genre button opens a filtered list page.

### 15.3 Provider hub genre strategy

Selected behavior: `C1`
- Use fixed same genre set across provider hubs.
- Note: candidate to expand fixed set with additional genres.

### 15.4 Empty-state policy

Selected behavior: `D2`
- If a row has no content, keep row and show explicit message:
  - `No items available`

### 15.5 Default click policy

Base policy: `E1`
- Discovery rows default to `info`.
- Progress rows default to `play`.

Exception:
- In-progress shows row (show-level items, not episode-level items):
  - default click should open show details/season navigation (not direct play).

## 16) New requirement captured: list limits and paging

Need explicit per-widget-family contract:
- max items shown in-row
- when and where to show a `Next Page` affordance
- target list screen behavior when `Next Page` is activated
- page size per list type in full-list mode

## 17) Pagination and list-behavior decisions

### 17.1 In-row max items

Selected baseline: `L1`
- Max items per row before paging affordance: 10

### 17.2 Next-page affordance style

Selected behavior: `N3`
- Use both:
  - explicit row-end `Next Page` affordance, and
  - row-header click opening full filtered list.

Critical exception (spotlight):
- Spotlight source lists must be dedicated non-paginated feeds.
- Spotlight must never show a next-page item/button.
- Reason: next-page in hero/spotlight breaks visual integrity.

### 17.3 Full-list page size

Selected behavior: `P3`
- Default full-list page size: 40 items.

### 17.4 Row header behavior

Selected behavior: `H1`
- Row title click should open the full filtered list for that row.
- Note: current skin behavior may not fully support this everywhere; implementation contract will need explicit support.

### 17.5 Show-level click behavior requirement

For show-level rows (for example `In Progress Shows`):
- user should navigate into series deep-view, not direct playback.
- target series layout model:
  - combined landscape layout
  - top metadata/info region
  - lateral season tabs
  - bottom episode landscape row
  - this layout already exists in current skin and should be reused.

Default episode focus policy candidates (to choose/finalize):
1. first episode in current context
2. most recently watched in-progress episode
3. next episode after most recently completed one

### 17.6 Fixed genre set (current)

Selected genre list:
- Action
- Comedy
- Drama
- Thriller
- Romance
- Sci-Fi
- Crime
- Animation

## 18) Details and OSD decisions (current)

### 18.1 Spotlight info fields

Selected behavior: `A1`
- Spotlight shows:
  - title
  - year
  - runtime
  - one rating
  - short plot

### 18.2 Details page terminology and target

Clarification captured:
- "Info" action means opening a full-screen details page (not a small dialog popup).

Primary target files/surfaces to align with this behavior:
- `1080i/DialogVideoInfo.xml` (current main details surface)
- `1080i/Includes_DialogInfo.xml` (details content composition)
- `1080i/Dialog_DialogPlot.xml` and `1080i/Custom_1114_Dialog_CustomPlot.xml` (extended plot/details flow)

### 18.3 OSD controls scope

Selected behavior: `D1`
- Minimal OSD controls:
  - play/pause
  - seek
  - subtitle
  - audio
  - details entry action

### 18.4 Series deep-view episode focus policy

Selected behavior: `F4`
- Fallback order:
  1) next episode after most recently completed
  2) most recently watched in-progress episode
  3) first episode

### 18.5 Row card default metadata visibility

Selected behavior (`B`):
- Poster cards: image-only by default.
- Landscape cards: image-only by default.
- Square cards: image-only by default.

Implication:
- No title/metadata overlays in row cards by default.
- Metadata appears in spotlight/details contexts, not in row-card chrome.

### 18.6 OSD -> details transition

Selected behavior (`E2`) as current intent:
- First details action from OSD opens a lightweight overlay.
- Second details action opens full details page.

E2 interaction definition draft (for confirmation):
1. User presses `Info/Details` while playback is active.
2. System opens a lightweight OSD overlay showing only a minimal title + plot strip.
3. If user presses `Info/Details` again (or selects `More Details` in overlay), system opens full details page.
4. Closing full details returns user to playback.

## 19) Full unresolved decision table (working set)

Use this table to close all remaining UX decisions before freeze.
Suggested values are recommendations only.

Legend:
- Priority: `P0` (must decide soon), `P1` (important), `P2` (can defer)
- Decision: fill with `accept`, `modify`, or `defer`

| ID | Screen/Surface | Decision topic | Current state | Suggested default | Priority | Decision | Notes |
|---|---|---|---|---|---|---|---|
| D-001 | Home/Hubs | Keep/remove `nextaired-home-rails` | Present in inventory, not aligned to current core 3-hub vision | Remove from main UX (or move to optional/deferred surface) | P1 | accept | remove |
| D-002 | Home | Home submenu static items | Exists via generator includes | Keep minimal (or none) in v1; avoid extra clutter | P1 | accept | remove |
| D-003 | Home/Hubs | Keep all hub widget modes (`standard/combined/wall`) | Multiple modes coexist | Hardcode one primary mode for personal fork | P1 | accept | locked via `doc/d003-view-mode-matrix.md` with case-by-case decisions and no fallback mode switching |
| D-004 | Search | Keep/remove autocomplete dropdown | Still available | Remove or disable by default for cleaner controller flow | P1 | accept | keep current |
| D-005 | Search | Final selector tabs list | Not explicitly locked | Keep only core tabs used weekly | P0 | accept | Option A: Discover, Movies, TV Shows |
| D-006 | Search | Search mode strategy | Combined+standard both exist | Hardcode one (recommended combined) | P1 | accept | combined for movies and series |
| D-007 | Search | Discovery empty behavior | Not locked | Show `No items available` in-row | P1 | accept | keep current behavior (agreed) |
| D-008 | Series | Provider roster finalization (8-9 exact order) | Proposed list exists | Confirm list and lock order | P0 | accept | user agreed on locking curated provider roster |
| D-009 | Series/Movies | Provider branding strength in hero | Mentioned as uncertain | Medium/subtle branding (content first) | P1 | accept | subtle first (content artwork dominant) |
| D-010 | Series/Movies | Global row title copy | `Trending Now` proposed | Accept `Trending Now` | P2 | accept | Trending |
| D-011 | Series/Movies | Provider row title copy | `Trending on <Provider>` proposed | Accept `Trending on <Provider>` | P2 | accept | Trending on <Provider> |
| D-012 | Movies | Final UI copy for in-progress row | Concept decided; naming semi-locked | Use `In Progress` | P1 | accept | In Progress |
| D-013 | Movies | Final Movies row specs | Partially defined | Mirror Series philosophy exactly where possible | P0 | accept | user agreed |
| D-014 | Genre discovery | Main-hub genre button placement | Decided conceptually | Keep at end of hub rows (after provider icons) | P1 | accept | user agreed |
| D-015 | Genre discovery | Genre button target behavior | Decided `B2` filtered list | Confirm final list route contract shape | P0 | accept | locked in `doc/d015-addon-required-lists-contract.md` with standardized media-specific provider/genre routes and explicit contract guarantees |
| D-016 | Provider mini-hub | Final row order inside provider hub | Mostly defined | Spotlight -> Trending -> Most Popular -> 4 Genre rows | P0 | accept | user agreed |
| D-017 | Provider mini-hub | Genre set fixed list viability | Fixed list chosen | Accept fixed 8 genres globally | P1 | accept | fixed global genre set |
| D-018 | Details page | Final content depth in details page | Broadly undecided | Balanced: key metadata + plot + trailer + limited related rows | P0 | accept | remove Wikipedia, person widgets, cast rows, crew widgets, extra buttons |
| D-019 | Details page | Keep/remove person/crew deep rails | Historically helper-heavy | Remove/defer by default | P1 | accept | remove |
| D-020 | Details page | Keep/remove extended custom plot mode depth | Exists and complex | Keep simplified mode only | P1 | accept | no small info dialogs; keep full info/details screens only |
| D-021 | Context menu | Final action set in expanded context menu | Not fully locked | Keep only high-value actions (details, trailer, provider/global discover jump) | P0 | accept | remove skin expanded items (Plot/Wiki/Discover jump/Trailer/Add-to-menu-node/View options); keep only Velocity addon context items; no fallback |
| D-022 | OSD | Keep/remove playlist OSD dialog | Available | Keep only if heavily used; otherwise remove | P1 | accept | remove |
| D-023 | OSD | Keep/remove cast OSD dialog | Hidden currently | Remove/defer permanently | P1 | accept | remove |
| D-024 | OSD | Keep/remove PVR info extras | Present | Remove/defer for non-PVR personal flow | P1 | accept | remove all PVR functionality for this personal-use fork |
| D-025 | OSD | OSD next recommendation behavior | Exists | Keep, driven by addon list semantics | P2 | accept | remove |
| D-026 | OSD | E2 overlay content exact fields | Title+plot strip decided | Lock as title + short plot only | P0 | accept | user agreed |
| D-027 | OSD | Overlay controls on first press | Not explicit | No extra controls; second press opens details page | P1 | accept | OSD during playback shows normal media controls only; on pause show minimal title + plot |
| D-028 | Paging | `Next Page` row-end tile everywhere except spotlight | Decided conceptually | Keep N3 + spotlight hard exception | P0 | accept | user agreed |
| D-029 | Paging | Row header click opens full list (`H1`) | Desired but may need implementation work | Keep H1 and enforce contract | P0 | accept | user agreed |
| D-030 | Paging | Page size 40 globally | Chosen | Accept 40 global default | P2 | accept | 40 items per page (not a hard list cap); use Next Page for continuation |
| D-031 | Empty-state | Global empty behavior | Chosen D2 | Accept `No items available` consistently | P0 | accept | user agreed |
| D-032 | Card chrome | Image-only cards for poster/landscape/square | Chosen | Accept globally | P0 | accept | user agreed |
| D-033 | Focus behavior | Spotlight focus defaults | Info-first chosen | Accept and apply across Home/Series/Movies | P0 | accept | user agreed |
| D-034 | Settings | Minimal retained settings set | Not defined | Keep only high-value user toggles; hardcode rest | P1 | modify | explicit defer: do not change settings surfaces in this phase; settings cleanup is a later dedicated phase |
| D-035 | Settings | Keep/remove shortcut editor UI | Present but complex | Defer/remove from user-facing flow | P1 | accept | remove/hide |
| D-036 | Settings | Keep/remove legacy helper settings entries | Still present in settings files | Remove to reduce confusion | P1 | accept | remove legacy helper settings entries; preserve media info/progress labels (watched/in-progress/unwatched) |
| D-037 | Contracts | Action dispatch simplification level | Mixed legacy/stateful complexity | Simplify to minimal required actions | P1 | accept | medium simplification |
| D-038 | Contracts | Remaining legacy property-model references | Deprecated but present in places | Retire where possible; leave documented exceptions only | P1 | modify | agreed direction; create explicit inventory list and document exceptions before lock |
| D-039 | Generator | Hardcode vs keep full generator flexibility | Not finalized | Keep generator, but hardcode default outputs for primary hubs | P1 | accept | agreed |
| D-040 | Generator | Search alias families beyond current scope | Partial mappings and legacy aliases exist | Trim to used aliases only | P1 | accept | trim to used aliases only (Discover/Movies/TV) |
| D-041 | Visual consistency | Row density baseline | `balanced` chosen in many rows | Accept balanced as global default | P2 | accept | balanced |
| D-042 | Visual consistency | Hero metadata set (A1) permanence | Chosen for now | Accept A1 unless user testing says otherwise | P2 | accept | lock for now |
| D-043 | Data contracts | Addon list requirements for all target rows | Mentioned broadly | Enumerate required addon lists as explicit contract appendix | P0 | accept | user agreed |
| D-044 | Data contracts | Spotlight dedicated non-paginated feeds | Chosen | Enforce as hard contract | P0 | accept | user agreed |
| D-045 | Freeze criteria | Vision freeze gate | Not yet defined | Freeze when all P0/P1 rows are `accept` or `modify` (no blanks) | P0 | modify | go through all items explicitly before freeze |

## 20) Suggested closure workflow for this table

1. Resolve all `P0` rows first.
2. Resolve `P1` rows next in batches by screen.
3. Mark `P2` as accept/defer.
4. After all `Decision` cells are filled, declare blueprint frozen.
