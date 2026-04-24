# Progress — Arctic Fuse 3 Velocity Migration

## What Works

### Core Functionality (Post-Migration)

- **Home hub**: Spotlight + in-progress series/movies tabs
- **Series hub**: Spotlight + continue watching + in-progress + trending + provider icons + genre buttons
- **Movies hub**: Spotlight + in-progress + trending + provider icons + genre buttons
- **Provider mini-hubs**: Netflix, Disney+, Prime, Apple TV+, Hulu, Max, Paramount+, Peacock, BBC
- **Search**: Discover + movies + TV shows (combined mode)
- **Details**: Full-screen info (no small info dialog UX)
- **OSD**: Minimal overlay on pause (title + plot)
- **Progress tracking**: Continue watching, in-progress, recently watched

### Completed Phases

| Phase | Status | Key Deliverables |
|---|---|---|
| Phase 01 | ✅ Completed | Frozen D-003, D-015, D-021, D-038 decisions |
| Phase 02 | ✅ Completed | Velocity D-015 contracts implemented |
| Phase 03 | ✅ Completed | Core plumbing migrated (Paths, Actions, DialogInfo, OSD) |
| Phase 04 | ✅ Completed | Removals enforced (context menu, PVR, OSD cast, Wikipedia, crew, plot dialog) |
| Phase 05 | ✅ Completed | Metadata/rendering migrated (Images, Labels, Info, Views, Widgets) |
| Phase 06 | ✅ Completed | Deferred exceptions cleaned (Weather removed, blur decoupled) |
| Phase 07 | 🚧 Blocked | Requires runtime evidence |

## What's Left to Build

### Phase 07: Stabilization and Freeze

**Remaining**: Runtime validation evidence

| Item | Status | Evidence Needed |
|---|---|---|
| Browse-to-play journey | ❌ | Home → Series hub → Continue watching → Play |
| Search-to-play journey | ❌ | Discover → Movie → Play |
| Info-and-related journey | ❌ | Row → Full details → Trailer |
| Pagination: in-row cap 10 | ❌ | Row-end Next Page behavior |
| Pagination: full list 40/page | ❌ | Header click → full list |
| Empty state | ❌ | "No items available" rendering |

**Bootstrap reset procedure** (for operator capture):

```
Skin.Reset(HomeSwitcher.1101.Toggle)
Skin.Reset(HomeSwitcher.1102.Toggle)
Skin.Reset(HomeSwitcher.1103.Toggle)
Skin.Reset(HomeSwitcher.1104.Toggle)
Skin.Reset(HomeSwitcher.1106.Toggle)
Skin.Reset(HomeSwitcher.1107.Toggle)
Skin.Reset(HomeSwitcher.1108.Toggle)
Skin.Reset(HomeSwitcher.LoopBack)
Skin.Reset(DefaultConfig.InitDone)
ActivateWindow(Startup)
```

### Post-Freeze (Future Considerations)

