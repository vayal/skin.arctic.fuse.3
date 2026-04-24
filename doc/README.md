# Velocity skin (`skin.velocity.af3`) — documentation

**Start here.** This tree is split so you can tell **context**, **target**, **what shipped**, **what is next**, and **deep reference** apart.

| Section | Purpose | Start file |
|--------|---------|------------|
| **Context** | What this repo is, how it relates to the addon, where Cursor rules live | [context/README.md](context/README.md) |
| **Target** | Product intent: hubs, widgets, contracts, decisions (canonical “where we’re going”) | [target/README.md](target/README.md) |
| **Status** | Performance notes, investigations, addon list reports, session feedback | [status/README.md](status/README.md) |
| **Next steps** | Phased roadmap, gap analysis, validation reports, triage | [next/README.md](next/README.md) |
| **Reference** | Kodi skin mechanics (numbered series), D-038 ledger, property dictionary, testing guide | [reference/README.md](reference/README.md) |
| **Archive** | Superseded narrative / blueprint versions kept for history only | [archive/README.md](archive/README.md) |

## Quick links (most used)

- **Build contract + implementation matrix:** [target/screen-by-screen-build-contract.md](target/screen-by-screen-build-contract.md)
- **Refined product blueprint (current):** [target/skin-vision-blueprint-v1.md](target/skin-vision-blueprint-v1.md)
- **Addon list / URL contracts (D-015):** [target/d015-addon-required-lists-contract.md](target/d015-addon-required-lists-contract.md)
- **View-mode / hub ID decisions (D-003):** [target/d003-view-mode-matrix.md](target/d003-view-mode-matrix.md)
- **Roadmap package:** [next/roadmap/README.md](next/roadmap/README.md)
- **Gap analysis:** [next/gap-analysis/master-triage-list.md](next/gap-analysis/master-triage-list.md)
- **Legacy property ledger (D-038):** [reference/d038-legacy-property-ledger.md](reference/d038-legacy-property-ledger.md)
- **Kodi skin engine series (01–10):** [reference/00_README.md](reference/00_README.md)

## Repo layout reminder

- **This repo** = Kodi skin XML/assets only (`plugin://plugin.video.velocity2/…` for navigation).
- **Velocity addon** = `plugin.video.velocity2` (Python, daemon, DB) — not maintained in this tree.

## Path migration (2026-04)

Older links used flat paths under `doc/` (e.g. `doc/roadmap/…`, `doc/d015-…`). New layout:

- `doc/roadmap/*` → `doc/next/roadmap/*`
- `doc/gap-analysis/*` → `doc/next/gap-analysis/*`
- Contract / blueprint / build-contract → `doc/target/*`
- D-038, property map, numbered guides → `doc/reference/*`
- `skin-vision-blueprint-v0.md` → `doc/archive/skin-vision-blueprint-v0.md`

If you find a stale link, fix it to the paths above or open an issue.
