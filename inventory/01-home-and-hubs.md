# 01 Home And Hubs

Cross-links:
- Journeys: [`journeys/browse-to-play.md`](./journeys/browse-to-play.md)
- Traceability: [`_traceability-index.md`](./_traceability-index.md)

## Items

### Item `home-root-window`
- **Surface:** `window`
- **User-visible behavior:** Main home shell and top-level focus/navigation behavior.
- **Source files:** `1080i/Home.xml`, `1080i/Includes_Home.xml`
- **Contracts used:** `HomeSwitcher.*`, `ActivateWindow(...)`, focus actions
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Root entry for all browsing behavior.
- **Implementation slice link:** `TBD`

### Item `home-switcher-shortcuts`
- **Surface:** `include`
- **User-visible behavior:** Home category shortcuts and targets.
- **Source files:** `1080i/Includes_Home.xml`
- **Contracts used:** `Skin.String(HomeSwitcher.*.Shortcut.Path/Target)`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Primary path dispatch for home navigation.
- **Implementation slice link:** `TBD`

### Item `home-submenu-staticitems`
- **Surface:** `include`
- **User-visible behavior:** Per-window static submenu rows.
- **Source files:** `1080i/Includes_Home.xml`, `shortcuts/generator/data/base/home_submenu.xml`
- **Contracts used:** `skinvariables-$PARAM[window]submenu-staticitems`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Submenu is a frequent decision surface for personalization.
- **Implementation slice link:** `TBD`

### Item `hubs-spotlight-list`
- **Surface:** `include`
- **User-visible behavior:** Spotlight hero/feed source shown in hub views.
- **Source files:** `1080i/Includes_Hubs.xml`
- **Contracts used:** list path contracts, non-paginated policy
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** High visibility and high impact on browsing UX.
- **Implementation slice link:** `TBD`

### Item `hubs-widget-modes`
- **Surface:** `include`
- **User-visible behavior:** Standard/combined/wall widget families.
- **Source files:** `1080i/Includes_Hubs.xml`
- **Contracts used:** `HomeSwitcher.*.Mode`, generated include families
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Defines core feel of the skin at home level.
- **Implementation slice link:** `TBD`

### Item `hubs-widget-selector-and-info`
- **Surface:** `include`
- **User-visible behavior:** Widget selectors and info panes per mode.
- **Source files:** `1080i/Includes_Hubs.xml`
- **Contracts used:** `skinvariables-*widgets-*selector`, `*widgets-*info`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Often where clutter vs clarity trade-offs are decided.
- **Implementation slice link:** `TBD`

### Item `nextaired-home-rails`
- **Surface:** `include`
- **User-visible behavior:** Next-aired style day rails in hubs.
- **Source files:** `1080i/Includes_NextAired.xml`
- **Contracts used:** smart-list path(s), widget containers 501-508
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Distinctive rail pattern that may be kept/tweaked/removed.
- **Implementation slice link:** `TBD`
