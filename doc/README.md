# Velocity skin (`skin.velocity.af3`) — documentation

**Start here.** This tree is split so you can tell **context**, **target**, **contracts (theory)**, **status**, **what is next**, **Kodi engine mechanics**, **Velocity fork mechanics**, and **archive** apart.

| Section | Purpose | Start file |
|--------|---------|------------|
| **Context** | What this repo is, how it relates to the addon, where Cursor rules live | [context/README.md](context/README.md) |
| **Contracts** | Addon **list theory** (`plugin.video.velocity2` internals, rails, HTTP) | [contracts/README.md](contracts/README.md) |
| **Target** | Product intent, **D-015 list target**, D-003, non-list surface contract | [target/README.md](target/README.md) |
| **Status** | **List as-built** status, performance notes, investigations, feedback | [status/README.md](status/README.md) |
| **Next steps** | Phased roadmap, gap analysis, triage | [next/README.md](next/README.md) |
| **Kodi engine** | Generic Kodi skin XML/engine guides (numbered 01–10) | [kodi/README.md](kodi/README.md) |
| **Velocity fork** | D-038, property map, fork docs, Kodi QA guide, **surface/journey inventory** | [velocity/README.md](velocity/README.md) |
| **Archive** | Superseded narrative / blueprint versions kept for history only | [archive/README.md](archive/README.md) |

## Quick links (most used)

- **List addon theory:** [contracts/README.md](contracts/README.md) → [LIST_ADDON_THEORY.md](contracts/LIST_ADDON_THEORY.md)
- **List contract target (D-015):** [target/LIST_CONTRACTS_TARGET.md](target/LIST_CONTRACTS_TARGET.md)
- **List implementation status:** [status/LIST_IMPLEMENTATION_STATUS.md](status/LIST_IMPLEMENTATION_STATUS.md)
- **Non-list surface contract:** [target/screen-by-screen-build-contract.md](target/screen-by-screen-build-contract.md)
- **Refined product blueprint (current):** [target/skin-vision-blueprint-v1.md](target/skin-vision-blueprint-v1.md)
- **View-mode / hub ID decisions (D-003):** [target/d003-view-mode-matrix.md](target/d003-view-mode-matrix.md)
- **Roadmap package:** [next/roadmap/README.md](next/roadmap/README.md)
- **Gap analysis:** [next/gap-analysis/master-triage-list.md](next/gap-analysis/master-triage-list.md)
- **Surfaces & journeys:** [velocity/surfaces/README.md](velocity/surfaces/README.md)
- **Legacy property ledger (D-038):** [velocity/d038-legacy-property-ledger.md](velocity/d038-legacy-property-ledger.md)
- **Kodi skin engine series (01–10):** [kodi/00_README.md](kodi/00_README.md)

## Repo layout reminder

- **This repo** = Kodi skin XML/assets only (`plugin://plugin.video.velocity2/…` for navigation).
- **Velocity addon** = `plugin.video.velocity2` (Python, daemon, DB) — not maintained in this tree.

## Path migration (2026-04)

Older links used flat paths under `doc/` (e.g. `doc/roadmap/…`, `doc/d015-…`). New layout:

- `doc/roadmap/*` → `doc/next/roadmap/*`
- `doc/gap-analysis/*` → `doc/next/gap-analysis/*`
- Contract / blueprint / non-list build-contract → `doc/target/*`
- **List theory** → `doc/contracts/` · **List target (D-015)** → `doc/target/LIST_CONTRACTS_TARGET.md` · **List status** → `doc/status/LIST_IMPLEMENTATION_STATUS.md`
- **Kodi-generic guides** → `doc/kodi/*` (was mixed under `doc/reference/`)
- **Velocity fork docs + surface inventory** → `doc/velocity/*` (ledger, testing guide, `surfaces/` was `doc/inventory/`)
- D-038, property map, fork write-ups → `doc/velocity/*`
- `skin-vision-blueprint-v0.md` → `doc/archive/skin-vision-blueprint-v0.md`

If you find a stale link, fix it to the paths above or open an issue.
