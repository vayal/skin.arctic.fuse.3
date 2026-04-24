# Skin Inventory System

This directory is **`doc/velocity/surfaces/`** — the canonical **surface and journey** workspace for the `skin.velocity.af3` fork (hierarchy `01`–`07`, user journeys, decision templates). Parent index: **[`../README.md`](../README.md)**.

Scope in this inventory pass:
- Runtime-visible UX surfaces.
- Supporting contracts required to operate those surfaces (paths, actions, properties, settings, generator outputs).

## How to use

1. Start with hierarchy docs (`01`..`07`) to review features by skin structure.
2. Use journey docs (`journeys/*`) to validate real user flows end-to-end.
3. For each item, set a decision:
   - `undecided` (default)
   - `keep`
   - `tweak`
   - `remove`
   - `move-to-addon`
   - `defer`
4. Record rationale and link the implementation slice.

## Review order

1. `01-home-and-hubs.md`
2. `02-search-and-discovery.md`
3. `03-dialogs-info-and-context.md`
4. `04-osd-and-playback-surfaces.md`
5. `05-settings-and-customization.md`
6. `06-actions-properties-and-background-contracts.md`
7. `07-shortcuts-generator-pipeline.md`
8. `journeys/README.md`

## Status legend

- `active`: currently reachable in normal UX.
- `hidden`: present but intentionally not visible.
- `fallback`: currently mapped to minimal/safe behavior (for example `Null.xsp`).
- `deprecated`: legacy behavior retained only for compatibility.

## Common item schema

Use the schema from `_decision-template.md` for every inventory entry.

## Core cross-links

- Decision template: [`_decision-template.md`](./_decision-template.md)
- Contract glossary: [`_contract-glossary.md`](./_contract-glossary.md)
- Traceability index: [`_traceability-index.md`](./_traceability-index.md)
- Journey index: [`journeys/README.md`](./journeys/README.md)
