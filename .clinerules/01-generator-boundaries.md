# 1. Generator Boundaries & Constraints

## The Golden Rule
Arctic Fuse 3 is generator-driven. 
- **NEVER** edit files in the `1080i/` directory directly (e.g., `Includes_Home.xml`, `Includes_Hubs.xml`).
- **ONLY** edit files in `shortcuts/generator/data/` or the `skinvariables-*.json` files.

## Edit and Replace Contract
When updating XML blueprints:
- Preserve layout and structure perfectly. DO NOT change `<control>`, `<visible>`, `<posx>`, `<width>`, etc.
- Your sole job in these files is to swap out legacy `plugin.video.themoviedb.helper` routes and `$INFO` properties with Velocity equivalents.