# Surface inventory item schema (decision template)

Copy this block for each inventory item. **Hub:** [Surface inventory index](./surface-inventory-index.md) · **Terminology:** [velocity-contract-glossary.md](velocity-contract-glossary.md).

---

## Item `<item-id>`

- **Surface:** `window|include|dialog|settings|journey`
- **User-visible behavior:** `<what the user sees/does>`
- **Source files:** `<path 1>`, `<path 2>`
- **Contracts used:** `<paths/actions/properties/settings>`
- **Dependency type:** `velocity|kodi-native|legacy-helper|mixed`
- **Current status:** `active|hidden|fallback|deprecated`
- **Decision:** `undecided|keep|tweak|remove|move-to-addon|defer`
- **Rationale:** `<why>`
- **Implementation slice link:** `<doc or run log link>`

### Notes

- Keep item IDs stable once created.
- Keep `Decision: undecided` until the review pass.
