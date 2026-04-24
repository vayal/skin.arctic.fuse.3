# Async & Heavy Computation (Binge Tech)

## Roadmap Phase Alignment

### Phase 1 Baseline Lock
- Daemon handles all heavy computations (FFT audio fingerprinting, OpenCV frame sampling, Predictive Buffering)
- Thread safety enforced: no blocking of main Kodi thread
- HTTP Range Requests used for media sampling (first 50MB for intros)

### Phase 2 List Alignment
- Daemon handles all list contract queries for D-015 families
- Client renders standard ListItem objects per contract schema
- No direct DB writes in client code paths

### Phase 3 Non-List Surfaces
- Details/context: Daemon resolves full details, Client renders dialogs
- OSD/playback: Daemon handles overlay transitions, Client renders controls
- Search chrome: Daemon executes search queries, Client renders results

### Phase 4 Freeze Verification
- Runtime evidence captures Daemon response times and payload shapes
- Client focus/navigation verified against Daemon-delivered ListItem objects
- Playback continuity verified after closing full details

### Phase 5 Debt Closure
- Remove undeclared TMDbHelper dependencies from computation code
- Keep only explicit D-038 exceptions with owner and rationale
- Reconcile remaining helper hits into D-038 exceptions ledger

## Thread Safety

Do NOT block the main Kodi thread. Any function dealing with FFT audio fingerprinting, OpenCV frame sampling, or Predictive Buffering MUST be executed asynchronously or in a separate background daemon thread.

## HTTP Range Requests

When sampling video or audio for intros/outros, NEVER download the full media file. You must use HTTP Range Requests to pull only the specific byte chunks required for analysis (e.g., the first 50MB for an intro).

## Graceful Failures

Always wrap external heavy library imports in `try/except ImportError` blocks. Kodi hardware environments vary wildly, and the addon must fail gracefully if a library is missing.

## Library Dependencies

- `scipy` - FFT audio fingerprinting
- `numpy` - Numerical computations
- `cv2` (OpenCV) - Frame sampling
- `ffmpeg` - Media analysis

All dependencies should be wrapped in graceful import handling to ensure addon stability across different Kodi hardware configurations.
