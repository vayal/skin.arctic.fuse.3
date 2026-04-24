# Target — what we are building

Use these documents for **product intent**, **screen behavior**, **D-015 list contracts**, and **decisions**. They answer “what should it do?” — not “what did we merge last week?”

| Document | Role |
|----------|------|
| [skin-vision-blueprint-v1.md](skin-vision-blueprint-v1.md) | Structured blueprint (hubs, widgets, lists, OSD) + target matrix |
| [LIST_CONTRACTS_TARGET.md](LIST_CONTRACTS_TARGET.md) | **List truth (target):** required `contract_id` / hub rows, pagination, D-015 guarantees |
| [screen-by-screen-build-contract.md](screen-by-screen-build-contract.md) | **Non-list** surfaces: details, OSD, removals, generator workflow, file index |
| [d003-view-mode-matrix.md](d003-view-mode-matrix.md) | Hub/window IDs and view-mode locking decisions (**D-003**) |

## List contracts — three directories

| # | Directory | Document | Question |
|---|-----------|----------|----------|
| 1 | **[`../contracts/`](../contracts/README.md)** | [LIST_ADDON_THEORY.md](../contracts/LIST_ADDON_THEORY.md) | **Theory:** How does the addon implement lists/rails? |
| 2 | **`target/`** (this folder) | [LIST_CONTRACTS_TARGET.md](LIST_CONTRACTS_TARGET.md) | **Target:** Which list contracts and UX are **required**? |
| 3 | **[`../status/`](../status/README.md)** | [LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) | **Status:** What is **wired today** and what is **open**? |

### Superseded narrative

The long-form v0 blueprint is kept for **history and traceability** only:

- [../archive/skin-vision-blueprint-v0.md](../archive/skin-vision-blueprint-v0.md)

Prefer **v1** + **`LIST_CONTRACTS_TARGET`** for list product work, **[`../contracts/`](../contracts/README.md)** for addon theory, **[`../status/LIST_IMPLEMENTATION_STATUS.md`](../status/LIST_IMPLEMENTATION_STATUS.md)** for as-built list status, and **screen-by-screen** for non-list surface work.

### Skin implementation / legacy symbols

- [D-038 legacy property ledger](../velocity/d038-legacy-property-ledger.md) — what may still reference helper-era properties in XML
