# Journey Settings And Customize

## Flow

1. Open settings landing and choose category  
   - Links: `settings-landing`, `skinsettings-category-shell`  
   - Source: `1080i/Settings.xml`, `1080i/SkinSettings.xml`
2. Adjust home/hub and appearance options  
   - Links: `settings-home-and-hub-options`, `settings-appearance-options`  
   - Source: `1080i/Includes_SkinSettings.xml`
3. Tune detail/rating behavior  
   - Links: `settings-details-and-ratings`  
   - Source: `1080i/Includes_SkinSettings.xml`
4. Configure shortcuts and generated menu widgets  
   - Links: `settings-shortcut-editor-flow`, `generator-root-config`, `generator-setup-transform-rules`  
   - Source: `1080i/Dialog_DialogShortcuts.xml`, `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/setup/*.xml`

## Decision checkpoints

- Which settings should be hardcoded vs user-configurable?
- Is the shortcut editor still needed for personal use?
- Should helper-specific settings entries be removed?

## Decision state

- Decision: `undecided`
