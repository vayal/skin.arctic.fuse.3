# Surface inventory: OSD and playback

**Hub:** [Surface inventory index](../context/surface-inventory-index.md) · [Glossary](../context/velocity-contract-glossary.md) · [Schema](../context/velocity-surface-inventory-schema.md) · [Source index](../context/velocity-surface-source-index.md)

Cross-links:
- Journeys: [`browse-to-play`](../context/journeys/browse-to-play.md), [`info-and-related`](../context/journeys/info-and-related.md)

## Items

### Item `osd-main-controls`
- **Surface:** `include`
- **User-visible behavior:** Main OSD controls, focus routing, and on-down transitions.
- **Source files:** `1080i/Includes_OSD.xml`, `1080i/Includes_Actions.xml`
- **Contracts used:** OSD navigation action variables
- **Dependency type:** `kodi-native`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Core playback interaction layer.
- **Implementation slice link:** `TBD`

### Item `osd-playlist-dialog`
- **Surface:** `dialog`
- **User-visible behavior:** Video playlist OSD overlay and item interaction.
- **Source files:** `1080i/Custom_1140_OSD_Playlist.xml`
- **Contracts used:** playlist contracts, player state contracts
- **Dependency type:** `kodi-native`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Important if playlist browsing matters in your personal usage.
- **Implementation slice link:** `TBD`

### Item `osd-cast-dialog`
- **Surface:** `dialog`
- **User-visible behavior:** OSD cast/crew tray and list surface.
- **Source files:** `1080i/Custom_1141_OSD_Cast.xml`, `1080i/Includes_Paths.xml`
- **Contracts used:** `Path_OSD_Cast`, `VideoOSD.PersonCredits.*`
- **Dependency type:** `legacy-helper`
- **Current status:** `hidden`
- **Decision:** `undecided`
- **Rationale:** Already hidden in current migration; needs explicit final decision.
- **Implementation slice link:** `TBD`

### Item `osd-info-bridge`
- **Surface:** `dialog`
- **User-visible behavior:** OSD to info bridge dialog with one-item info fallback behavior.
- **Source files:** `1080i/Custom_1193_VideoOSDInfo.xml`
- **Contracts used:** smart-list fallback contracts, info action transition
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Critical bridge between playback and detail surfaces.
- **Implementation slice link:** `TBD`

### Item `pvr-info-dialog-actions`
- **Surface:** `dialog`
- **User-visible behavior:** PVR info dialog actions and transitions.
- **Source files:** `1080i/Dialog_DialogPVRInfo.xml`
- **Contracts used:** info action contracts, monitor properties
- **Dependency type:** `mixed`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** PVR behavior may be irrelevant for personal use and can be reduced.
- **Implementation slice link:** `TBD`

### Item `osd-next-recommendation`
- **Surface:** `contract`
- **User-visible behavior:** Next recommendation source while playing.
- **Source files:** `1080i/Includes_Paths.xml`
- **Contracts used:** `Path_OSD_NextRecommendation`
- **Dependency type:** `velocity`
- **Current status:** `active`
- **Decision:** `undecided`
- **Rationale:** Controls recommendation experience quality vs simplicity.
- **Implementation slice link:** `TBD`
