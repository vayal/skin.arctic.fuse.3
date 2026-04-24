# Context — Velocity skin fork (definitions & rules)

**Single home** for **theory, process rules, fork guides, inventories, and journeys** for `skin.velocity.af3` + Velocity. **Normative specs, inventories, and as-built checklists** live under [`../roadmap/`](../roadmap/README.md) (see [ROADMAP_MASTER](../ROADMAP_MASTER.md)). **Generic Kodi engine:** [`../kodi/`](../kodi/README.md).

---

## A) Cross-cutting context (always relevant)

| Area | Document |
|------|----------|
| **Topic spine (roadmap ↔ context ↔ QA)** | **[`../traceability-by-topic.md`](../traceability-by-topic.md)** |
| List addon **theory** (not D-015 text) | [LIST_ADDON_THEORY.md](./LIST_ADDON_THEORY.md) |
| List **contract** / **as-built** | [LIST_CONTRACTS_TARGET](../roadmap/LIST_CONTRACTS_TARGET.md) · [LIST_IMPLEMENTATION_STATUS](../roadmap/LIST_IMPLEMENTATION_STATUS.md) |
| Legacy properties (**D-038**) — ledger + mapping | [d038-legacy-properties-and-mapping.md](./d038-legacy-properties-and-mapping.md) |
| Surface inventory **hub**, schema, glossary | [surface-inventory-index.md](./surface-inventory-index.md) · [velocity-surface-inventory-schema.md](./velocity-surface-inventory-schema.md) · [velocity-contract-glossary.md](./velocity-contract-glossary.md) · [velocity-surface-source-index.md](./velocity-surface-source-index.md) |
| **Journeys** (operator flows) | [journeys/README.md](./journeys/README.md) |
| Non-list **generator** workflow & file map | [nonlist-generator-workflow.md](./nonlist-generator-workflow.md) · [nonlist-skin-file-index.md](./nonlist-skin-file-index.md) |
| Non-list **targets** hub | [../roadmap/nonlist-surfaces-index.md](../roadmap/nonlist-surfaces-index.md) |
| Fork narrative, agents, **operator QA** | [ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md](./ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md) · [af3-agent-rules.md](./af3-agent-rules.md) · [kodi-complete-testing-guide.md](./kodi-complete-testing-guide.md) |

**Addon API tables (upstream):** addon repo `plans/velocity-addon-reference-for-skin-forks.md`; optional copy `docs/VELOCITY_ADDON_REFERENCE.md`. Do not duplicate long API tables here — link.

---

## B) Topic playbooks (by ID)

Use **[`../traceability-by-topic.md`](../traceability-by-topic.md)** for the full matrix. Quick map: **theory / rules** for each topic most often live in these context files (plus **`roadmap/`** for normative policy).

| Topic ID | Start here (context) |
|----------|----------------------|
| `lists` | [LIST_ADDON_THEORY](./LIST_ADDON_THEORY.md), [D-038](./d038-legacy-properties-and-mapping.md) |
| `widgets-rails` | [LIST_ADDON_THEORY](./LIST_ADDON_THEORY.md) (rails, paging), [surface-inventory-index](./surface-inventory-index.md) |
| `hubs-viewmodes` | [D-038](./d038-legacy-properties-and-mapping.md), [journeys](./journeys/README.md) |
| `search-discovery` | [nonlist-generator-workflow](./nonlist-generator-workflow.md), [D-038](./d038-legacy-properties-and-mapping.md) |
| `details-context` | [D-038](./d038-legacy-properties-and-mapping.md); policy target in [nonlist-details-osd-context-target](../roadmap/nonlist-details-osd-context-target.md) |
| `osd-playback` | [D-038](./d038-legacy-properties-and-mapping.md) |
| `actions-paths` | [D-038](./d038-legacy-properties-and-mapping.md) (Batch B), [ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION](./ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md) |
| `generator-shortcuts` | [nonlist-generator-workflow](./nonlist-generator-workflow.md), [nonlist-skin-file-index](./nonlist-skin-file-index.md) |
| `settings-customization` | [D-038](./d038-legacy-properties-and-mapping.md) |
| `removals-policy` | [D-038](./d038-legacy-properties-and-mapping.md) Batch A |
| `performance-observability` | [kodi/09_BEST_PRACTICES.md](../kodi/09_BEST_PRACTICES.md) (generic); add measurements as new markdown under [`../roadmap/`](../roadmap/README.md) when captured |

---

## What this repository is

- A **Kodi skin** (Arctic Fuse 3–derived) customized for **Velocity only** via `plugin://plugin.video.velocity2/?…`.
- **Not** the Velocity video addon: no Python addon code, daemon, or SQLite schema belongs here.

## Conventions

- Prefer **one place** to change Velocity paths (wrapper includes), not scattered `plugin://` strings.
- Do not rely on TMDbHelper for **core** Velocity flows unless a compatibility shim is explicitly in scope.

## See also

- [Roadmap / specs hub](../roadmap/README.md)  
- [Roadmap & execution](../ROADMAP_MASTER.md)  
- [Kodi skin engine (generic)](../kodi/README.md)
