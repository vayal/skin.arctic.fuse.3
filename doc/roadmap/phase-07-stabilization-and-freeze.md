# Phase 07 - Stabilization and Freeze

## Scope

Run end-to-end validation, reconcile traceability, and enforce final freeze gate.

## Inputs and Prerequisite Checks

- [Skin Vision Blueprint](../skin-vision-blueprint-v0.md)
- [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md)
- [D-015 Addon Required Lists Contract](../d015-addon-required-lists-contract.md)
- [D-038 Legacy Property Ledger](../d038-legacy-property-ledger.md)
- [Verification Checklists Appendix](./appendix-verification-checklists.md)
- [Traceability Matrix Appendix](./appendix-traceability-matrix.md)
- [Inventory Journeys](../../inventory/journeys/README.md)

Checks:

- [ ] Phases 01-06 accepted
- [ ] no unresolved blockers carried forward

## File-Level Touch List

- docs:
  - `doc/roadmap/appendix-traceability-matrix.md`
  - `doc/roadmap/appendix-verification-checklists.md` (if needed for final evidence links)
  - optional final status note in `doc/skin-vision-blueprint-v0.md` if freeze marker is desired

## Step-by-Step Execution Tasks

1. Validate primary UX flows end-to-end:
   - Home, Series, Movies hubs
   - provider mini-hubs
   - details, OSD, search
2. Validate pagination behavior:
   - in-row cap behavior
   - header/full-list navigation
   - full-list 40/page semantics
3. Validate context menu and removed surfaces policies:
   - D-021 policy enforced
   - removed PVR/weather/context extras not reachable
4. Validate metadata rendering:
   - image-only row cards
   - spotlight fields
   - pause strip behavior
5. Validate contract integrity:
   - D-015 schema assumptions are met by runtime behavior
6. Reconcile D-038 ledger with implementation status.
7. Update traceability appendix with final mapping and evidence pointers.
8. Execute freeze checklist and mark package ready.

## Validation Checklist (Runtime + Static)

- [ ] journey tests pass for browse-to-play, search-to-play, info-and-related
- [ ] no active helper dependency in approved migrated surfaces
- [ ] documented temporary exceptions only
- [ ] roadmap files and appendices internally consistent

## Acceptance Criteria (Pass/Fail)

- [ ] all phase acceptance gates passed
- [ ] traceability complete for D-003, D-015, D-021, D-038
- [ ] freeze checklist complete with no unresolved P0/P1 blockers

## Abort / Rollback Guidance

- If freeze checks fail:
  - do not mark freeze-ready
  - open targeted remediation item against failing phase
  - rerun only affected validation slices

## Common Failure Modes and Detection

- **Failure:** policy drift between docs and runtime behavior  
  **Detect:** cross-check route/action outcomes against screen-by-screen contract.
- **Failure:** undocumented exception remains  
  **Detect:** compare residual helper reference scan against D-038 ledger entries.

## If Blocked, Stop and Report

Report:

1. failed acceptance criterion
2. failing surface and repro
3. upstream phase owning remediation

## Handoff / Closure

When accepted, this roadmap package becomes execution-complete and freeze-ready.