| Item | Notes |
|---|---|
| Generator pipeline trimming | Library DB tabs (videodb://, musicdb://) may need removal |
| Full details refinement | Ensure all metadata fields render correctly |
| Provider mini-hub expansion | Contract specifies 4 genre rows per provider |
| OSD bridge polish | Verify overlay → full-details escalation |

## Current Status

### Phase 07 Blocker

**Issue**: No Kodi runtime evidence for mandatory journeys and pagination checks

**Impact**: Phase 07 cannot be marked completed; freeze gate not satisfied

**Evidence**:
- No Kodi logs/screenshots appended to [Phase 1 plan §Validation status](../doc/roadmap/phase-01-freeze-and-runtime-verification.md#validation-status-and-blockers)
- D-015 pagination / empty-state not exercised at runtime ([Phase 1 Appendix A](../doc/roadmap/phase-01-freeze-and-runtime-verification.md#appendix-a--verification-checklists-operator) §A.1–A.3)

**Resolution**: Requires operator session in Kodi to:
1. Execute bootstrap reset
2. Capture hub navigation screenshots
3. Capture search combined flow
4. Capture full details flow
5. Capture OSD bridge flow
6. Verify pagination behavior

### Known Issues

| Issue | Severity | Status |
|---|---|---|
| Phase 07 blocked | P1 | Open |
| TMDbHelper.UserDiscover.FolderPath (keep-temporary) | Info | Documented in D-038 §4 |
| Writer/director crew bindings | Info | Documented in D-038 §4 |
| OSD crop image binding | Info | Documented in D-038 §4 |
| Background blur toggle | Info | Documented in D-038 §4 |
| Shortcut generator presets | Info | Documented in D-038 §4 |

## Evolution of Project Decisions

### Decision 1: Contract-First Migration

**When**: Phase 01 → Phase 02

**Decision**: Implement Velocity D-015 contracts before skin changes

**Rationale**: Prevents cascading breakage; skin depends on data shapes

**Impact**: Phases 03-06 could proceed with confidence

### Decision 2: Native Properties Over Helper Properties

**When**: Phase 05

**Decision**: Migrate from `TMDbHelper.*` to `ListItem.*`, `Container.*`, `VideoPlayer.*`

**Rationale**: Faster rendering; no addon bridge; better debugging

**Impact**: Improved performance; cleaner architecture

### Decision 3: Temporary Exceptions Allowed

**When**: Throughout migration

**Decision**: Documented exceptions (D-038 §4) permitted during transition

**Rationale**: Some bindings have no active UX path yet

**Impact**: Prevented premature cleanup of working code

### Decision 4: Generator Pipeline Preserved

**When**: Phase 01 → Phase 03

**Decision**: Never edit output XML; only edit blueprints

**Rationale**: AF3 is highly dynamic; static edits are overwritten

**Impact**: Maintained AF3's dynamic nature; prevented corruption

## Validation History

### Phase 01: Preflight and Contract Lock

| Check | Result |
|---|---|
| D-003 accepted and linked | ✅ |
| D-015 accepted and linked | ✅ |
| D-021 accepted in blueprint | ✅ |
| D-038 accepted and linked | ✅ |
| Execution boundaries explicit | ✅ |

### Phase 02: Addon Contract Implementation

| Check | Result |
|---|---|
| Contract families implemented | ✅ |
| Schema guarantees match D-015 | ✅ |
| Sample payload fixtures produced | ✅ |
| Pagination payload enforced | ✅ |
| Progress fields present | ✅ |

### Phase 03: Skin Core Plumbing Migration

| Check | Result |
|---|---|
| Batch B files migrated | ✅ |
| Control-plane routing no longer helper-dependent | ✅ |
| Temporary exception list unchanged | ✅ |
| Details → playback → details loop | ✅ (static) |
| Search combined mode | ✅ (static) |

### Phase 04: Skin Removal and Policy Enforcement

| Check | Result |
|---|---|
| Batch A removals implemented | ✅ |
| D-021 exactly enforced | ✅ |
| No policy regressions in core UX | ✅ (static) |
| Context menu expanded items removed | ✅ |
| PVR surfaces removed | ✅ |
| Wikipedia/crew flows removed | ✅ |

### Phase 05: Metadata and Rendering Migration

| Check | Result |
|---|---|
| Batch C files migrated | ✅ |
| No active helper-bound metadata | ✅ |
| Image-only row cards | ✅ (static) |
| Spotlight metadata | ✅ (static) |
| Info overlays | ✅ (static) |

### Phase 06: Deferred Exceptions and Final Cleanup

| Check | Result |
|---|---|
| Batch D decisions implemented | ✅ |
| Weather surfaces removed | ✅ |
| Residual helper references cleaned | ✅ |
| D-038 ledger updated | ✅ |

### Phase 07: Stabilization and Freeze

| Check | Result |
|---|---|
| Phases 01-06 accepted | ✅ |
| Traceability complete | ✅ (static) |
| Freeze checklist complete | ❌ (runtime gaps) |
| No unresolved P0/P1 blockers | ❌ (Phase 07 blocked) |

## Next Milestones

1. **Operator runtime capture** — Execute Phase 07 validation in Kodi
2. **Update Phase 07 report** — Fill runtime columns, update checklists
3. **Mark Phase 07 completed** — Set README status to completed
4. **Freeze** — Lock all remaining helper bindings