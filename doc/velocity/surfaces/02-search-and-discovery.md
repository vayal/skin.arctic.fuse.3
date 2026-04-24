# 02 Search And Discovery

Cross-links:
- Journeys: [`journeys/search-to-play.md`](./journeys/search-to-play.md)
- Traceability: [`_traceability-index.md`](./_traceability-index.md)

## Items

### Item `search-window-entry`
- **Surface:** `window`
- **User-visible behavior:** Search window lifecycle and startup behavior.
- **Source files:** `1080i/Custom_1105_Search.xml`
- **Contracts used:** `TMDbHelper.UserDiscover.FolderPath` property key, discovery defaults
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Entry behavior affects first impression and discover path.
- **Implementation slice link:** `TBD`

### Item `search-selector-menu`
- **Surface:** `include`
- **User-visible behavior:** Search selector tabs/items and discover shortcut behavior.
- **Source files:** `1080i/Includes_Search.xml`
- **Contracts used:** selector item contracts, `RunPlugin(...)`, focus routing
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Key decision point for discover versus direct query UX.
- **Implementation slice link:** `TBD`

### Item `search-combined-standard-widgets`
- **Surface:** `include`
- **User-visible behavior:** Combined versus standard search widget layouts.
- **Source files:** `1080i/Includes_Search.xml`, `shortcuts/generator/data/base/search_widgets*.xml`
- **Contracts used:** `Skin.HasSetting(Search.DisableCombined)`, generated includes
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Defines complexity and density of search experience.
- **Implementation slice link:** `TBD`

### Item `search-alias-resolution`
- **Surface:** `generator`
- **User-visible behavior:** Alias-to-path conversion for search widgets.
- **Source files:** `shortcuts/generator/data/setup/search_path.xml`
- **Contracts used:** `DefaultSearch-*` aliases, provider path mapping
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** High leverage for controlling search behavior centrally.
- **Implementation slice link:** `TBD`

### Item `search-autocompletion-dropdown`
- **Surface:** `include`
- **User-visible behavior:** Input autocomplete and keyboard interaction.
- **Source files:** `1080i/Includes_Search.xml`
- **Contracts used:** `plugin.program.autocompletion`, edit control contracts
- **Dependency type:** `kodi-native`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Optional complexity that can be simplified for personal UX.
- **Implementation slice link:** `TBD`

### Item `search-discover-contract`
- **Surface:** `contract`
- **User-visible behavior:** Discovery feed fallback when query not focused.
- **Source files:** `1080i/Includes_Search.xml`, `1080i/Includes_Velocity_Paths.xml`
- **Contracts used:** `Velocity.Path.Discover`
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Core provider boundary item.
- **Implementation slice link:** `TBD`
