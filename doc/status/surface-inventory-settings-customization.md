# Surface inventory: Settings and customization

**Hub:** [Surface inventory index](../context/surface-inventory-index.md) · [Glossary](../context/velocity-contract-glossary.md) · [Schema](../context/velocity-surface-inventory-schema.md) · [Source index](../context/velocity-surface-source-index.md)

Cross-links:
- Journeys: [`settings-and-customize`](../context/journeys/settings-and-customize.md)
- Optional seed docs (add under `doc/` if needed): `doc/settings-inventory.md`

## Items

### Item `settings-landing`
- **Surface:** `window`
- **User-visible behavior:** Top-level settings landing categories and tools.
- **Source files:** `1080i/Settings.xml`
- **Contracts used:** `ActivateWindow(...)`, addon settings actions
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** High-level discoverability for all customization paths.
- **Implementation slice link:** `TBD`

### Item `skinsettings-category-shell`
- **Surface:** `window`
- **User-visible behavior:** Skin settings categories and category navigation shell.
- **Source files:** `1080i/SkinSettings.xml`, `1080i/SettingsCategory.xml`
- **Contracts used:** category includes, level guards
- **Dependency type:** `kodi-native`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Defines settings IA and complexity.
- **Implementation slice link:** `TBD`

### Item `settings-home-and-hub-options`
- **Surface:** `include`
- **User-visible behavior:** Home/widget/menu behavior toggles and defaults.
- **Source files:** `1080i/Includes_SkinSettings.xml`
- **Contracts used:** `HomeSwitcher.*`, `Skin.ToggleSetting(...)`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Major personal preference area.
- **Implementation slice link:** `TBD`

### Item `settings-appearance-options`
- **Surface:** `include`
- **User-visible behavior:** Colors, background, blur and style presets.
- **Source files:** `1080i/Includes_SkinSettings.xml`, `1080i/Dialog_DialogCustom.xml`
- **Contracts used:** dialog custom settings groups, scheme actions
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Balances visual polish with configuration overhead.
- **Implementation slice link:** `TBD`

### Item `settings-details-and-ratings`
- **Surface:** `include`
- **User-visible behavior:** Metadata detail/rating controls and related toggles.
- **Source files:** `1080i/Includes_SkinSettings.xml`
- **Contracts used:** detail/rating setting contracts
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Often noisy; likely candidate for hardcoded simplification.
- **Implementation slice link:** `TBD`

### Item `settings-shortcut-editor-flow`
- **Surface:** `dialog`
- **User-visible behavior:** Shortcut configuration and node editing.
- **Source files:** `1080i/Custom_1115_Window_Shortcuts.xml`, `1080i/Custom_1116_Dialog_Shortcuts.xml`, `1080i/Dialog_DialogShortcuts.xml`, `1080i/Custom_1124_Dialog_Shortcut_Settings.xml`
- **Contracts used:** `script.skinvariables` shortcut node actions
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Powerful but complex subsystem to keep/tighten/remove.
- **Implementation slice link:** `TBD`

### Item `settings-legacy-helper-entries`
- **Surface:** `settings`
- **User-visible behavior:** Legacy helper addon settings visibility and management entries.
- **Source files:** `1080i/Settings.xml`, `1080i/Includes_SkinSettings.xml`
- **Contracts used:** addon-enabled guards and addon settings actions
- **Dependency type:** `legacy-helper`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Post-migration cleanup decision point.
- **Implementation slice link:** `TBD`
