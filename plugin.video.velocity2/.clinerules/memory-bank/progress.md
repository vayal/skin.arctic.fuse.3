# Progress — Velocity Plugin

## What Works

### Architecture
- Thin Client / Smart Daemon pattern implemented
- Daemon handles all DB writes, Client only reads
- Local SQLite enables zero-latency UI rendering
- Generator-driven skin integration functional

### Roadmap Structure
- 5-phase roadmap defined in `doc/roadmap/`
- Phase files follow `PHASE_TEMPLATE.md`
- `PHASE_ARTIFACT_MAP.md` tracks ownership
- `ROADMAP_MASTER.md` provides program control

### Decision Framework
- D-003: View mode locks documented
- D-015: List contracts and schema defined
- D-021: Context menu policy documented
- D-038: Legacy properties ledger structure ready

### Generator Discipline
- Source-first approach enforced
- Regenerate and verify workflow established
- Never edit `1080i/` directly rule in place

## What's Left to Build

### Phase 0 — Historic implementation audit
- [ ] Complete legacy-to-consolidated mapping
- [ ] Cross-check D-item coverage placement
- [ ] Confirm artifact ownership map
- [ ] Verify phase files exist for phase-00 through phase-05

### Phase 1 — Contract and IA baseline
- [ ] Freeze IA model (hubs/provider roster/genres)
- [ ] Freeze D-003 active surface decisions
- [ ] Freeze D-015 contract catalog and schema rules
- [ ] Freeze cross-cutting UX guarantees
- [ ] Record open deltas for Phase 2 and Phase 3

### Phase 2 — List implementation alignment
- [ ] Refresh contract alignment matrix
- [ ] Resolve Home row URL parity and generator source parity
- [ ] Resolve paging behavior (cap-10, next item, header/full-list, 40/page)
- [ ] Resolve row rendering policy (image-only cards)
- [ ] Resolve empty-state behavior consistency
- [ ] Resolve genre/search route policy
- [ ] Document accepted deviations from D-015

### Phase 3 — Non-list surfaces implementation
- [ ] Freeze non-list target policy for details/context/OSD/search/removals
- [ ] Resolve D-021 context menu keep/remove decisions
- [ ] Resolve OSD windows policy for 1140/1141/1143
- [ ] Resolve search chrome tab/alias policy
- [ ] Resolve home submenu + shortcut editor policy
- [ ] Resolve NextAired home placement policy
- [ ] Convert inventory undecided items to explicit decisions

### Phase 4 — Freeze and runtime verification
- [ ] Validate browse-to-play journey
- [ ] Validate search-to-play journey
- [ ] Validate info-and-related journey
- [ ] Validate D-015 runtime pagination/empty-state behavior
- [ ] Validate D-003/D-021/D-038 runtime policy conformance
- [ ] Run full operator checklist and freeze matrix
- [ ] Record freeze decision with blocker list

### Phase 5 — Debt cleanup and policy closure
- [ ] Baseline grep audit for helper symbols
- [ ] Remove/replace undeclared helper symbols
- [ ] Reconcile remaining helper hits into D-038
- [ ] Decide and implement PVR 1107 policy
- [ ] Verify PVR behavior under with/without addon/channels matrix
- [ ] Close deferred non-list policy items from Phase 3

## Current Status

| Phase | Status | Blockers |
|-------|--------|----------|
| 0 | planned | Actionable audit checklist defined; mapping/sign-off pending |
| 1 | planned | Baseline lock checklist defined; acceptance pending |
| 2 | planned | List alignment execution plan defined; closure pending |
| 3 | planned | Non-list execution plan defined; decisions pending |
| 4 | blocked | Runtime evidence pending (freeze gate) |
| 5 | planned | Debt closure plan defined; depends on freeze output |

## Known Issues

- Phase 4 blocked until Kodi runtime evidence exists
- Static audits can mask runtime focus and navigation failures
- Helper replacement can break UX when dependencies are implicit
- PVR policy needs explicit product acceptance

## Evolution of Decisions

### 2026-04-24
- Roadmap phases consolidated into `doc/roadmap/`
- Phase files follow `PHASE_TEMPLATE.md` structure
- All roadmap detail now phase-owned (no standalone docs)
- Memory bank core files created with roadmap context

### Roadmap Governance Updates
- `doc/roadmap/` is phase-owned for implementation details
- `PHASE_TEMPLATE.md` defines required section structure
- `PHASE_ARTIFACT_MAP.md` defines ownership of consolidated information
- Any new roadmap detail must be added to owning phase document
