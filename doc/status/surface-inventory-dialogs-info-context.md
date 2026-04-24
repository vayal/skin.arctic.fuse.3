# Surface inventory: Dialogs, info, and context

**Hub:** [Surface inventory index](../context/surface-inventory-index.md) · [Glossary](../context/velocity-contract-glossary.md) · [Schema](../context/velocity-surface-inventory-schema.md) · [Source index](../context/velocity-surface-source-index.md)

Cross-links:
- Journeys: [`info-and-related`](../context/journeys/info-and-related.md)

## Items

### Item `dialog-info-main`
- **Surface:** `dialog`
- **User-visible behavior:** Main info dialog behavior and widget stack for selected content.
- **Source files:** `1080i/DialogVideoInfo.xml`, `1080i/Includes_DialogInfo.xml`
- **Contracts used:** info widget content paths, item property contracts
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Major UX decision area for data density.
- **Implementation slice link:** `TBD`

### Item `dialog-view-crew-details`
- **Surface:** `dialog`
- **User-visible behavior:** Crew/writer/director detail drill-down dialog.
- **Source files:** `1080i/Dialog_DialogView.xml`
- **Contracts used:** details path contract, tmdb_id/tmdb_type properties
- **Dependency type:** `mixed`
- **Current status:** `fallback`
- **Decision:** `undecided`
- **Rationale:** Historically helper-heavy; now needs explicit keep/remove choice.
- **Implementation slice link:** `TBD`

### Item `dialog-plot-custom`
- **Surface:** `dialog`
- **User-visible behavior:** Extended plot/custom info dialog and mode switching.
- **Source files:** `1080i/Dialog_DialogPlot.xml`, `1080i/Custom_1114_Dialog_CustomPlot.xml`
- **Contracts used:** `ModePath`, context params, routed actions
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Contains many legacy advanced flows that may be overkill.
- **Implementation slice link:** `TBD`

### Item `dialog-contextmenu-expanded`
- **Surface:** `dialog`
- **User-visible behavior:** Expanded context menu with plot/wiki/related/trailer shortcuts.
- **Source files:** `1080i/Dialog_DialogContextMenu.xml`
- **Contracts used:** context params, related/discover action paths
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Key convenience layer; candidate for simplification.
- **Implementation slice link:** `TBD`

### Item `dialog-person-and-crew-rails`
- **Surface:** `include`
- **User-visible behavior:** Person/cast/crew secondary rails and image galleries.
- **Source files:** `1080i/Includes_DialogInfo.xml`
- **Contracts used:** person details, stars_in_*, crew_in_* content contracts
- **Dependency type:** `legacy-helper`
- **Current status:** `fallback`
- **Decision:** `undecided`
- **Rationale:** Non-parity-heavy; likely remove/defer for personal fork.
- **Implementation slice link:** `TBD`

### Item `dialog-trailer-flow`
- **Surface:** `dialog`
- **User-visible behavior:** Trailer list/open/play flow from info/context surfaces.
- **Source files:** `1080i/Dialog_DialogTrailer.xml`, `1080i/Includes_DialogInfo.xml`
- **Contracts used:** trailer property contracts, action play trailer builtin
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Useful but can be reduced if cluttered.
- **Implementation slice link:** `TBD`
