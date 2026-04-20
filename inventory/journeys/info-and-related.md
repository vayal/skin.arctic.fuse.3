# Journey Info And Related

## Flow

1. Open info dialog from list/OSD/context  
   - Links: `dialog-info-main`, `osd-info-bridge`  
   - Source: `1080i/DialogVideoInfo.xml`, `1080i/Custom_1193_VideoOSDInfo.xml`
2. Extended plot/custom dialog  
   - Links: `dialog-plot-custom`  
   - Source: `1080i/Dialog_DialogPlot.xml`, `1080i/Custom_1114_Dialog_CustomPlot.xml`
3. Context actions (related/wiki/trailer)  
   - Links: `dialog-contextmenu-expanded`, `context-parameter-contracts`  
   - Source: `1080i/Dialog_DialogContextMenu.xml`, `1080i/Includes_Paths.xml`
4. Person/cast/crew drill-down surfaces  
   - Links: `dialog-view-crew-details`, `dialog-person-and-crew-rails`  
   - Source: `1080i/Dialog_DialogView.xml`, `1080i/Includes_DialogInfo.xml`

## Decision checkpoints

- Keep rich info depth or simplify to plot/trailer only?
- Remove person/cast/crew drill-downs entirely in personal mode?
- Keep context menu related action or repurpose as discover shortcut?

## Decision state

- Decision: `undecided`
