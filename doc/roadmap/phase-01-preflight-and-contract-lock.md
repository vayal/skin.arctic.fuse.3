# Phase 01 - Preflight and Contract Lock

Status: completed

## Scope

Freeze inputs, lock execution boundaries, and ensure all downstream phases can run without reopening design decisions.

## Inputs and Prerequisite Checks

Required references:

- [Skin Vision Blueprint](../skin-vision-blueprint-v0.md)
- [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md)
- [D-003 View Mode Matrix](../d003-view-mode-matrix.md)
- [D-015 Addon Required Lists Contract](../d015-addon-required-lists-contract.md)
- [D-038 Legacy Property Ledger](../d038-legacy-property-ledger.md)
- [Inventory Root](../../inventory/README.md)
- [Inventory 01 Home and Hubs](../../inventory/01-home-and-hubs.md)
- [Inventory 02 Search and Discovery](../../inventory/02-search-and-discovery.md)
- [Inventory 03 Dialogs Info and Context](../../inventory/03-dialogs-info-and-context.md)
- [Inventory 04 OSD and Playback Surfaces](../../inventory/04-osd-and-playback-surfaces.md)
- [Inventory Journeys](../../inventory/journeys/README.md)

Preflight checklist:

- [x] D-003 accepted and linked to `d003-view-mode-matrix.md`
- [x] D-015 accepted and linked to `d015-addon-required-lists-contract.md`
- [x] D-021 accepted in blueprint
- [x] D-038 accepted and linked to `d038-legacy-property-ledger.md`
- [x] No conflicting docs outside `doc/roadmap` required for execution

## File-Level Touch List

- docs only:
  - `doc/roadmap/*` (this package)
  - optional traceability updates in `doc/roadmap/appendix-traceability-matrix.md`

## Step-by-Step Execution Tasks

1. Confirm all canonical docs exist and are readable.
2. Confirm D-IDs (`D-003`, `D-015`, `D-021`, `D-038`) are accepted in blueprint.
3. Confirm ledger batches are locked and usable as execution constraints.
4. Record phase entry snapshot:
   - baseline branch state
   - active scope statement
   - explicit list of prohibited deviations
5. Freeze execution constraints:
   - no architecture changes
   - no extra UX decisions
   - no new route naming families outside D-015.
6. Confirm handoff readiness to Phase 02.

## Validation Checklist (Runtime + Static)

- [x] Static: all links in this phase doc resolve
- [x] Static: no unresolved `modify` items in roadmap-critical decisions
- [x] Static: D-015 contract has explicit pagination and ID rules
- [x] Static: D-038 has batch decisions and deferred exceptions defined

## Acceptance Criteria (Pass/Fail)

Pass only if all are true:

- [x] Canonical docs are frozen and cross-linked
- [x] Execution boundaries are explicit and documented
- [x] No remaining ambiguity in contract ownership (skin vs addon)

## Abort / Rollback Guidance

- If any required decision is found un-frozen or contradictory:
  - stop phase immediately
  - do not proceed to addon implementation
  - report exact conflicting sections and propose one reconciliation path

## Common Failure Modes and Detection

- **Failure:** hidden conflicting contract language  
  **Detect:** compare route/action expectations across blueprint, D-015, and screen contract.
- **Failure:** silent scope creep into settings/weather/PVR  
  **Detect:** check task list against out-of-scope surfaces before phase handoff.

## If Blocked, Stop and Report

Report:

1. blocking file and section
2. exact conflict
3. minimal decision needed to unblock

## Handoff to Phase 02

Only hand off when this phase is accepted.  
Next: [Phase 02 - Addon Contract Implementation](./phase-02-addon-contract-implementation.md)

## Completion Note

Phase 01 was completed after:

- roadmap package creation under `doc/roadmap/`
- decision lock confirmation in:
  - `doc/skin-vision-blueprint-v0.md`
  - `doc/d003-view-mode-matrix.md`
  - `doc/d015-addon-required-lists-contract.md`
  - `doc/d038-legacy-property-ledger.md`

