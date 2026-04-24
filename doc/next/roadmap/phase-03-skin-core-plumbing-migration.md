# Phase 03 - Skin Core Plumbing Migration

## Scope

Migrate control-plane skin wiring from helper-model dependencies to Velocity/native contracts, following D-038 Batch B.

## Inputs and Prerequisite Checks

- [D-038 Legacy Property Ledger](../../reference/d038-legacy-property-ledger.md)
- [D-015 Addon Required Lists Contract](../../target/d015-addon-required-lists-contract.md)
- [Screen-by-Screen Build Contract](../../target/screen-by-screen-build-contract.md)
- [Inventory 06 Actions Properties and Background Contracts](../../../inventory/06-actions-properties-and-background-contracts.md)

Checks:

- [x] Phase 02 accepted (see [Phase 02 validation report](./phase-02-validation-report.md))
- [x] Batch B in D-038 is locked ([D-038](../../reference/d038-legacy-property-ledger.md) §3 / §4)
- [x] Addon payload fixtures available ([phase-02-fixtures-mirror](./phase-02-fixtures-mirror.md) → addon `plans/phase02-fixtures/`)

## File-Level Touch List

Primary Batch B files:

- `1080i/Includes_Paths.xml`
- `1080i/Includes_Actions.xml`
- `1080i/Includes_DialogInfo.xml`
- `1080i/DialogVideoInfo.xml`
- `1080i/Dialog_DialogPlot.xml`
- `1080i/Custom_1114_Dialog_CustomPlot.xml`
- `1080i/Custom_1193_VideoOSDInfo.xml`
- `1080i/Includes_Search.xml`
- `1080i/Custom_1105_Search.xml` (temporary key retained by decision)

## Step-by-Step Execution Tasks

1. Migrate path-level contract variables (`Includes_Paths.xml`) to canonical Velocity/native IDs.
2. Simplify action dispatch (`Includes_Actions.xml`) to minimal required actions.
3. Rebind details composition (`Includes_DialogInfo.xml`) to retained details model.
4. Migrate details dialog guards and flow:
   - `DialogVideoInfo.xml`
   - `Dialog_DialogPlot.xml`
   - `Custom_1114_Dialog_CustomPlot.xml`
5. Rebind playback info bridge (`Custom_1193_VideoOSDInfo.xml`) to non-helper metadata.
6. Update search wiring in `Includes_Search.xml` to Velocity contracts.
7. Retain helper-named key in `Custom_1105_Search.xml` only as explicit temporary exception.
8. Remove dead helper branches in touched files where contract parity already exists.

## Validation Checklist (Runtime + Static)

- [ ] no regressions in details -> playback -> details loop
- [ ] search surfaces still operate in combined mode
- [ ] no missing paths from spotlight/rows to details/play
- [ ] helper-only action branches removed from Batch B files

## Acceptance Criteria (Pass/Fail)

- [ ] Batch B files migrated and functional
- [ ] active control-plane routing no longer depends on helper properties
- [ ] temporary exception list unchanged except documented items

## Abort / Rollback Guidance

- On critical navigation break:
  - stop
  - rollback only current file set for the failed slice
  - keep previous accepted slices intact

## Common Failure Modes and Detection

- **Failure:** path variables resolve `Null.xsp` unexpectedly  
  **Detect:** inspect focused-item transitions from rows to details and provider hubs.
- **Failure:** details dialog opens but no data loaded  
  **Detect:** verify required IDs and metadata are present in resolved item properties.

## If Blocked, Stop and Report

Report:

1. file and variable/action name
2. expected route or property
3. observed behavior and minimal repro

## Handoff to Phase 04

Proceed only after all Batch B acceptance checks pass.  
Next: [Phase 04 - Skin Removal and Policy Enforcement](./phase-04-skin-removal-and-policy-enforcement.md).

