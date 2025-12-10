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
4. Advanced features and integrations (v1.7+)

---

## Version Timeline

```
2025-12       2026-01       2026-02       2026-03
    |-------------|-------------|-------------|
    v1.4.1        v1.5          v1.6          v1.7
    (current)     Multi-Proj    Workflow      Advanced
                  Operations    Automation    Features
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

### v1.5 - Multi-Project Operations
**Target**: 2026-01
**Theme**: Portfolio Management
**Effort**: ~10 days

| Feature | Priority | Status | Effort |
|---------|----------|--------|--------|
| `lib/project-index.sh` | High | Planned | 0.5d |
| `pj-index` command | High | Planned | 0.5d |
| `pj-status` dashboard | High | Planned | 1d |
| `lib/multi-project.sh` | High | Planned | 0.5d |
| `pj-run` bulk ops | High | Planned | 1d |
| `pj-search` global search | Medium | Planned | 1d |
| `tier` management | Medium | Planned | 1d |
| `organize` files | Low | Planned | 2d |
| `branch-sync` command | Medium | Planned | 0.5d |
| `docs-audit` command | Medium | Planned | 0.5d |

**Success Criteria**:
- [ ] Index covers 16+ projects (rpkg, devtools, quarto, research)
- [ ] `pj-status` shows all projects at once
- [ ] `pj-run all git fetch` works across all repos
- [ ] `pj-search` finds code across projects

### v1.6 - Workflow Automation
**Target**: 2026-02
**Theme**: Developer Productivity
**Effort**: ~12 days

| Feature | Priority | Status | Effort |
|---------|----------|--------|--------|
| `session` management | High | Planned | 2d |
| `release-create` workflow | High | Planned | 2d |
| `pr-cycle` automation | High | Planned | 1.5d |
| `plan-status` tracking | Medium | Planned | 1d |
| `health-check` dashboard | Medium | Planned | 1.5d |
| `watch` file watcher | Medium | Planned | 2d |
| `auto-commit` system | Low | Planned | 2d |

**Success Criteria**:
- [ ] Session state persists between Claude conversations
- [ ] `release-create v1.x` handles full release workflow
- [ ] `plan-status v1.5` shows implementation progress
- [ ] Project health score available

### v1.7 - Advanced Features
**Target**: 2026-03
**Theme**: Intelligence & Integration
**Effort**: ~15 days

| Feature | Priority | Status | Effort |
|---------|----------|--------|--------|
| Cloud sync status | Medium | Planned | 3d |
| CI/CD integration | Medium | Planned | 2d |
| Smart templates | Medium | Planned | 2d |
| Context-aware `f` finder | Medium | Planned | 2d |
| Project bookmarks (@r, @test) | Medium | Planned | 1d |
| Quick open `o` command | Low | Planned | 1d |
| Recent files tracking | Low | Planned | 1.5d |
| Environment management | Low | Planned | 2d |

---

## Feature Categories

### A. Project Management (v1.5)
```
┌─────────────────────────────────────────────────────┐
│ pj-index ──► pj-status ──► pj-run ──► pj-search    │
│    │                           │                    │
│    └── project-index.sh ───────┘                    │
│              │                                      │
│              ▼                                      │
│    tier ──► organize                                │
└─────────────────────────────────────────────────────┘
```

### B. Workflow Automation (v1.6)
```
┌─────────────────────────────────────────────────────┐
│ session ◄──────────────────────────► plan-status   │
│    │                                      │         │
│    ▼                                      ▼         │
│ release-create ──► pr-cycle ──► health-check       │
│                                                     │
│ watch ──► auto-commit                               │
└─────────────────────────────────────────────────────┘
```

### C. Navigation & Productivity (v1.7)
```
┌─────────────────────────────────────────────────────┐
│ f (finder) ◄── project bookmarks (@r, @test)       │
│    │                                                │
│    ▼                                                │
│ o (open) ◄── recent files                          │
│    │                                                │
│    ▼                                                │
│ env management ◄── tool versions                   │
└─────────────────────────────────────────────────────┘
```

---

## Progress Tracking

### Overall Progress

```
v1.0-1.4  ████████████████████  100% Complete
v1.5      ░░░░░░░░░░░░░░░░░░░░    0% Planned
v1.6      ░░░░░░░░░░░░░░░░░░░░    0% Planned
v1.7      ░░░░░░░░░░░░░░░░░░░░    0% Planned
─────────────────────────────────────────────
Overall   █████░░░░░░░░░░░░░░░   25% Complete
```

### v1.5 Detailed Progress

```
Feature                    Status      Progress
───────────────────────────────────────────────
lib/project-index.sh       Planned     ░░░░░░░░░░   0%
pj-index command           Planned     ░░░░░░░░░░   0%
pj-status command          Planned     ░░░░░░░░░░   0%
lib/multi-project.sh       Planned     ░░░░░░░░░░   0%
pj-run command             Planned     ░░░░░░░░░░   0%
pj-search command          Planned     ░░░░░░░░░░   0%
tier command               Planned     ░░░░░░░░░░   0%
organize command           Planned     ░░░░░░░░░░   0%
branch-sync command        Planned     ░░░░░░░░░░   0%
docs-audit command         Planned     ░░░░░░░░░░   0%
───────────────────────────────────────────────
v1.5 Total                             ░░░░░░░░░░   0%
```

---

## Dependencies

### External Tools
| Tool | Required For | Status |
|------|--------------|--------|
| zsh | All | ✅ Installed |
| git | All | ✅ Installed |
| fd | File finding | ✅ Installed |
| ripgrep | Searching | ✅ Installed |
| fzf | Selection UI | ✅ Installed |
| gh | GitHub CLI | ✅ Installed |
| jq | JSON parsing | ✅ Installed |
| bat | Previews | ✅ Installed |
| entr | File watching | ⚠️ Optional |

### Internal Dependencies
```
v1.5 Features:
  pj-status ──depends──► project-index.sh
  pj-run ──depends──► project-index.sh, multi-project.sh
  pj-search ──depends──► project-index.sh
  tier ──depends──► project-index.sh

v1.6 Features:
  release-create ──depends──► pr-cycle
  plan-status ──depends──► ROADMAP.md format
  session ──depends──► cache system
```

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Scope creep | Medium | Stick to planned features per version |
| Session state complexity | High | Start simple (JSON file), iterate |
| Cloud sync API changes | Medium | Abstract sync checking |
| Performance with many projects | Low | Index caching, lazy loading |

---

## Contributing

### How to Contribute
1. Check `plans/` for current planning documents
2. Pick a feature from the roadmap
3. Create feature branch from `dev`
4. Implement with tests
5. Create PR targeting `dev`

### Planning Documents
- `plans/ROADMAP.md` - This file (overall roadmap)
- `plans/v1.5-multi-project-operations.md` - v1.5 details
- `plans/file-project-management-optimization.md` - Original brainstorm

---

## Changelog

### 2025-12-09
- Created ROADMAP.md
- Completed v1.4.1 release
- Added v1.5, v1.6, v1.7 planning
- Added workflow automation features to roadmap

---

**Tracking Command**: `plan-status` (coming in v1.6)
**View Online**: [GitHub Repository](https://github.com/Data-Wise/zsh-claude-workflow)
