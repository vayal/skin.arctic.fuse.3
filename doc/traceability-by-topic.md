# Traceability by topic (spine)

This file is the **topic-first index**: for each technical scope you can jump to **normative specs** and **as-built evidence** (both under [`roadmap/`](./roadmap/README.md)), **context** (theory, skin rules, pitfalls), and **verification** (how we prove it). **Execution phases** live in [`ROADMAP_MASTER.md`](./ROADMAP_MASTER.md) and [`roadmap/phase-*.md`](./roadmap/README.md); topics are stable.

**Layer roles (one sentence each):** **Roadmap specs** = shall / must and inventories in `roadmap/`. **Context** = addon/skin theory and guardrails (not duplicate acceptance criteria). **Program roadmap** = vision, sequencing, gates — [ROADMAP_MASTER](./ROADMAP_MASTER.md).

**Decision IDs** (cross-cutting): **D-003** view modes · **D-015** list contracts · **D-021** context menu · **D-038** legacy properties — historic decision ↔ file mapping: [phase-00 audit map](./roadmap/phase-00-historic-implementation-audit.md).

---

## Topic registry (stable IDs)

Use these IDs in checklists, triage rows, and commit messages so links survive file moves.

| ID | Topic | Scope (short) |
|----|--------|----------------|
| `lists` | List feeds & contracts | `contract_id`, hub rows, pagination, addon list semantics (**D-015**) |
| `widgets-rails` | Widgets & rails | Row/spotlight presentation, in-row caps, image-only cards, non-paginated heroes |
| `hubs-viewmodes` | Hubs & view modes | Hub/window IDs, view-mode locking, home/hub chrome (**D-003**) |
| `search-discovery` | Search & discovery | Search UI, discover chrome, Velocity paths |
| `details-context` | Details & context | Info dialogs, plot/cast, context menu policy (**D-021**) |
| `osd-playback` | OSD & playback | Fullscreen OSD, pause strip, cast/progress surfaces |
| `actions-paths` | Actions & paths | `Includes_Actions`, `Includes_Paths`, navigation wrappers, `plugin://` usage |
| `generator-shortcuts` | Generator & shortcuts | `script.skinvariables`, `skinvariables-startup.json`, shortcut editor |
| `settings-customization` | Settings & skin prefs | Skin settings XML, customization dialogs |
| `removals-policy` | Removals & policy | Approved removals, PVR/legacy scope, unreachable deprecated surfaces |
| `performance-observability` | Performance & logs | Load/spotlight behavior, log investigations, operator feedback |

---

## Master matrix

