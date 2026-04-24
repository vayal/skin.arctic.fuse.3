# Phase 04 - Skin Removal and Policy Enforcement

## Scope

Apply approved removals and enforce locked UX policies, especially D-021 and Batch A outcomes.

## Inputs and Prerequisite Checks

- [Skin Vision Blueprint](../../archive/skin-vision-blueprint-v0.md)
- [D-038 Legacy Property Ledger](../../reference/d038-legacy-property-ledger.md)
- [Screen-by-Screen Build Contract](../../target/screen-by-screen-build-contract.md)
- [Inventory 03 Dialogs Info and Context](../../../inventory/03-dialogs-info-and-context.md)
- [Inventory 04 OSD and Playback Surfaces](../../../inventory/04-osd-and-playback-surfaces.md)

Checks:

- [ ] Phase 03 accepted
- [ ] Batch A decisions in D-038 marked locked
- [ ] D-021 policy accepted in blueprint

## File-Level Touch List

Batch A targets:

- `1080i/Dialog_DialogContextMenu.xml`
- `1080i/Custom_1141_OSD_Cast.xml`
- `1080i/Dialog_DialogPVRInfo.xml`
- `1080i/DialogPVRChannelGuide.xml`
- `1080i/DialogPVRGuideSearch.xml`
- `1080i/DialogPVRChannelsOSD.xml`
- `1080i/Settings.xml`
- `1080i/Includes_SkinSettings.xml`
- `1080i/script-wikipedia.xml`
- `1080i/Custom_1120_Dialog_SelectCrew.xml`
- `1080i/Custom_1118_Dialog_Settings.xml`
- `1080i/Custom_1113_Dialog_Plot.xml` (simplify first; remove if dead)

## Step-by-Step Execution Tasks

1. Remove expanded context menu skin items per D-021.
2. Remove OSD cast surface and related helper bindings.
3. Remove PVR family surfaces and actions.
4. Remove helper addon settings entry points.
5. Remove helper-only wiki and crew selection flows.
6. Remove helper-only settings branch in `Custom_1118_Dialog_Settings.xml`.
7. Simplify `Custom_1113_Dialog_Plot.xml`:
   - keep only required behavior
   - remove file if no active dependency remains.
8. Re-run static references in touched files to ensure no dangling calls.

## Validation Checklist (Runtime + Static)

- [ ] removed context actions are inaccessible
- [ ] no PVR surfaces reachable in normal UX
- [ ] no wiki/crew helper dialogs reachable
- [ ] settings open without helper-specific entries
- [ ] no dead menu entries to removed windows/dialogs

## Acceptance Criteria (Pass/Fail)

- [ ] all Batch A removals implemented
- [ ] D-021 behavior exactly enforced
- [ ] no policy regressions in details/OSD/search core UX

## Abort / Rollback Guidance

- If a removal breaks active navigation:
  - stop
  - restore only minimal required node
  - document mismatch between policy and runtime dependency before retry

## Common Failure Modes and Detection

- **Failure:** hidden links still pointing to removed windows  
  **Detect:** search for affected window IDs in touched files.
- **Failure:** settings entry dead buttons  
  **Detect:** manually navigate settings landing and verify every visible item opens valid target.

## If Blocked, Stop and Report

Report:

1. removed item/window ID
2. remaining caller path
3. whether caller should be removed or rerouted

## Handoff to Phase 05

Proceed when all removals and policy checks pass.  
Next: [Phase 05 - Metadata and Rendering Migration](./phase-05-metadata-and-rendering-migration.md).

