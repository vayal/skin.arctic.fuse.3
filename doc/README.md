# Velocity skin (`skin.velocity.af3`) — documentation

**Start here.** This tree is split so you can tell **context** (definitions & fork rules), **target**, **status**, **what is next**, **Kodi engine mechanics**, **Velocity redirect**, and **archive** apart.

| Section | Purpose | Start file |
|--------|---------|------------|
| **Context** | List theory, D-038, surface inventory hub, journeys, generator rules, fork docs, QA guide | [context/README.md](context/README.md) |
| **Target** | Product intent, **D-015 list target**, D-003, **non-list** targets ([hub](target/nonlist-surfaces-index.md)) | [target/README.md](target/README.md) |
| **Status** | **List** as-built status, **non-list** checklists, **surface inventories** (01–07), performance notes | [status/README.md](status/README.md) |
| **Next steps** | Phased roadmap, gap analysis, triage | [next/README.md](next/README.md) |
| **Kodi engine** | Generic Kodi skin XML/engine guides (numbered 01–10) | [kodi/README.md](kodi/README.md) |
| **Velocity** | Redirect only (historical `doc/velocity/` links) | [velocity/README.md](velocity/README.md) |
| **Archive** | Superseded narrative / blueprint versions kept for history only | [archive/README.md](archive/README.md) |

## Quick links (most used)

- **Context hub:** [context/README.md](context/README.md) → list theory, D-038, surface inventory, journeys, testing guide  
- **List addon theory:** [context/LIST_ADDON_THEORY.md](context/LIST_ADDON_THEORY.md)  
- **List contract target (D-015):** [target/LIST_CONTRACTS_TARGET.md](target/LIST_CONTRACTS_TARGET.md)  
- **List implementation status:** [status/LIST_IMPLEMENTATION_STATUS.md](status/LIST_IMPLEMENTATION_STATUS.md)  
- **Non-list surfaces (hub):** [target/nonlist-surfaces-index.md](target/nonlist-surfaces-index.md)  
- **Refined product blueprint (current):** [target/skin-vision-blueprint-v1.md](target/skin-vision-blueprint-v1.md)  
- **View-mode / hub ID decisions (D-003):** [target/d003-view-mode-matrix.md](target/d003-view-mode-matrix.md)  
- **Roadmap package:** [next/roadmap/README.md](next/roadmap/README.md)  
- **Gap analysis:** [next/gap-analysis/master-triage-list.md](next/gap-analysis/master-triage-list.md)  
- **Surface inventory & journeys:** [context/surface-inventory-index.md](context/surface-inventory-index.md) · [context/journeys/](context/journeys/README.md)  
- **D-038 (ledger + mapping):** [context/d038-legacy-properties-and-mapping.md](context/d038-legacy-properties-and-mapping.md)  
- **Kodi skin engine series (01–10):** [kodi/00_README.md](kodi/00_README.md)  

## Repo layout reminder

- **This repo** = Kodi skin XML/assets only (`plugin://plugin.video.velocity2/…` for navigation).
- **Velocity addon** = `plugin.video.velocity2` (Python, daemon, DB) — not maintained in this tree.

## Path migration (2026-04)

Older links used flat paths under `doc/` (e.g. `doc/roadmap/…`, `doc/d015-…`). New layout:

- `doc/roadmap/*` → `doc/next/roadmap/*`
- `doc/gap-analysis/*` → `doc/next/gap-analysis/*`
- **Fork definitions & rules** (former `doc/contracts/` + former `doc/velocity/` authoring docs) → **`doc/context/`** (list theory, nonlist guidelines, surface inventory hub, journeys, D-038, AF3 fork doc, testing guide)
- Contract / blueprint / non-list **targets** → `doc/target/*`; non-list **status checklists** → `doc/status/nonlist-*-status.md`
- **List target (D-015)** → `doc/target/LIST_CONTRACTS_TARGET.md` · **List status** → `doc/status/LIST_IMPLEMENTATION_STATUS.md`
- **Kodi-generic guides** → `doc/kodi/*` (was mixed under `doc/reference/`)
- **Surface inventories `01`–`07`:** `doc/status/surface-inventory-*.md` · **hub:** `doc/context/surface-inventory-index.md` · **journeys:** `doc/context/journeys/`
- `doc/velocity/*` (except redirect README) → **`doc/context/`** (same basenames where applicable)
- `skin-vision-blueprint-v0.md` → `doc/archive/skin-vision-blueprint-v0.md`

If you find a stale link, fix it to the paths above or open an issue.
