# zsh-claude-workflow Roadmap

**Last Updated**: 2025-12-09
**Current Version**: v1.4.1
**Status**: Active Development

---

## Project Vision

Transform zsh-claude-workflow from a context manager into a comprehensive **developer productivity system** that handles:
1. Project detection and context gathering (v1.0-1.4) ✅
2. Multi-project operations and portfolio management (v1.5)
3. Workflow automation and session continuity (v1.6)
4. Advanced features (v1.7 - optional/deferred)

---

## Version Timeline

```
2025-12       2026-01       2026-02       Future
    |-------------|-------------|-------------|
    v1.4.1        v1.5          v1.6          v1.7
    (current)     Multi-Proj    Workflow      Optional
                  (6 features)  (4 features)  (deferred)
```

---

## Release History

| Version | Date | Theme | Key Features |
|---------|------|-------|--------------|
| v1.0 | 2025-12-07 | Foundation | Project detection, context gathering, templates |
| v1.1 | 2025-12-07 | Documentation | MkDocs site, GitHub Pages |
| v1.2 | 2025-12-07 | Dev Workflow | Branch strategy, cleanup |
| v1.3 | 2025-12-07 | Integration | Workflows, skills, CLI aliases |
| v1.4 | 2025-12-09 | Commands | 34 Claude slash commands |
| v1.4.1 | 2025-12-09 | Examples | Comprehensive documentation examples |

---

## Upcoming Releases

### v1.5 - Multi-Project Operations (Lean Scope)
**Target**: 2026-01
**Theme**: Portfolio Management
**Effort**: ~6 days

| Feature | Priority | Description | Effort |
|---------|----------|-------------|--------|
| `pj-index` | High | Project indexing system | 1d |
| `pj-status` | High | Dashboard: all projects at once | 1.5d |
| `pj-run` | High | Bulk operations across projects | 1.5d |
| `pj-search` | Medium | Global code search | 1d |
| `branch-sync` | Medium | Sync dev↔main branches | 0.5d |
| `pj` | Medium | Quick jump to project | 0.5d |

**Deferred**: tier, organize, docs-audit (low value)

**Success Criteria**:
- [ ] Index covers 16+ projects (rpkg, devtools, quarto)
- [ ] `pj-status` shows all projects with git status
- [ ] `pj-run all git fetch` works across all repos

---

### v1.6 - Workflow Automation (Lean Scope)
**Target**: 2026-02
**Theme**: Developer Productivity
**Effort**: ~5.5 days

| Feature | Priority | Description | Effort |
|---------|----------|-------------|--------|
| `session` | High | Save/restore session state | 2d |
| `pr-cycle` | High | PR creation to merge automation | 1.5d |
| `release-create` | High | Full release workflow | 2d |
| `plan-status` | Medium | Progress tracking | ✅ Done |

**Deferred**: watch, auto-commit, health-check (low value or risky)

**Success Criteria**:
- [ ] Session state persists for Claude continuity
- [ ] `release-create v1.x` handles full release workflow
- [x] `plan-status` shows implementation progress

---

### v1.7 - Advanced Features (Optional/Deferred)
**Target**: Future (if needed)
**Status**: Backlog - implement only if clear need arises

| Feature | Notes |
|---------|-------|
| Cloud sync status | Niche use case |
| CI/CD integration | Could be useful for quality |
| Smart templates | Context-aware file creation |
| Project bookmarks | z plugin already does this |
| Recent files | Editors track this |
| Environment management | asdf/mise already exist |

**Decision**: Review after v1.6. Only implement features with demonstrated need.

---

## Progress Tracking

### Overall Progress

```
v1.0-1.4  ████████████████████  100% Complete
v1.5      ░░░░░░░░░░░░░░░░░░░░    0% (6 features)
v1.6      █████░░░░░░░░░░░░░░░   25% (1/4 features)
v1.7      ░░░░░░░░░░░░░░░░░░░░    -  Optional
```

### Use `plan-status` Command

```bash
plan-status          # Overall roadmap
plan-status v1.5     # v1.5 detailed progress
plan-status v1.6     # v1.6 detailed progress
plan-status --gantt  # Visual timeline

# Update progress
plan-status --update v1.5 pj-index in_progress
plan-status --update v1.5 pj-index complete
```

---

## Feature Flow

### v1.5: Multi-Project Operations
```
pj-index ──► pj-status
    │
    ├──► pj-run
    │
    ├──► pj-search
    │
    └──► pj (jump)

branch-sync (standalone)
```

### v1.6: Workflow Automation
```
session ──► (Claude continuity)

pr-cycle ──► release-create

plan-status ✓ (done)
```

---

## Dependencies

### External Tools (all installed)
- zsh, git, fd, ripgrep, fzf, gh, jq, bat, yq

### Internal Dependencies
```
v1.5:
  pj-status ──► pj-index
  pj-run ──► pj-index
  pj-search ──► pj-index
  pj ──► pj-index

v1.6:
  release-create ──► pr-cycle
```

---

## Scope Philosophy

**Keep it lean.** Only implement features that:
1. Solve real, frequent friction points
2. Can't be done easily with existing tools
3. Provide clear time savings

**Avoid:**
- Features that duplicate existing tools (z, editors, asdf)
- Risky automation (auto-commit)
- Nice-to-haves without clear use cases

---

## Next Steps

1. **Start v1.5**: Implement `pj-index` first (foundation)
2. **Track Progress**: Use `plan-status --update` as you work
3. **Review v1.7**: After v1.6, decide if any features are needed

---

## Planning Documents

| File | Purpose |
|------|---------|
| `plans/ROADMAP.md` | This file - overall roadmap |
| `plans/v1.5-multi-project-operations.md` | v1.5 detailed spec |
| `plans/tracking/v1.5-progress.yml` | v1.5 progress data |
| `plans/tracking/v1.6-progress.yml` | v1.6 progress data |
| `plans/file-project-management-optimization.md` | Original brainstorm |

---

## Changelog

### 2025-12-09
- Created ROADMAP.md
- Added plan-status command
- **Revised scope**: Reduced v1.5 from 10→6, v1.6 from 7→4 features
- Marked v1.7 as optional/deferred
- Completed v1.4.1 release

---

**Tracking**: `plan-status`
**Repository**: [GitHub](https://github.com/Data-Wise/zsh-claude-workflow)