| Topic ID | Normative / contract | As-built / evidence | Context (theory / rules) | Verification |
|----------|----------------------|---------------------|--------------------------|--------------|
| `lists` | [LIST_CONTRACTS_TARGET](./roadmap/LIST_CONTRACTS_TARGET.md), [blueprint v1](./roadmap/skin-vision-blueprint-v1.md) (list matrix) | [LIST_IMPLEMENTATION_STATUS](./roadmap/LIST_IMPLEMENTATION_STATUS.md) | [LIST_ADDON_THEORY](./context/LIST_ADDON_THEORY.md), [D-038](./context/d038-legacy-properties-and-mapping.md) (list-related batches) | [Phase 1 — P1](./roadmap/phase-01-freeze-and-runtime-verification.md#p1-blockers-close-before-marking-phase-1-completed) D-015; [Appendix B](./roadmap/phase-01-freeze-and-runtime-verification.md#appendix-b--kodi-ui-verification-matrix-code-backed-qa); [browse-to-play](./context/journeys/browse-to-play.md) |
| `widgets-rails` | [blueprint v1](./roadmap/skin-vision-blueprint-v1.md), [LIST_CONTRACTS_TARGET](./roadmap/LIST_CONTRACTS_TARGET.md) (pagination / row rules) | [surface-inventory-home-hubs](./roadmap/surface-inventory-home-hubs.md), [LIST_IMPLEMENTATION_STATUS](./roadmap/LIST_IMPLEMENTATION_STATUS.md) | [LIST_ADDON_THEORY](./context/LIST_ADDON_THEORY.md) (rails, `next_page`), [surface inventory hub](./context/surface-inventory-index.md) | [browse-to-play](./context/journeys/browse-to-play.md); [Phase 1 Appendix B §B.4](./roadmap/phase-01-freeze-and-runtime-verification.md#appendix-b--kodi-ui-verification-matrix-code-backed-qa) |
| `hubs-viewmodes` | [d003-view-mode-matrix](./roadmap/d003-view-mode-matrix.md), [blueprint v1](./roadmap/skin-vision-blueprint-v1.md) | [surface-inventory-home-hubs](./roadmap/surface-inventory-home-hubs.md) | [D-038](./context/d038-legacy-properties-and-mapping.md), [journeys](./context/journeys/README.md) | [Appendix B](./roadmap/phase-01-freeze-and-runtime-verification.md#appendix-b--kodi-ui-verification-matrix-code-backed-qa); browse journey |
| `search-discovery` | [nonlist-search-chrome-target](./roadmap/nonlist-search-chrome-target.md), [nonlist hub](./roadmap/nonlist-surfaces-index.md) | [surface-inventory-search-discovery](./roadmap/surface-inventory-search-discovery.md) | [nonlist generator](./context/nonlist-generator-workflow.md), [D-038](./context/d038-legacy-properties-and-mapping.md) § search/discover | [search-to-play](./context/journeys/search-to-play.md); Appendix B §B.5 (search tab gaps) |
| `details-context` | [nonlist-details-osd-context-target](./roadmap/nonlist-details-osd-context-target.md) (details + **D-021** policy), [nonlist hub](./roadmap/nonlist-surfaces-index.md) | [surface-inventory-dialogs-info-context](./roadmap/surface-inventory-dialogs-info-context.md), [nonlist-details-context-status](./roadmap/nonlist-details-context-status.md) | [D-038](./context/d038-legacy-properties-and-mapping.md) | [info-and-related](./context/journeys/info-and-related.md); Appendix A §A.4–A.5 |
| `osd-playback` | [nonlist-details-osd-context-target](./roadmap/nonlist-details-osd-context-target.md) (OSD), [blueprint v1](./roadmap/skin-vision-blueprint-v1.md) | [surface-inventory-osd-playback](./roadmap/surface-inventory-osd-playback.md), [nonlist-osd-playback-status](./roadmap/nonlist-osd-playback-status.md) | [D-038](./context/d038-legacy-properties-and-mapping.md) | [browse-to-play](./context/journeys/browse-to-play.md); Appendix A §A.4 |
| `actions-paths` | [blueprint v1](./roadmap/skin-vision-blueprint-v1.md), [nonlist hub](./roadmap/nonlist-surfaces-index.md) | [surface-inventory-actions-paths-background](./roadmap/surface-inventory-actions-paths-background.md) | [D-038](./context/d038-legacy-properties-and-mapping.md) Batch B, [ARCTIC fork doc](./context/ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md) (paths) | [Appendix A](./roadmap/phase-01-freeze-and-runtime-verification.md#appendix-a--verification-checklists-operator) §A.7; Appendix B §B.2 |
| `generator-shortcuts` | [nonlist hub](./roadmap/nonlist-surfaces-index.md) | [surface-inventory-shortcuts-generator](./roadmap/surface-inventory-shortcuts-generator.md), [nonlist-submenu-shortcut-editor-status](./roadmap/nonlist-submenu-shortcut-editor-status.md) | [nonlist-generator-workflow](./context/nonlist-generator-workflow.md), [nonlist-skin-file-index](./context/nonlist-skin-file-index.md) | [kodi-complete-testing-guide](./context/kodi-complete-testing-guide.md) generator slices; Appendix B §B.7 |
| `settings-customization` | [blueprint v1](./roadmap/skin-vision-blueprint-v1.md), [nonlist hub](./roadmap/nonlist-surfaces-index.md) | [surface-inventory-settings-customization](./roadmap/surface-inventory-settings-customization.md) | [D-038](./context/d038-legacy-properties-and-mapping.md) (settings-touching batches) | Appendix B §B.2 (skin settings control); manual spot-check |
| `removals-policy` | [nonlist-removals-scope-target](./roadmap/nonlist-removals-scope-target.md) | [nonlist-pvr-removal-status](./roadmap/nonlist-pvr-removal-status.md), inventories (dialogs/settings) | [D-038](./context/d038-legacy-properties-and-mapping.md) Batch A | [Appendix A](./roadmap/phase-01-freeze-and-runtime-verification.md#appendix-a--verification-checklists-operator) §A.5; ensure removed routes unreachable |
| `performance-observability` | [blueprint v1](./roadmap/skin-vision-blueprint-v1.md) (performance intent) | *Optional:* add analysis markdown under `roadmap/` when you capture measurements | [kodi engine](./kodi/09_BEST_PRACTICES.md) (generic patterns) | [Phase 1](./roadmap/phase-01-freeze-and-runtime-verification.md) + `kodi.log` notes linked from this matrix when files exist |

---

## Roadmap phase touchpoints (summary)

High-level mapping only; legacy phase ↔ file detail stays in [phase-00](./roadmap/phase-00-historic-implementation-audit.md).

| Phase era | Primary topics touched |
|-----------|-------------------------|
| 01–02 | `lists`, `actions-paths`, `search-discovery` |
| 03 | `lists`, `hubs-viewmodes`, `widgets-rails`, `actions-paths`, `osd-playback`, `generator-shortcuts` |
| 04–06 | `removals-policy`, `details-context`, `osd-playback`, `actions-paths`, `search-discovery`, `settings-customization` |
| Program Phase 1 | **All topics** — runtime freeze verification + [kodi-complete-testing-guide](./context/kodi-complete-testing-guide.md) ([phase-01](./roadmap/phase-01-freeze-and-runtime-verification.md)) |

---

## Orthogonal docs (not in the matrix rows)

- **Kodi skin engine (generic):** [`kodi/README.md`](./kodi/README.md) — prerequisite literacy, not Velocity product truth.
- **Helper debt backlog:** [`roadmap/phase-02-legacy-helper-and-d038-debt.md`](./roadmap/phase-02-legacy-helper-and-d038-debt.md).
- **Archive:** [`archive/README.md`](./archive/README.md) — superseded narratives (e.g. blueprint v0).

---

*Introduced 2026-04-24. Normative + as-built files live under **`doc/roadmap/`**; update this matrix when you add a new topic slice.*
