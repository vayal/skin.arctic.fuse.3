# Phase 0 — Historic implementation audit

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)  
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Legacy-to-current roadmap mapping and governance lock |
| Out of scope | Feature implementation or XML behavior changes |

## Objective

Create a reliable historical baseline so all later phases execute against one accepted phase model, one ownership map, and one roadmap governance rule set.

## Inputs / references

- [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)
- [README.md](./README.md)
- [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)
- [PHASE_ARTIFACT_MAP.md](./PHASE_ARTIFACT_MAP.md)
- [traceability-by-topic.md](../traceability-by-topic.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)

## Authoritative mapping to lock

| Legacy area | Consolidated owner |
|-------------|--------------------|
| 01 Preflight and contract lock | Phase 1 |
| 02 Addon contracts | Phase 1 + Phase 2 |
| 03 Skin core plumbing | Phase 2 + Phase 3 |
| 04 Removals and policy | Phase 3 + Phase 5 |
| 05 Metadata and rendering | Phase 3 + Phase 4 |
| 06 Deferred exceptions | Phase 5 |
| 07 Stabilization and freeze | Phase 4 |

## Actionable work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P0.1 | Validate legacy-to-consolidated phase mapping | - [ ] | - [ ] | Link accepted mapping notes |
| P0.2 | Cross-check D-item coverage placement (D-003/D-015/D-021/D-038) | - [ ] | - [ ] | List missing/duplicate ownership |
| P0.3 | Confirm artifact ownership map by bundle and phase | - [ ] | - [ ] | Update `PHASE_ARTIFACT_MAP.md` if needed |
| P0.4 | Confirm `doc/roadmap` operating rule is enforced | - [ ] | - [ ] | Note any violating artifacts |
| P0.5 | Ensure each phase file has template-compliant structure | - [ ] | - [ ] | Per-phase checklist completion |
| P0.6 | Update master roadmap status and dependency notes | - [ ] | - [ ] | `ROADMAP_MASTER.md` entry |

## Execution checklist

- [ ] Verify phase files exist for `phase-00` through `phase-05`
- [ ] Verify no standalone roadmap target/status docs are treated as canonical
- [ ] Verify all roadmap detail is phase-owned (not orphaned)
- [ ] Verify phase dependency chain in master roadmap is consistent
- [ ] Verify no D-item appears unowned or multiply owned without rationale

## Verification checklist

- [ ] Mapping table signed off by owner
- [ ] Ownership collisions resolved
- [ ] Each phase has clear in-scope/out-of-scope and handoff
- [ ] `ROADMAP_MASTER.md` reflects Phase 0 outputs

## Blockers / risks

- Legacy naming mismatch may create false completion signals.
- Old references can reintroduce deleted standalone documents as de facto sources.

## Exit criteria

- [ ] P0.1-P0.6 complete and evidence-linked
- [ ] No unresolved mapping ambiguity blocks Phase 1
- [ ] Governance rules are reflected in master roadmap and roadmap README

## Handoff

Set Phase 0 status in [ROADMAP_MASTER.md](../ROADMAP_MASTER.md), then activate [Phase 1](./phase-01-contract-and-ia-baseline.md).
