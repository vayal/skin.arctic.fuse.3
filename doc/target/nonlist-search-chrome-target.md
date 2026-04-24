# Non-list target — search chrome

**Truth type:** product **target** for the **search window** and tab behavior (not list payload contracts — those stay in [LIST_CONTRACTS_TARGET.md](LIST_CONTRACTS_TARGET.md)).

## Direction

- **Canonical path:** Velocity **`execute_search`** and **Discover** flows (`plugin://plugin.video.velocity2/…`) as wired in `Custom_1105_Search.xml` / `Includes_Search.xml`.
- **Generator / legacy tabs:** The base generator may still define **videodb://** / **musicdb://** smart-playlist rows (Movies / TV / Music / Artists). Treat these as **optional Kodi-library compatibility** until explicitly removed — roadmap **Phase 04+** if product drops local-library search entirely.
- **Product alignment:** Prefer tabs and copy that surface only what the product wants (e.g. Discover + Movies + TV only); trim cruft in `search_path.xml` and shortcut JSON when status work closes the gap.

## Typical files

See Search row in [nonlist-skin-file-index.md](../context/nonlist-skin-file-index.md).
