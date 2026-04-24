# Non-list — SkinVariables generator workflow (guideline)

**Purpose:** Keep generated hub/widget output reproducible. This is a **process contract** for contributors — not a product feature spec.

## Rule

`1080i/script-skinvariables-generator-includes.xml` is **generated output**. Do not hand-edit it for changes that must survive the next regen.

## Required path

1. Edit **sources:** `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/…`, and the relevant shortcut JSONs (e.g. `shortcuts/skinvariables-shortcut-1101widgets.json`, home widgets, splash, startup, etc.).
2. **Regenerate** the skinvariables output using the project’s generator workflow (same as upstream AF3 fork conventions).
3. **Commit sources and output together** in one change set.

## See also

- [nonlist-skin-file-index.md](nonlist-skin-file-index.md) — where generator inputs and outputs live  
- [../roadmap/phase-03-non-list-surfaces-implementation.md](../roadmap/phase-03-non-list-surfaces-implementation.md) — non-list documentation hub
