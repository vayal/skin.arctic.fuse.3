# Velocity — master roadmap

Single **program-level** document: **vision**, **objectives**, and **phases** only. Per-phase **implementation detail, normative specs, evidence, and checklists** live under **[`roadmap/`](./roadmap/README.md)** (`phase-*.md` plus consolidated contract/status markdown in the same folder).

---

## Vision (high level)

Ship **`skin.velocity.af3`** as a **Velocity-only** Arctic Fuse 3 fork: browsing, hubs, search, details, and playback surfaces resolve through **`plugin://plugin.video.velocity2/?…`**, with **native / Velocity `ListItem` semantics** where possible and a controlled, ledgered path for any remaining legacy helper symbols (**D-038**).

**Product shape** (current intent, not historical narrative):

- **IA:** Home, Series, Movies as primary hubs; curated provider mini-hubs; fixed genre set; search/discovery as first-class — see [skin vision blueprint v1](./roadmap/skin-vision-blueprint-v1.md).
- **Lists:** Frozen contract families, pagination, and hub row expectations — see [LIST_CONTRACTS_TARGET](./roadmap/LIST_CONTRACTS_TARGET.md) (**D-015**) and as-built alignment [LIST_IMPLEMENTATION_STATUS](./roadmap/LIST_IMPLEMENTATION_STATUS.md).
- **Chrome / non-list:** Details, OSD, context policy, removals, search chrome — see [non-list hub](./roadmap/nonlist-surfaces-index.md) and topical targets linked there.
- **View modes / hub IDs:** [D-003 matrix](./roadmap/d003-view-mode-matrix.md).

**Historical note:** [Blueprint v0](./archive/skin-vision-blueprint-v0.md) informed early migration; parts are **outdated** — prefer **v1** + **`roadmap/`** contract/status files for “what we want” and “what shipped.”

---

## Objectives (outcomes)

1. **Truth in the tree** — Implementation matches documented decisions (D-003, D-015, D-021, D-038) unless an exception is explicitly recorded.
2. **Runtime proof** — Mandatory operator journeys and D-015 pagination behavior are **verified in Kodi** with evidence, not grep-only.
3. **Debt bounded** — Residual helper / property usage is either **gone** or **listed in D-038** with an owner and follow-up phase ([phase-02](./roadmap/phase-02-legacy-helper-and-d038-debt.md)).
4. **Product clarity** — Open product forks (e.g. PVR gating) are **decided** and reflected in roadmap docs + skin ([phase-03](./roadmap/phase-03-pvr-gating-product-policy.md)).

---

## Phase plan (this roadmap)

| Phase | Name | Purpose |
|-------|------|---------|
| **0** | [Historic implementation audit](./roadmap/phase-00-historic-implementation-audit.md) | Verify **claims** from legacy phases **01–06** (removed playbooks) against **today’s tree**, **`roadmap/`** inventories and contracts, and decision traceability — no new feature work. |
| **1** | [Freeze & runtime verification](./roadmap/phase-01-freeze-and-runtime-verification.md) | End-to-end Kodi QA, journeys, D-015 runtime checks, freeze gates — successor to legacy “Phase 07”. |
| **2** | [Legacy helper & D-038 debt](./roadmap/phase-02-legacy-helper-and-d038-debt.md) | Close or re-scope remaining helper symbols and triage follow-ups from repo audit. |
| **3** | [PVR gating & product policy](./roadmap/phase-03-pvr-gating-product-policy.md) | Decide Live TV / 1107 behavior and align skin + docs. |

**Topic cross-index** (optional navigation): [traceability-by-topic.md](./traceability-by-topic.md).

**Context & engine depth:** [context/README.md](./context/README.md) · [kodi/00_README.md](./kodi/00_README.md).

---

## Program status

Update **only** the row for the active phase; detail belongs in that phase’s document.

| Phase | Status (one line) |
|-------|-------------------|
| 0 | Not started — run audit checklist in [phase-00](./roadmap/phase-00-historic-implementation-audit.md) |
| 1 | Blocked on Kodi runtime evidence — see [phase-01](./roadmap/phase-01-freeze-and-runtime-verification.md) |
| 2 | Open — backlog from [phase-02](./roadmap/phase-02-legacy-helper-and-d038-debt.md) |
| 3 | Open — decision required per [phase-03](./roadmap/phase-03-pvr-gating-product-policy.md) |

---

## Definition of program done

- [ ] Phase **0** audit complete (historic accuracy signed off in [phase-00](./roadmap/phase-00-historic-implementation-audit.md))
- [ ] Phase **1** freeze criteria met with linked evidence in [phase-01](./roadmap/phase-01-freeze-and-runtime-verification.md)
- [ ] Phase **2** items closed or explicitly deferred with D-038 + **`roadmap/`** doc updates
- [ ] Phase **3** product decision recorded and skin reflects it

---

*Last restructured: 2026-04-24 — `doc/target/` and `doc/status/` merged into **`doc/roadmap/`**; master roadmap at **`doc/ROADMAP_MASTER.md`**; `doc/next/` removed.*
