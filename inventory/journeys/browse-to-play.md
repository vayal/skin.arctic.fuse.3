# Journey Browse To Play

## Flow

1. Home entry and category selection  
   - Links: `home-root-window`, `home-switcher-shortcuts`  
   - Source: `1080i/Home.xml`, `1080i/Includes_Home.xml`
2. Hub row and spotlight selection  
   - Links: `hubs-spotlight-list`, `hubs-widget-modes`, `hubs-widget-selector-and-info`  
   - Source: `1080i/Includes_Hubs.xml`
3. Item context and playback action  
   - Links: `action-dispatch-layer`, `osd-main-controls`  
   - Source: `1080i/Includes_Actions.xml`, `1080i/Includes_OSD.xml`
4. Post-playback suggestion behavior  
   - Links: `osd-next-recommendation`  
   - Source: `1080i/Includes_Paths.xml`

## Decision checkpoints

- Should spotlight stay dynamic or be hardcoded to fixed rails?
- Should autoplay/next recommendation remain enabled by default?
- Which controls are essential in personal-use playback?

## Decision state

- Decision: `undecided`
