# Python Syntax, Styling & Kodi Quirks

## Roadmap Phase Alignment

### Phase 1 Baseline Lock
- Strict type hinting enforced on all function signatures
- Defensive JSON/dictionary parsing patterns locked
- Router class pattern for Daemon communication
- Kodi UI logging/notifications patterns
- Sorting & directory ends: use `_end_directory_preserve_order`
- URL encoding: Always use `urllib.parse.quote(var, safe='')`

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
- Remove undeclared TMDbHelper dependencies from code
- Keep only explicit D-038 exceptions with owner and rationale
- Reconcile remaining helper hits into D-038 exceptions ledger

## Strict Type Hinting

Every function signature MUST include type hints (e.g., `def handle_list(list_id: str, page: int = 1) -> None:`). Use the `typing` module extensively (`Dict`, `Any`, `Optional`, `Tuple`).

## Defensive JSON/Dictionary Parsing

NEVER chain `.get()` calls blindly (e.g., do NOT do `data.get('metadata', {}).get('title')`). ALWAYS verify the dictionary type first to prevent `AttributeError` on null payloads.

*Example Pattern:*
```python
raw_meta = data.get('metadata')
meta: Dict[str, Any] = raw_meta if isinstance(raw_meta, dict) else {}
title = meta.get('title')
```

## Resource Management (The Router)

In `lib/client/`, communication with the Daemon is handled strictly by the `Router` class. You MUST instantiate the Router, perform the request, and close it inside a `try/finally` block to prevent socket leaks.

*Example Pattern:*
```python
router = Router(port=int(cfg.get_setting('daemon_port', '65432')))
try:
    data = router.get_json('/api/endpoint')
finally:
    router.close()
```

## Kodi UI Logging & Notifications

NEVER use `print()`. It fails in Kodi.
- For backend logging, use `xbmc.log(f'Message', xbmc.LOGINFO)` or `xbmc.LOGWARNING`.
- For user-facing errors, use `xbmcgui.Dialog().ok('Velocity', str(e))`.
- For silent success states, use `xbmcgui.Dialog().notification('Velocity', 'Message', xbmcgui.NOTIFICATION_INFO, 3000)`.

## Sorting & Directory Ends

When building a UI directory, NEVER use standard `xbmcplugin.endOfDirectory(handle)`. ALWAYS use the internal `_end_directory_preserve_order(handle)` to ensure Kodi respects the Daemon's `SORT_METHOD_PLAYLIST_ORDER`.

## URL Encoding

When passing strings (like queries or IDs) into URLs, ALWAYS use `urllib.parse.quote(var, safe='')`.
