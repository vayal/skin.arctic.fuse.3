# Phase 06 - Deferred Exceptions and Final Cleanup

## Scope

Apply Batch D decisions, close non-critical leftovers, and ensure only explicitly approved temporary exceptions remain.

## Inputs and Prerequisite Checks

- [D-038 Legacy Property Ledger](../../reference/d038-legacy-property-ledger.md)
- [Screen-by-Screen Build Contract](../../target/screen-by-screen-build-contract.md)
- [Agent Guardrails Appendix](./appendix-agent-guardrails.md)

Checks:

- [ ] Phase 05 accepted
- [ ] Batch D decisions locked in D-038

## File-Level Touch List

- `1080i/Custom_1105_Search.xml` (temporary key retained)
- `1080i/MyWeather.xml` (remove)
- `1080i/Custom_1161_Dialog_Weather.xml` (remove)
- `1080i/Custom_1180_Dialog_Bumper.xml` (keep-temporary unless touched)

## Step-by-Step Execution Tasks

1. Remove weather surfaces per locked Batch D decisions:
   - `MyWeather.xml`
   - `Custom_1161_Dialog_Weather.xml`
2. Keep helper-named search key temporarily in `Custom_1105_Search.xml`:
   - verify target routing remains Velocity-based
   - do not rename in this phase
3. Keep bumper surface temporary as documented:
   - no behavioral expansion
   - no new helper dependencies added
4. Execute global residual sweep in active surfaces:
   - helper property references
   - helper addon-id references
   - helper expression references
5. Update ledger status for all completed files and exceptions.

## Validation Checklist (Runtime + Static)

- [ ] weather routes/surfaces are not reachable
- [ ] search still operates with combined mode after weather removal
- [ ] only documented keep-temporary exceptions remain
- [ ] no undeclared helper references in active UX surfaces

## Acceptance Criteria (Pass/Fail)

- [ ] Batch D decisions implemented exactly
- [ ] residual helper references are either removed/replaced or explicitly allowed
- [ ] D-038 ledger reflects final post-cleanup state

## Abort / Rollback Guidance

- If cleanup removes required behavior:
  - restore minimal required file/symbol
  - classify as temporary exception in ledger
  - do not hide undeclared exceptions

## Common Failure Modes and Detection

- **Failure:** removing weather breaks unrelated include chain  
  **Detect:** inspect include load errors and missing include references.
- **Failure:** accidental rename of temporary search key  
  **Detect:** verify search startup property key behavior in runtime.

## If Blocked, Stop and Report

Report:

1. attempted cleanup item
2. dependency that prevented completion
3. proposed exception with expiration condition

## Handoff to Phase 07

Proceed when cleanup and exception inventory are finalized.  
Next: [Phase 07 - Stabilization and Freeze](./phase-07-stabilization-and-freeze.md).

