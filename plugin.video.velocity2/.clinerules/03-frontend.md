# Frontend & Skinning Constraints

## Roadmap Phase Alignment

### Phase 1 Baseline Lock
- No third-party helpers: Velocity is 100% self-sufficient
- Widget routing: Always route UI directory items to `plugin://plugin.video.velocity2/?action=...`
- Pagination rules: Hero spotlights use `&paginate=false`; skip "Next Page" ListItem
- Custom overlays: Use `xbmcgui.WindowXMLDialog` bundled in addon resources

### Phase 2 List Alignment
- Verify generator source changes before regenerating
- Confirm generated output matches intended route updates
- Commit source + generated output together

### Phase 3 Non-List Surfaces
- Details/context: Info action resolves to full details (no small-popup fallback)
- OSD/playback: Minimal control scope plus controlled overlay -> full details transition
- Search chrome: Discover/Movies/TV with Velocity `execute_search` path model
- Removals: NextAired not primary Home rail, submenu/editor policy, PVR/legacy cleanup

### Phase 4 Freeze Verification
- Browse-to-play: Home/Series/Movies flow evidence incl. spotlight and widgets
- Search-to-play: Search entry, tabs, query flow, result-to-play
- Info-and-related: Info action behavior, context behavior, details transitions
- D-015 runtime: Pagination payload shape validated at runtime
- Non-list policy: OSD behavior, removals, D-021 effects, D-038 exception behavior

### Phase 5 Debt Closure
- Remove undeclared TMDbHelper dependencies from frontend code
- Keep only explicit D-038 exceptions with owner and rationale
- Reconcile remaining helper hits into D-038 exceptions ledger

## No Third-Party Helpers

Do NOT write code that relies on `plugin.video.tmdbhelper`, `script.skinvariables`, or `script.extendedinfo`. Velocity is 100% self-sufficient.

## Widget Routing

Always route UI directory items to `plugin://plugin.video.velocity2/?action=...`

## Pagination Rules

Hero spotlights and widgets often use a `&paginate=false` parameter. The UI builder must respect this and skip appending the "Next Page" ListItem when it is present.

## Custom Overlays

For custom UI elements overlaid on the player (e.g., the Skip Intro button), do not inject standard skin XML. Use `xbmcgui.WindowXMLDialog` bundled directly inside the addon's resources folder.
