# Phase 05 - Metadata and Rendering Migration

## Scope

Replace helper-derived rendering metadata (labels/images/overlay/views/widgets) with Velocity/native bindings, following D-038 Batch C.

## Inputs and Prerequisite Checks

- [D-038 Legacy Property Ledger](../../reference/d038-legacy-property-ledger.md)
- [Screen-by-Screen Build Contract](../../target/screen-by-screen-build-contract.md)
- [D-003 View Mode Matrix](../../target/d003-view-mode-matrix.md)
- [Inventory 01 Home and Hubs](../../../inventory/01-home-and-hubs.md)
- [Inventory 02 Search and Discovery](../../../inventory/02-search-and-discovery.md)
- [Inventory 04 OSD and Playback Surfaces](../../../inventory/04-osd-and-playback-surfaces.md)

Checks:

- [ ] Phase 04 accepted
- [ ] Batch C decisions locked in D-038

## File-Level Touch List

- `1080i/Includes_Images.xml`
- `1080i/Includes_Labels.xml`
- `1080i/Includes_Info.xml`
- `1080i/Includes_Overlay.xml`
- `1080i/Includes_Views.xml`
- `1080i/Includes_Views_List.xml`
- `1080i/Includes_Views_Row.xml`
- `1080i/Includes_Views_Wall.xml`
- `1080i/Includes_Views_Combined.xml`
- `1080i/Includes_Widgets.xml`
- `1080i/Includes_Lists.xml`
- `1080i/Home.xml`
- `1080i/Includes_Home.xml`
- `1080i/Custom_1171_Dialog_Views.xml`
- `1080i/Custom_1170_Dialog_Options.xml`
- `1080i/Custom_1160_Dialog_Favourites.xml`
- `1080i/Custom_1172_Dialog_InfoOptions.xml`
- `1080i/Custom_1122_Dialog_SelectTrailer.xml`
- `1080i/Custom_1123_Dialog_Trailer.xml` (retain trailer capability, migrate bindings)

## Step-by-Step Execution Tasks

1. Migrate image/artwork variables in `Includes_Images.xml` to Velocity/native fields.
2. Migrate label builders in `Includes_Labels.xml` and remove helper-only branches.
3. Migrate info and overlay panels (`Includes_Info.xml`, `Includes_Overlay.xml`).
4. Migrate view family files (`Includes_Views*`) to non-helper labels and conditions.
5. Migrate widget/list metadata (`Includes_Widgets.xml`, `Includes_Lists.xml`).
6. Migrate home shell metadata references (`Home.xml`, `Includes_Home.xml`).
7. Migrate options/view dialogs (`Custom_1171`, `Custom_1170`, `Custom_1160`, `Custom_1172`).
8. Keep trailer surfaces and rebind to Velocity/native trailer fields (`C10A`).
9. Clean dead helper condition branches introduced by migration.

## Validation Checklist (Runtime + Static)

- [ ] image-only card policy remains intact for rows
- [ ] spotlight metadata renders required fields
- [ ] info overlays and labels display expected values
- [ ] no missing artwork regressions on focused items
- [ ] trailer flows remain available and open valid targets

## Acceptance Criteria (Pass/Fail)

- [ ] all Batch C files migrated
- [ ] no active helper-bound metadata dependency remains in migrated files
- [ ] row/spotlight/details rendering matches blueprint contract

## Abort / Rollback Guidance

- If rendering regressions are broad:
  - rollback current sub-slice only (e.g., labels or images group)
  - keep validated groups intact
  - continue group-by-group

## Common Failure Modes and Detection

- **Failure:** empty labels after migration  
  **Detect:** verify canonical field presence in addon payload and binding names in labels file.
- **Failure:** artwork fallback loops  
  **Detect:** inspect focused item and player state transitions for missing art branch.

## If Blocked, Stop and Report

Report:

1. surface and file
2. missing field key
3. whether missing data is addon schema gap or skin binding error

## Handoff to Phase 06

Proceed only when Batch C acceptance checks pass.  
Next: [Phase 06 - Deferred Exceptions and Final Cleanup](./phase-06-deferred-exceptions-and-final-cleanup.md).

