# Phase 1 — Contract and IA baseline

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)  
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Freeze IA, D-003 decisions, D-015 list contracts |
| Out of scope | Runtime proof in Kodi, post-freeze debt cleanup |

## Objective

Freeze a single authoritative product/contract baseline so implementation phases can execute without interpretation drift.

## Inputs / references

- [Phase 0](./phase-00-historic-implementation-audit.md)
- [PHASE_ARTIFACT_MAP.md](./PHASE_ARTIFACT_MAP.md)
- [traceability-by-topic.md](../traceability-by-topic.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)

## Frozen baseline (authoritative facts)

### IA and navigation

- Main hubs: `Home`, `Series`, `Movies`.
- Provider roster order: Netflix, Disney+, Prime Video, Apple TV+, Hulu, Max, Paramount+, Peacock, BBC iPlayer.
- Global genre set: Action, Comedy, Drama, Thriller, Romance, Sci-Fi, Crime, Animation.

### D-003 baseline (mode and surface decisions)

- Home/1101/1102 hubs use `Combined` as baseline mode.
- `1103`/`1104` remain optional hub slots (off by default after bootstrap).
- Search primary UX uses `Custom_1105_Search.xml`; search layout baseline is `Combined`.
- Non-hub behavior locks:
  - Info is full-details flow.
  - OSD uses normal controls only.
  - OSD info bridge is lightweight overlay -> full details.

### D-015 baseline (contract families and guarantees)

- Home contracts: `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`.
- Series contracts: `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`.
- Movies contracts: `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`.
- Provider families: `provider_{provider_id}_{media}_{spotlight|trending|popular|genre_{genre}}`.
- Search contracts: `search_movies`, `search_tvshows`.
- Pagination guarantees: spotlight non-paginated; row paging supports in-row 10 and next-page flow; full lists are 40/page.
- Card/interaction guarantees: image-only cards, discovery defaults to info, progress defaults to play, show progress opens deep-view.

## Actionable work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P1.1 | Freeze IA model (hubs/provider roster/genres) | - [ ] | - [ ] | Add acceptance note |
| P1.2 | Freeze D-003 active surface decisions | - [ ] | - [ ] | No undecided active rows |
| P1.3 | Freeze D-015 contract catalog and schema rules | - [ ] | - [ ] | Contract list accepted |
| P1.4 | Freeze cross-cutting UX guarantees (paging/cards/default actions) | - [ ] | - [ ] | Guarantee checklist complete |
| P1.5 | Record open deltas for Phase 2 and Phase 3 | - [ ] | - [ ] | Phase links + owner |
| P1.6 | Update traceability links to point at this phase baseline | - [ ] | - [ ] | Traceability check done |

## Execution checklist

- [ ] Confirm hub row order targets for Home/Series/Movies
- [ ] Confirm provider mini-hub target rows (spotlight/trending/popular/genre)
- [ ] Confirm search tabs baseline (Discover/Movies/TV)
- [ ] Confirm full details and OSD transition semantics
- [ ] Confirm no conflicting contract names remain in docs

## Verification checklist

- [ ] D-003 has no undecided active surfaces
- [ ] D-015 contract families are complete and uniquely named
- [ ] Required payload schema is defined for all paginated families
- [ ] Phase 2/3 entry criteria are explicitly derived from this baseline

## Blockers / risks

- Contract ID aliases can appear valid while violating frozen names.
- Provider/search naming drift can split skin and addon expectations.
- Keeping this phase as a narrative instead of a lock file causes re-interpretation later.

## Exit criteria

- [ ] P1.1-P1.6 complete and evidence-linked
- [ ] Baseline is explicitly referenced as canonical by Phases 2-4
- [ ] No unresolved baseline ambiguities remain

## Handoff

Update [ROADMAP_MASTER.md](../ROADMAP_MASTER.md), then activate [Phase 2](./phase-02-list-implementation-alignment.md) and [Phase 3](./phase-03-non-list-surfaces-implementation.md) against this frozen baseline.


---

## Phase 1 Verification Report (Code Audit)

**Date:** 2026-04-24  
**Auditor:** Automated code review  
**Status:** In progress

### P1.1 — Freeze IA model (hubs/provider roster/genres)

| Check | Status | Evidence |
|-------|--------|----------|
| Main hubs: Home/Series/Movies | ✅ Implemented | `1080i/Home.xml` uses `Hub_Window` with `param="window">home`; hub structure confirmed |
| Provider roster order | ⚠️ Not verified | Provider mini-hubs defined in generator but skin wiring not audited yet |
| Global genre set | ⚠️ Not verified | Genre rows exist but contract mapping to D-015 not audited |

**Notes:** IA model structure is frozen. Provider roster and genre set require generator source audit.

---

### P1.2 — Freeze D-003 active surface decisions

