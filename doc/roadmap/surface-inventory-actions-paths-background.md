# Surface inventory: Actions, paths, and background

**Hub:** [Surface inventory index](../context/surface-inventory-index.md) · [Glossary](../context/velocity-contract-glossary.md) · [Schema](../context/velocity-surface-inventory-schema.md) · [Source index](../context/velocity-surface-source-index.md)

Cross-links:
- Journeys: [`browse-to-play`](../context/journeys/browse-to-play.md), [`info-and-related`](../context/journeys/info-and-related.md)

## Items

### Item `velocity-path-wrapper-contracts`
- **Surface:** `include`
- **User-visible behavior:** Central source for provider route variables.
- **Source files:** `1080i/Includes_Velocity_Paths.xml`
- **Contracts used:** `Velocity.Path.*`
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Core anti-duplication contract for all provider routing.
- **Implementation slice link:** `TBD`

### Item `global-path-variable-layer`
- **Surface:** `include`
- **User-visible behavior:** Computed path variables used by dialogs/OSD/info.
- **Source files:** `1080i/Includes_Paths.xml`
- **Contracts used:** `Path_*` variable family, monitor properties
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Central place for path behavior decisions and fallback policy.
- **Implementation slice link:** `TBD`

### Item `action-dispatch-layer`
- **Surface:** `include`
- **User-visible behavior:** Action variables for media play, sync, blur, scheme, OSD.
- **Source files:** `1080i/Includes_Actions.xml`
- **Contracts used:** `Action_*` variable family, `RunScript/RunPlugin/ActivateWindow`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** High coupling; needs explicit keep/simplify decisions.
- **Implementation slice link:** `TBD`

### Item `background-and-blur-properties`
- **Surface:** `contract`
- **User-visible behavior:** Background image source and blur behavior.
- **Source files:** `1080i/Includes_Actions.xml`, `1080i/Includes_Images.xml`, `1080i/Dialog_DialogCustom.xml`
- **Contracts used:** `TMDbHelper.Blur.*`, `Background.*` properties
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Potentially expensive and complex; strong candidate for hardcoding.
- **Implementation slice link:** `TBD`

### Item `context-parameter-contracts`
- **Surface:** `contract`
- **User-visible behavior:** Context-driven query/type/ID routing for related actions.
- **Source files:** `1080i/Includes_Paths.xml`, `1080i/Dialog_DialogContextMenu.xml`
- **Contracts used:** `Path_ContextParams_*`, `Path_InfoParams_*`
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Determines whether related/context experiences are rich or minimal.
- **Implementation slice link:** `TBD`

### Item `legacy-helper-property-model`
- **Surface:** `contract`
- **User-visible behavior:** Use of `TMDbHelper.*`/`TMDBHelper.*` properties across surfaces.
- **Source files:** `1080i/Includes_Paths.xml`, `1080i/Includes_Expressions.xml`, `1080i/Dialog*`, `1080i/Includes_*`
- **Contracts used:** `TMDbHelper.ListItem.*`, `TMDBHelper.IsUpdating*`, monitor keys
- **Dependency type:** `legacy-helper`
- **Current status:** `deprecated`
- **Decision:** `undecided`
- **Rationale:** Needs explicit retire/replace/defer policy per surface.
- **Implementation slice link:** `TBD`
