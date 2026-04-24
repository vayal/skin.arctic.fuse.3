# 07 Shortcuts Generator Pipeline

Cross-links:
- Seed docs (if present alongside `doc/`): [`../menu-inventory.md`](../menu-inventory.md), [`../settings-inventory.md`](../settings-inventory.md)
- Journeys: [`journeys/settings-and-customize.md`](./journeys/settings-and-customize.md)
- Traceability: [`_traceability-index.md`](./_traceability-index.md)

## Items

### Item `generator-root-config`
- **Surface:** `generator`
- **User-visible behavior:** Controls which generator sources emit runtime includes.
- **Source files:** `shortcuts/skinvariables-generator.json`
- **Contracts used:** `genxml`, `output filename`, `skinid`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Top-level contract for all generated menus/widgets/settings nodes.
- **Implementation slice link:** `TBD`

### Item `generator-base-definitions`
- **Surface:** `generator`
- **User-visible behavior:** Defines foundational menu/widget/search/power structures.
- **Source files:** `shortcuts/generator/data/base/*.xml`
- **Contracts used:** include name families, item templates
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Structure-level decisions should happen before item-level tweaks.
- **Implementation slice link:** `TBD`

### Item `generator-setup-transform-rules`
- **Surface:** `generator`
- **User-visible behavior:** Rule-based path/target/action transformations.
- **Source files:** `shortcuts/generator/data/setup/*.xml`
- **Contracts used:** alias mapping, path normalization, visibility rules
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Central point for changing behavior safely at scale.
- **Implementation slice link:** `TBD`

### Item `generator-item-templates`
- **Surface:** `generator`
- **User-visible behavior:** Emitted XML markup for menu and widget list items.
- **Source files:** `shortcuts/generator/data/parts/*.xmltemplate`
- **Contracts used:** template placeholders, item markup contracts
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Ensures consistency but can increase complexity.
- **Implementation slice link:** `TBD`

### Item `generated-include-load-contract`
- **Surface:** `include`
- **User-visible behavior:** Loads generated includes per skin user profile.
- **Source files:** `1080i/Includes.xml`
- **Contracts used:** `script-skinvariables-generator-includes-*.xml`, `SkinVariables.SkinUser`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Must remain stable during personalization changes.
- **Implementation slice link:** `TBD`

### Item `search-widget-alias-family`
- **Surface:** `generator`
- **User-visible behavior:** Search widget path aliases and provider mappings.
- **Source files:** `shortcuts/generator/data/setup/search_path.xml`, `shortcuts/skinvariables-shortcut-searchwidgets.json`
- **Contracts used:** `DefaultSearch-*` aliases, provider path values
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** High-frequency user flow and common migration risk area.
- **Implementation slice link:** `TBD`
