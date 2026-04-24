# Journey Search To Play

## Flow

1. Search window open and default discover path  
   - Links: `search-window-entry`, `search-discover-contract`  
   - Source: `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`
2. Query and selector use  
   - Links: `search-selector-menu`, `search-autocompletion-dropdown`  
   - Source: `1080i/Includes_Search.xml`
3. Result feed resolution  
   - Links: `search-combined-standard-widgets`, `search-alias-resolution`  
   - Source: `1080i/Includes_Search.xml`, `shortcuts/generator/data/setup/search_path.xml`
4. Play action and OSD bridge  
   - Links: `action-dispatch-layer`, `osd-info-bridge`  
   - Source: `1080i/Includes_Actions.xml`, `1080i/Custom_1193_VideoOSDInfo.xml`

## Decision checkpoints

- Keep both combined and standard search widget modes, or hardcode one?
- Keep autocomplete integration or remove for cleaner UX?
- Should discover be always visible in search?

## Decision state

- Decision: `undecided`
