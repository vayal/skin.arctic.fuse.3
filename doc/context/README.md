# Context — Velocity skin fork (definitions & rules)

**Single home** for topical **definitions, process rules, fork guides, inventories, and journeys** that are specific to `skin.velocity.af3` + Velocity. **Product targets** stay under [`../target/`](../target/README.md); **as-built checklists** under [`../status/`](../status/README.md); **generic Kodi engine** docs under [`../kodi/`](../kodi/README.md).

## What this repository is

- A **Kodi skin** (Arctic Fuse 3–derived) customized for **Velocity only** via `plugin://plugin.video.velocity2/?…`.
- **Not** the Velocity video addon: no Python addon code, daemon, or SQLite schema belongs here.

## Index — start here

### List feeds (theory / where to read target & status)

| Role | Document |
|------|----------|
| Addon list **theory** | [LIST_ADDON_THEORY.md](./LIST_ADDON_THEORY.md) |
| List **target** (D-015) | [../target/LIST_CONTRACTS_TARGET.md](../target/LIST_CONTRACTS_TARGET.md) |
| List **as-built status** | [../status/LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) |

### Non-list surfaces (guidelines + link to targets)

- [nonlist-generator-workflow.md](./nonlist-generator-workflow.md) — SkinVariables regen workflow  
- [nonlist-skin-file-index.md](./nonlist-skin-file-index.md) — concern → XML/JSON map  
- **Targets & non-list checklists (hub):** [../target/nonlist-surfaces-index.md](../target/nonlist-surfaces-index.md)

### Surface hierarchy inventory & journeys

- [surface-inventory-index.md](./surface-inventory-index.md) — hub linking `doc/status/surface-inventory-*.md` + shared schema/glossary  
- [journeys/README.md](./journeys/README.md) — end-to-end flows (`browse-to-play`, `search-to-play`, …)  
- Schemas: [velocity-surface-inventory-schema.md](./velocity-surface-inventory-schema.md), [velocity-contract-glossary.md](./velocity-contract-glossary.md), [velocity-surface-source-index.md](./velocity-surface-source-index.md)

### Legacy properties (D-038)

- [d038-legacy-properties-and-mapping.md](./d038-legacy-properties-and-mapping.md) — ledger + TMDbHelper → native/Velocity mapping table

### Fork narrative, agents, and operator QA

- [ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md](./ARCTIC_FUSE_3_VELOCITY_FORK_DOCUMENTATION.md) — deep fork write-up  
- [af3-agent-rules.md](./af3-agent-rules.md) — agent guardrails for this repo  
- [kodi-complete-testing-guide.md](./kodi-complete-testing-guide.md) — manual QA in Kodi (Phase 07, journeys)

### Other pointers

| Topic | Location |
|--------|-----------|
| Skin navigation & Velocity URL wrappers | `1080i/Includes_*.xml`, `1080i/Home.xml`, hub windows |
| Addon `list_id` / HTTP reference (upstream) | Addon repo `plans/velocity-addon-reference-for-skin-forks.md`; optional copy `docs/VELOCITY_ADDON_REFERENCE.md` |
| Cursor agent rules | `.cursor/rules/*.mdc` |
| Product + roadmap tree | [../README.md](../README.md) |

## Conventions

- Prefer **one place** to change Velocity paths (wrapper includes), not scattered `plugin://` strings.
- Do not rely on TMDbHelper for **core** Velocity flows unless a compatibility shim is explicitly in scope.

## See also

- [Target / product specs](../target/README.md)  
- [Kodi skin engine (generic)](../kodi/README.md)  
- [Roadmap & triage](../next/README.md)
