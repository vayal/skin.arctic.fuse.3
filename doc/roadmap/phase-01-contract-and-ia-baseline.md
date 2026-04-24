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

