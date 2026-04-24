# Appendix - Agent Guardrails

This appendix defines mandatory execution guardrails for less capable agents.

## 1) Execution Boundaries

- Follow [roadmap README](./README.md) phase order strictly.
- Work only on the active phase unless explicitly instructed.
- Do not reopen frozen design decisions from:
  - [Skin Vision Blueprint](../../archive/skin-vision-blueprint-v0.md)
  - [D-003](../../target/d003-view-mode-matrix.md)
  - [D-015 / list target](../../target/LIST_CONTRACTS_TARGET.md)
  - [D-038](../../context/d038-legacy-properties-and-mapping.md)

## 2) Forbidden Actions

- Do not invent new route naming families.
- Do not introduce fallback behavior where docs say no fallback.
- Do not remove files outside approved batch scope.
- Do not proceed after blocker without stop/report.
- Do not overwrite canonical docs with summary-only replacements.

## 3) Required Behavior

- Perform work in small, verifiable slices.
- Validate after each slice.
- Keep traceability updated for each decision-linked change.
- Preserve temporary exceptions only when explicitly documented.

## 4) Stop Conditions (Mandatory)

Stop immediately and report if:

- a required contract field is missing from addon outputs
- a core path/action mapping cannot be resolved without changing frozen decisions
- a removal candidate is still transitively required by active UX
- runtime behavior conflicts with accepted D-item policy

## 5) Minimal Blocker Report Format

Use this exact structure:

1. **Scope:** active phase and task
2. **Blocker:** precise failure
3. **Evidence:** file/symbol/runtime symptom
4. **Needed decision:** smallest decision to unblock
5. **Safe fallback:** temporary workaround (if any)

## 6) Batch Discipline

- Batch A: remove-first approved surfaces only.
- Batch B: control-plane replace before cosmetic changes.
- Batch C: rendering/metadata migration after core plumbing.
- Batch D: only documented deferred exceptions and cleanup.

## 7) Completion Discipline

A phase is complete only when:

- phase acceptance checklist passes
- no unresolved blockers remain
- handoff preconditions are satisfied

