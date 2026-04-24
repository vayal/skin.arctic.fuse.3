# Surface inventory index

Canonical hub for the **surface hierarchy inventories** (per-topic item lists with `Decision:` / `Status:` fields), shared **glossary**, **item schema**, and **source file traceability**. Inventory markdown files live under **`doc/roadmap/`**; **journeys** live under `doc/context/journeys/`.

**Journeys** (end-to-end flows) remain in **[`journeys/`](journeys/README.md)**.

**Topic spine:** [traceability-by-topic.md](../traceability-by-topic.md) — topic IDs → roadmap, context, verification. **Related product truth (non-list):** [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md). **List triple:** [context README](./README.md) (theory index), [phase-01-contract-and-ia-baseline.md](../roadmap/phase-01-contract-and-ia-baseline.md), [phase-02-list-implementation-alignment.md](../roadmap/phase-02-list-implementation-alignment.md).

## How to use

1. Open the **topic inventory** for the area you are reviewing (`doc/roadmap/surface-inventory-*.md`).
2. Use **journeys** to validate flows end-to-end.
3. For each item, set a decision: `undecided` (default), `keep`, `tweak`, `remove`, `move-to-addon`, `defer`.
4. Record rationale and link the implementation slice when known.

## Shared reference (schemas & guidelines)

| Document | Role |
|----------|------|
| [velocity-surface-inventory-schema.md](./velocity-surface-inventory-schema.md) | Copy/paste schema for each inventory item |
| [velocity-contract-glossary.md](./velocity-contract-glossary.md) | Path / action / property / setting / generator definitions + dependency types |
| [velocity-surface-source-index.md](./velocity-surface-source-index.md) | Topic → primary `1080i/` and `shortcuts/` source files |
| [nonlist-generator-workflow.md](./nonlist-generator-workflow.md) | Mandatory SkinVariables regen workflow |
| [nonlist-skin-file-index.md](./nonlist-skin-file-index.md) | Concern → file quick map (overlaps partially with source index) |

## Topic inventories (status)

| # | Topic | File |
|---|--------|------|
| 01 | Home and hubs | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 02 | Search and discovery | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 03 | Dialogs, info, context | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 04 | OSD and playback | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 05 | Settings and customization | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 06 | Actions, paths, background | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |
| 07 | Shortcuts and generator | [phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) |

## Review order

1. Home and hubs → 2. Search → 3. Dialogs → 4. OSD → 5. Settings → 6. Actions/paths → 7. Generator → 8. [Journeys](journeys/README.md)

## Status legend

- `active`: currently reachable in normal UX.
- `hidden`: present but intentionally not visible.
- `fallback`: currently mapped to minimal/safe behavior (for example `Null.xsp`).
- `deprecated`: legacy behavior retained only for compatibility.
