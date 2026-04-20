# D-003 View Mode Matrix (Case-by-Case Lock)

Purpose:
- Enumerate all relevant screen/surface families that require an explicit view-mode decision.
- Lock one primary mode per surface/list family.
- No fallback mode switching in the target UX.

Status:
- Working decision sheet (fill `Decision` and `Notes`).

Mode options:
- `Standard`
- `Combined`
- `Wall`
- `N/A` (surface does not use hub mode system)

---

## 1) Hub and mini-hub surfaces (HomeSwitcher-backed)

| Surface ID | Surface/Window | Uses HomeSwitcher mode | Candidate modes | Decision | Notes |
|---|---|---|---|---|---|
| `HS-home` | Home hub (`HomeSwitcher.1101`) | Yes | Standard / Combined / Wall | Combined | locked single mode for curated UX |
| `HS-series` | Series hub (`HomeSwitcher.1102`) | Yes | Standard / Combined / Wall | Combined | locked single mode for curated UX |
| `HS-movies` | Movies hub (`HomeSwitcher.1103`) | Yes | Standard / Combined / Wall | Combined | locked single mode for curated UX |
| `HS-discover` | Discover hub (`HomeSwitcher.1104`) | Yes | Standard / Combined / Wall | Combined | keep aligned with search/discovery combined direction |
| `HS-nextaired` | NextAired (`HomeSwitcher.1106`) | Legacy/toggle-dependent | Standard / Combined / Wall / N/A | N/A | removed from main UX scope |
| `HS-pvr` | PVR/TV (`HomeSwitcher.1107`) | Legacy/toggle-dependent | Standard / Combined / Wall / N/A | N/A | all PVR functionality removed in this fork |
| `HS-weather` | Weather (`HomeSwitcher.1108`) | Legacy/toggle-dependent | Standard / Combined / Wall / N/A | N/A | out of current hub-UX scope; no mode decision in this phase |
| `HS-settingshub` | Settings hub (`HomeSwitcher.1109`) | Legacy/toggle-dependent | Standard / Combined / Wall / N/A | N/A | settings surfaces explicitly deferred for this phase |

Provider mini-hubs (if modeled through HomeSwitcher/generated hub includes):

| Surface ID | Surface/Window | Uses HomeSwitcher mode | Candidate modes | Decision | Notes |
|---|---|---|---|---|---|
| `HS-provider-netflix` | Provider mini-hub: Netflix | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-disney` | Provider mini-hub: Disney+ | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-prime` | Provider mini-hub: Prime Video | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-apple` | Provider mini-hub: Apple TV+ | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-hulu` | Provider mini-hub: Hulu | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-max` | Provider mini-hub: Max | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-paramount` | Provider mini-hub: Paramount+ | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-peacock` | Provider mini-hub: Peacock | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |
| `HS-provider-bbc` | Provider mini-hub: BBC iPlayer | likely | Standard / Combined / Wall | Combined | provider mini-hubs follow same stacked row philosophy |

---

## 2) Search/discovery/list surfaces (non-hub or mixed)

These typically do not use the HomeSwitcher mode variable directly, but still need explicit row/list view decisions.

| Surface ID | Surface | View-style decision needed | Candidate view styles | Decision | Notes |
|---|---|---|---|---|---|
| `SEARCH-main` | Search window (`Custom_1105_Search.xml`) | Yes | Combined / Standard (search mode) | Combined | locked by D-006 |
| `SEARCH-selector` | Search selector tabs (`Includes_Search.xml`) | Yes | N/A (tab IA), plus widget style family | N/A | selector IA is tab set, not HomeSwitcher mode |
| `DISCOVER-list` | Discover full list screens | Yes | Poster / Landscape / List (as applicable) | Poster (default) | use row-family defaults unless a list explicitly overrides |
| `GENRE-global` | Genre filtered global lists | Yes | Poster / Landscape / List | Poster | consistent with global trending rows |
| `GENRE-provider` | Provider genre lists | Yes | Poster / Landscape / List | Poster | consistent with provider trending/popular/genre rows |

---

## 3) Details/context/OSD surfaces (explicitly non-hub-mode)

These do not use HomeSwitcher mode but still require explicit display-mode choices to avoid fallback drift.

| Surface ID | Surface | Candidate display modes | Decision | Notes |
|---|---|---|---|---|
| `INFO-main` | Full details screen (`DialogVideoInfo.xml`) | full details only | Full details only | no small info dialog UX |
| `INFO-plot` | Plot/custom details (`Dialog_DialogPlot.xml`, `Custom_1114`) | simplified full-details bridge | Simplified bridge | align with no-small-dialog policy |
| `CTX-expanded` | Expanded context menu (`Dialog_DialogContextMenu.xml`) | keep/remove item-level set | Remove expanded dialog items | watched/unwatched + add-to-library delegated to addon logic |
| `OSD-main` | Main OSD (`Includes_OSD.xml`) | normal playback controls | Normal controls only | locked by D-027 direction |
| `OSD-pause-strip` | Pause info strip | minimal title + plot | Minimal title + plot | locked by D-027 direction |
| `OSD-bridge` | OSD info bridge (`Custom_1193`) | lightweight overlay -> full details | Lightweight overlay -> full details | locked by E2 behavior |

---

## 4) Row/card style matrix per agreed blueprint families

This complements mode decisions by locking visual row style where applicable.

| Row family | Target card/layout | Density | Default action | Decision status |
|---|---|---|---|---|
| Spotlight rows | Hero single-item | Hero | Info primary / Play secondary | locked in blueprint |
| In-progress episodes | Landscape | Balanced | Play | locked |
| In-progress shows | Poster | Balanced | Open show details | locked |
| In-progress movies | Poster | Balanced | Play | locked |
| Global trending rows | Poster | Balanced | Info | locked |
| Provider icon row | Square | Balanced | Open provider mini-hub | locked |
| Genre navigation row | Buttons/list-entry | Balanced | Open filtered list | locked |

---

## 5) Completion rule for D-003

D-003 can move from `modify` to `accept` when:
- Every active surface above has a filled `Decision`.
- Any non-applicable surface is explicitly marked `N/A` with reason.
- No surface relies on runtime fallback mode switching.

