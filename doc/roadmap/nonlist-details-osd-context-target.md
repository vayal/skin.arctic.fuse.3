# Non-list target — details, context menu, OSD

**Truth type:** product **target** (what the fork should aim for). For checklists, see status docs linked from [nonlist-surfaces-index.md](nonlist-surfaces-index.md).

## Details and context

- **Full-screen details** are the canonical **“Info”** experience.
- **Rails** on details should stay **lean** (minimal clutter, Velocity-first content).
- **Context menu** (`Dialog_DialogContextMenu.xml`) should be **curated** — only actions that make sense for Velocity; formal keep/remove is tracked under **D-021** (see [nonlist-details-context-status.md](./nonlist-details-context-status.md)).

## OSD and playback chrome

- Remove or avoid reliance on **playlist OSD**, **cast OSD**, and **PVR** playback chrome where the fork policy says to drop them.
- **OSD next-recommendation** behavior follows product choice (lean rail / overlay); align `Custom_1193` and `Includes_OSD.xml` with the agreed pattern.

## Typical files

`DialogVideoInfo.xml`, `Includes_DialogInfo.xml`, `Dialog_DialogContextMenu.xml`, `Includes_OSD.xml`, and related includes — see [nonlist-skin-file-index.md](../context/nonlist-skin-file-index.md).
