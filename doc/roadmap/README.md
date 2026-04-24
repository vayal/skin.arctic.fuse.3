# Roadmap — phase implementation workspace

This folder intentionally contains **phase implementation documents** (plus optional helper files like template/map).

**Master roadmap (high level):** [../ROADMAP_MASTER.md](../ROADMAP_MASTER.md)

## Phase documents

| Phase | Document |
|-------|----------|
| 0 | [phase-00-historic-implementation-audit.md](phase-00-historic-implementation-audit.md) |
| 1 | [phase-01-contract-and-ia-baseline.md](phase-01-contract-and-ia-baseline.md) |
| 2 | [phase-02-list-implementation-alignment.md](phase-02-list-implementation-alignment.md) |
| 3 | [phase-03-non-list-surfaces-implementation.md](phase-03-non-list-surfaces-implementation.md) |
| 4 | [phase-04-freeze-and-runtime-verification.md](phase-04-freeze-and-runtime-verification.md) |
| 5 | [phase-05-debt-cleanup-and-policy-closure.md](phase-05-debt-cleanup-and-policy-closure.md) |

## Standard

- Template: [PHASE_TEMPLATE.md](PHASE_TEMPLATE.md)
- Artifact ownership: [PHASE_ARTIFACT_MAP.md](PHASE_ARTIFACT_MAP.md)

## Operating rule

All implementation planning/status content should be added to one of the phase files above, not as standalone roadmap artifacts.

## Consolidation status

- All roadmap target/status material extracted from legacy roadmap artifacts now lives inside phase documents.
- Each phase file is expected to carry end-to-end implementation detail for its scope: target baseline, as-built status, verification checklist, blockers, and handoff.
- `ROADMAP_MASTER.md` is program control only (ordering, dependencies, gates, high-level status).
