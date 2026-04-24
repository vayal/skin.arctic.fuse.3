# Phase 2 — List implementation alignment

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Align shipped list wiring and behavior to D-015 |
| Out of scope | Non-list behavior redesign and freeze sign-off |

## Objective

Close all list-level contract drift by reconciling current routing, generator outputs, and UX behavior with Phase 1 (D-015) baseline.

## Inputs / references

- [Phase 1](./phase-01-contract-and-ia-baseline.md)
- [Phase 3](./phase-03-non-list-surfaces-implementation.md)
- [Phase 4](./phase-04-freeze-and-runtime-verification.md)
- [traceability-by-topic.md](../traceability-by-topic.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)

## Current alignment snapshot (starting point)

### Contracts already wired in skin

- Home: `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`
- Series: `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`
- Movies: `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`

### Major gaps to close

- Provider mini-hub contract families are defined but not skin-wired.
- `genre_global_*` and `search_*` explicit contract IDs are not the active route model.
- Home in-progress row parity and generator parity require hardening.
- In-row cap 10 / row-end next / image-only / empty-state consistency remain partial.

## Work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P2.1 | Refresh contract alignment matrix (used/not-used/out-of-scope) | - [ ] | - [ ] | |
| P2.2 | Resolve Home row URL parity and generator source parity | - [ ] | - [ ] | |
| P2.3 | Resolve paging behavior: cap-10, next item, header/full-list, 40/page | - [ ] | - [ ] | |
| P2.4 | Resolve row rendering policy: image-only cards + balanced density | - [ ] | - [ ] | |
| P2.5 | Resolve empty-state behavior consistency across list rows | - [ ] | - [ ] | |
| P2.6 | Resolve genre/search route policy (explicit contracts vs action routes) | - [ ] | - [ ] | |
| P2.7 | Document accepted deviations from D-015 with owner and rationale | - [ ] | - [ ] | |
| P2.8 | Produce runtime-ready verification checklist package for Phase 4 | - [ ] | - [ ] | |

## Execution checklist

### Route and contract alignment

- [ ] Reconcile all core hub rows against D-015 contract IDs
- [ ] Classify unresolved routes as `missing`, `deviation`, or `deferred`
- [ ] Confirm provider icon rows expose stable deep link targets

### Generator discipline

- [ ] Apply changes in generator source files first
- [ ] Regenerate includes
- [ ] Verify generated output matches intended route updates
- [ ] Commit source + generated output together

### UX behavior hardening

- [ ] Confirm spotlight never paginates
- [ ] Confirm in-row pagination model is consistent
- [ ] Confirm header click opens full list for same contract family
- [ ] Confirm image-only policy is applied on all contracted row families
- [ ] Confirm empty rows show explicit no-items state

## Verification checklist

- [ ] Focus and navigation checks for Home/1101/1102 list flows
- [ ] `Velocity.WidgetContainer` updates correctly per row focus
- [ ] No stale smart-rail aliases in core contract rows
- [ ] Any non-core smart rails are documented and justified

## Evidence to capture

- Diff links for updated route wiring
- Regen proof (source inputs + generated output updated)
- Contract alignment matrix revision note
- Runtime validation handoff list for Phase 4

## Blockers / risks

- Generator output can overwrite direct XML edits if source discipline is skipped.
- Contract-vs-action route policy decisions may remain unresolved without explicit acceptance.
- Mini-hub families can appear complete in addon while still absent in skin UX.

## Exit criteria

- [ ] P2.1-P2.8 complete and evidence-linked
- [ ] Contract matrix has no unclassified discrepancies
- [ ] All deviations are documented as accepted or deferred
- [ ] Runtime checklist is ready for Phase 4 execution

## Handoff

Update [ROADMAP_MASTER.md](../ROADMAP_MASTER.md) with Phase 2 status, pass non-list blockers to [Phase 3](./phase-03-non-list-surfaces-implementation.md), and pass runtime evidence tasks to [Phase 4](./phase-04-freeze-and-runtime-verification.md).


