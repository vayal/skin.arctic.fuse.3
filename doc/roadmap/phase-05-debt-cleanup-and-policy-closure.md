# Phase 5 — Debt cleanup and policy closure

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Residual helper debt and deferred product-policy decisions |
| Out of scope | Rewriting baseline contracts without explicit decision |

## Objective

Close residual technical debt and deferred policy decisions after freeze, with explicit accept/remove/defer outcomes and verification evidence.

## Inputs / references

- [Phase 2](./phase-02-list-implementation-alignment.md)
- [Phase 3](./phase-03-non-list-surfaces-implementation.md)
- [Phase 4](./phase-04-freeze-and-runtime-verification.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)
- [traceability-by-topic.md](../traceability-by-topic.md)

## Debt and policy closure scope

### Helper/property debt

- Remove undeclared `TMDbHelper` / `themoviedb.helper` dependencies from migrated surfaces.
- Keep only explicit D-038 exceptions with owner and rationale.
- Re-run grep after each slice and reconcile results into D-038.

### Deferred product policy

- Finalize PVR `1107` policy (`keep`, `velocity-only`, `hybrid`) and implement consistently.
- Resolve remaining deferred non-list policy items handed off from Phase 3.

## Work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P5.1 | Baseline grep audit captured for helper symbols | - [ ] | - [ ] | |
| P5.2 | Remove/replace undeclared helper symbols in prioritized batches | - [ ] | - [ ] | |
| P5.3 | Reconcile every remaining helper hit into D-038 exceptions | - [ ] | - [ ] | |
| P5.4 | Decide and implement PVR 1107 policy | - [ ] | - [ ] | |
| P5.5 | Verify PVR behavior under with/without addon/channels matrix | - [ ] | - [ ] | |
| P5.6 | Close deferred non-list policy items from Phase 3 | - [ ] | - [ ] | |
| P5.7 | Update roadmap/master closure state and accepted exceptions | - [ ] | - [ ] | |

## Execution checklist

### Helper debt workflow

- [ ] Run helper grep across XML/JSON
- [ ] Classify each hit as `remove`, `replace`, or `accepted exception`
- [ ] Implement in small batches and re-grep each batch
- [ ] Update D-038 immediately for accepted exceptions

### PVR policy workflow

- [ ] Record chosen policy (`keep` / `velocity-only` / `hybrid`)
- [ ] Update gating logic in `Includes_Home.xml` and related controls
- [ ] Update docs and phase links to reflect final policy
- [ ] Verify runtime behavior for all relevant PVR states

## Verification checklist

- [ ] No undeclared helper symbols remain in migrated surfaces
- [ ] D-038 matches current code reality
- [ ] PVR behavior matches chosen policy in runtime tests
- [ ] All deferred policy items are either resolved or explicitly accepted

## Evidence to capture

- Grep snapshot before and after each debt batch
- D-038 diff entries for each accepted exception
- PVR decision record and runtime proof matrix
- Final closure update in `ROADMAP_MASTER.md`

## Blockers / risks

- Helper replacement can break UX when dependency boundaries are implicit.
- PVR policy needs explicit product acceptance, not technical defaulting.
- Post-freeze cleanups can regress runtime behavior without retesting.

## Exit criteria

- [ ] P5.1-P5.7 complete and evidence-linked
- [ ] Every helper hit is removed/replaced or explicitly accepted in D-038
- [ ] PVR policy is implemented, tested, and documented
- [ ] Master roadmap reflects final program closure and exceptions

## Handoff

Publish final closure state in [ROADMAP_MASTER.md](../ROADMAP_MASTER.md) and keep accepted long-tail exceptions only in [D-038](../context/d038-legacy-properties-and-mapping.md).
