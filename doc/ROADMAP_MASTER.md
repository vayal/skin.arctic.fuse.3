# Velocity — master roadmap

This is the canonical program roadmap for `skin.velocity.af3`: vision, sequencing, phase ownership, and closure criteria.

Detailed implementation content is maintained in phase documents under [`doc/roadmap/`](./roadmap/README.md).

---

## Vision

Deliver `skin.velocity.af3` as a coherent Velocity-only experience with:

- stable navigation/hub behavior,
- explicit list and non-list implementation baselines,
- runtime-verified UX in Kodi,
- bounded residual legacy/helper debt and resolved product policy edges.

---

## Program objectives

1. Establish a frozen implementation baseline (IA, D-003, D-015, governance).
2. Align shipped list and non-list behavior to that baseline with explicit discrepancy handling.
3. Validate behavior in Kodi runtime and close freeze gates with evidence.
4. Close residual helper/property debt and deferred policy decisions with explicit acceptance.

---

## Phase sequence

| Phase | Name | Primary outcome | Depends on |
|-------|------|------------------|------------|
| 0 | [Historic implementation audit](./roadmap/phase-00-historic-implementation-audit.md) | Legacy-to-consolidated mapping and roadmap governance baseline accepted. | — |
| 1 | [Contract and IA baseline](./roadmap/phase-01-contract-and-ia-baseline.md) | IA, D-003, D-015, and baseline matrix frozen for execution phases. | 0 |
| 2 | [List implementation alignment](./roadmap/phase-02-list-implementation-alignment.md) | As-built list behavior reconciled against D-015 with documented deviations. | 1 |
| 3 | [Non-list surfaces implementation](./roadmap/phase-03-non-list-surfaces-implementation.md) | Non-list target/status/inventory decisions implemented and reconciled. | 1, 2 |
| 4 | [Freeze and runtime verification](./roadmap/phase-04-freeze-and-runtime-verification.md) | Runtime evidence captured and freeze gate decision recorded. | 0, 1, 2, 3 |
| 5 | [Debt cleanup and policy closure](./roadmap/phase-05-debt-cleanup-and-policy-closure.md) | Residual debt and deferred policy (including PVR) finalized and documented. | 2, 3, 4 |

**Phase standard:** [roadmap/PHASE_TEMPLATE.md](./roadmap/PHASE_TEMPLATE.md)  
**Artifact ownership:** [roadmap/PHASE_ARTIFACT_MAP.md](./roadmap/PHASE_ARTIFACT_MAP.md)

---

## Program status (current)

| Phase | Status | Control note |
|-------|--------|--------------|
| 0 | planned | Actionable audit checklist is defined; mapping/governance sign-off pending. |
| 1 | planned | Baseline lock checklist is defined; IA/D-003/D-015 acceptance pending. |
| 2 | planned | List alignment execution plan is defined; route/paging/rendering closure pending. |
| 3 | planned | Non-list execution plan is defined; surface keep/remove/defer decisions pending. |
| 4 | blocked (runtime evidence pending) | Freeze cannot close without Kodi runtime capture. |
| 5 | planned | Debt and policy closure plan is defined; depends on freeze output and approvals. |

---

## Cross-phase control gates

- Phase 1 closes only when D-003 and D-015 are mutually consistent and baseline-locked.
- Phase 2 and Phase 3 must classify every discrepancy as resolved, deferred, or accepted.
- Phase 3 cannot close with undecided high-impact inventory items.
- Phase 4 is the only freeze-approval authority (runtime evidence gate).
- Phase 5 closes only when remaining D-038 and policy exceptions are resolved or explicitly accepted.

---

## Definition of done

- [ ] Phases 0–5 are complete (Implemented and Verified per phase docs)
- [ ] No unresolved phase blockers remain without owner and follow-up
- [ ] Runtime evidence exists for mandatory journeys and list paging behavior
- [ ] Residual helper/policy exceptions are either closed or explicitly accepted

---

## Governance notes

- `doc/roadmap/` is phase-owned: implementation details, checklists, evidence notes, and handoff status belong in phase files.
- `PHASE_TEMPLATE.md` defines required section structure; `PHASE_ARTIFACT_MAP.md` defines ownership of consolidated information bundles.
- Any new roadmap detail must be added to the owning phase document and reflected in program status.

---

*Structure note: `doc/roadmap/` now contains phase implementation docs; former standalone target/status roadmap artifacts were consolidated into those phases.*