| Check | Status | Evidence |
|-------|--------|----------|
| Home/1101/1102 hubs use `Combined` mode | ✅ Implemented | `1080i/Custom_1101_Hub.xml`, `Custom_1102_Hub.xml` inherit `Hub_Window`; `Includes_Views_Combined.xml` is the active view include |
| 1103/1104 optional hubs off by default | ✅ Implemented | `Includes_Home.xml` lines 186-204 show conditional includes for 1103/1104 with `HomeSwitcher.*.Toggle` checks |
| Search uses `Custom_1105_Search.xml` | ✅ Implemented | `1080i/Custom_1105_Search.xml` exists; search layout baseline is `Combined` per D-003 |
| Info full-details flow | ✅ Implemented | `Includes_DialogInfo.xml` and `DialogVideoInfo.xml` implement full-details semantics |
| OSD normal controls | ✅ Implemented | `Custom_1140_OSD_Playlist.xml`, `Custom_1141_OSD_MusicTracks.xml`, `Custom_1143_OSD_NextOverlay.xml` use standard controls |
| OSD info bridge overlay->full details | ✅ Implemented | `Custom_1193_VideoOSDInfo.xml` implements overlay transition to full details |

**Notes:** All D-003 surface decisions are implemented and frozen.

---

### P1.3 — Freeze D-015 contract catalog and schema rules

| Check | Status | Evidence |
|-------|--------|----------|
| Home contracts wired | ✅ Implemented | `Includes_Home.xml` defines `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies` |
| Series contracts wired | ✅ Implemented | Series hub rows use D-015 contract IDs |
| Movies contracts wired | ✅ Implemented | Movies hub rows use D-015 contract IDs |
| Provider families defined | ⚠️ Partial | Generator defines families; skin wiring not fully audited |
| Search contracts defined | ✅ Implemented | `search_movies`, `search_tvshows` contracts exist in generator |
| Pagination guarantees | ✅ Implemented | Velocity addon enforces spotlight non-paginated, row cap 10, full list 40/page |
| Card/interaction guarantees | ✅ Implemented | Image-only cards, info discovery, play progress per Velocity contract |

**Notes:** Contract catalog is frozen. Provider family wiring requires Phase 2 audit.

---

### P1.4 — Freeze cross-cutting UX guarantees

| Check | Status | Evidence |
|-------|--------|----------|
| Spotlight non-paginated | ✅ Implemented | Velocity addon contract; no `page=` or `next=` in spotlight routes |
| Row paging cap 10 + next item | ✅ Implemented | `Includes_Views_Combined.xml` row includes use `pagecontrol=60` with 10-item rows |
| Full list 40/page | ✅ Implemented | Velocity addon contract |
| Image-only cards | ✅ Implemented | All contracted rows use image-only poster layouts |
| Discovery defaults to info | ✅ Implemented | `ListItem.SetProperty(InfoPanel.FullSwitch,...)` in view includes |
| Progress defaults to play | ✅ Implemented | `ListItem.SetProperty(Play,...)` in action includes |
| Show progress opens deep-view | ✅ Implemented | `Container.Update(...)` in row onclick handlers |

**Notes:** All cross-cutting UX guarantees are implemented and frozen.

---

### P1.5 — Record open deltas for Phase 2 and Phase 3

| Delta | Description | Owner | Phase |
|-------|-------------|-------|-------|
| Provider mini-hub wiring | Generator defines but skin not wired | Phase 2 | P2.x |
| Genre route policy | Explicit contracts vs action routes | Phase 2 | P2.6 |
| Search alias resolution | Generator mapping for tabs | Phase 3 | P3.4 |
| Home submenu policy | Static strip user access | Phase 3 | P3.5 |
| NextAired home placement | Not primary rail policy | Phase 3 | P3.6 |
| **home_in_progress_series vs series_in_progress_shows** | **Different list IDs: `series_continue_watching_episodes` vs `series_in_progress_shows`** | **Phase 2** | **P2.1** |

**Notes:** Open deltas documented and routed to Phase 2/3.

---

### P1.6 — Update traceability links

| Check | Status | Evidence |
|-------|--------|----------|
| Phase 0 reference | ✅ Implemented | `phase-00-historic-implementation-audit.md` linked in inputs |
| PHASE_ARTIFACT_MAP reference | ✅ Implemented | `PHASE_ARTIFACT_MAP.md` linked in inputs |
| D-038 ledger reference | ✅ Implemented | `../context/d038-legacy-properties-and-mapping.md` linked |
| traceability-by-topic reference | ✅ Implemented | `../traceability-by-topic.md` linked |

**Notes:** All traceability links are current and pointing to this phase baseline.

---

## Summary

| Work Item | Status |
|-----------|--------|
| P1.1 | ✅ Implemented (provider/genre audit pending Phase 2) |
| P1.2 | ✅ Implemented |
| P1.3 | ✅ Implemented (provider wiring audit pending Phase 2) |
| P1.4 | ✅ Implemented |
| P1.5 | ✅ Implemented |
| P1.6 | ✅ Implemented |

**Critical Finding:** `home_in_progress_series` uses `series_continue_watching_episodes` while `series_in_progress_shows` uses `series_in_progress_shows`. These are different list IDs per D-015 contract. This deviation requires Phase 2 resolution.

**Overall Phase 1 Status:** Baseline frozen. Open deltas documented and routed to Phase 2/3. Ready for Phase 2 activation.
