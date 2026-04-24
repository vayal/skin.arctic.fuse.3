# Velocity skin (`skin.velocity.af3`) — documentation

**Start here.** Program execution is driven by **[ROADMAP_MASTER.md](ROADMAP_MASTER.md)** and everything under **[`roadmap/`](roadmap/README.md)** (phase plans, D-015/D-003/non-list specs, surface inventories, status checklists).

## Canonical execution

| Entry | Role |
|------|------|
| **[ROADMAP_MASTER.md](ROADMAP_MASTER.md)** | Vision, objectives, phase index (high level) |
| **[roadmap/README.md](roadmap/README.md)** | Index of phase plans + consolidated specs |

## Supporting references

| Area | Role | Entry |
|------|------|--------|
| **Topic spine** | Topic IDs → roadmap + context | **[traceability-by-topic.md](traceability-by-topic.md)** |
| **Context** | Theory, rules, journeys, D-038 | [context/README.md](context/README.md) |
| **Kodi engine** | Generic skin XML literacy | [kodi/README.md](kodi/README.md) |
| **Velocity** | Redirect (historical paths) | [velocity/README.md](velocity/README.md) |
| **Archive** | Superseded narratives | [archive/README.md](archive/README.md) |

## Quick links

- **Master roadmap:** [ROADMAP_MASTER.md](ROADMAP_MASTER.md)  
- **Phase 4 (freeze Phase 1 (freeze & QA) QA):** [roadmap/phase-04-freeze-and-runtime-verification.md](roadmap/phase-04-freeze-and-runtime-verification.md)  
- **Historic audit (phase 0):** [roadmap/phase-00-historic-implementation-audit.md](roadmap/phase-00-historic-implementation-audit.md)  
- **Topic matrix:** [traceability-by-topic.md](traceability-by-topic.md)  
- **List triple:** [context/LIST_ADDON_THEORY.md](context/LIST_ADDON_THEORY.md) · [roadmap/phase-01-contract-and-ia-baseline.md](roadmap/phase-01-contract-and-ia-baseline.md) · [roadmap/phase-02-list-implementation-alignment.md](roadmap/phase-02-list-implementation-alignment.md)  
- **Non-list hub:** [roadmap/phase-03-non-list-surfaces-implementation.md](roadmap/phase-03-non-list-surfaces-implementation.md)  
- **D-038:** [context/d038-legacy-properties-and-mapping.md](context/d038-legacy-properties-and-mapping.md)  
- **Kodi skin series (01–10):** [kodi/00_README.md](kodi/00_README.md)  

## Repo layout reminder

- **This repo** = Kodi skin XML/assets only (`plugin://plugin.video.velocity2/…` for navigation).
- **Velocity addon** = `plugin.video.velocity2` (Python, daemon, DB) — not maintained in this tree.

## Path migration (2026-04)

- **`doc/target/`** and **`doc/status/`** removed — files live in **`doc/roadmap/`** alongside phase plans.
- **`doc/next/`** removed — use **`doc/ROADMAP_MASTER.md`** + **`doc/roadmap/`** only.
- Fork definitions & rules → **`doc/context/`**
- **Surface inventory hub:** `doc/context/surface-inventory-index.md` · **journeys:** `doc/context/journeys/`

If you find a stale link, fix it or open an issue.
