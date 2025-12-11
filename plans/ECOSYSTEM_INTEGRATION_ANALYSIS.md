# Data-Wise Ecosystem Integration Analysis

> **Analysis Date:** 2025-12-10
> **Scope:** claude-r-dev, zsh-claude-workflow, data-wise
> **Purpose:** Identify overlaps, redundancies, and integration opportunities

---

## 📊 Project Comparison Matrix

| Aspect | claude-r-dev | zsh-claude-workflow | data-wise |
|--------|-------------|---------------------|-----------|
| **Purpose** | R package Claude Code config | Shell automation & workflows | Project management hub |
| **Scope** | R packages only | Multi-type (R, Quarto, research, tools) | All 20 Data-Wise repos |
| **Interface** | Claude Code slash commands | Shell commands (CLI) | Planning documents (Markdown) |
| **Commands** | 4 slash commands | 15 shell commands | 0 (documentation only) |
| **Libraries** | Profiles (2) | 8 shell libraries | 0 |
| **Workflows** | Embedded in slash commands | YAML-based (rpkg/, quarto/) | 0 |
| **Documentation** | MkDocs (GitHub Pages) | MkDocs (GitHub Pages) | README + planning docs |
| **Install Method** | `install.sh` → .claude/ | PATH export | Clone only |
| **Target Users** | R package developers | CLI power users | Project managers |
| **Version** | v1.0 | v1.4.1 | Initial |
| **Lines of Code** | ~341 (base CLAUDE.md) | ~1,160 (CLAUDE.md) | ~200 (planning docs) |

---

## 🔄 Overlap Analysis

### HIGH OVERLAP (Redundant - Needs Resolution)

#### 1. R Package Initialization
- **claude-r-dev**: `/project:init` - Interactive wizard in Claude Code
- **zsh-claude-workflow**: `rpkg-setup` - Shell command with profiles
- **Overlap**: 90%
- **Resolution**: Make `rpkg-setup` call `claude-r-dev/install.sh`

#### 2. R Package Workflows
- **claude-r-dev**: `/project:pre-commit-check`, `/project:fix-bug`
- **zsh-claude-workflow**: `workflows/rpkg/dev.yml`, `workflows/rpkg/test.yml`
- **Overlap**: 70%
- **Resolution**: claude-r-dev handles *inside* Claude, zsh handles *shell automation*

#### 3. Documentation Sites
- **claude-r-dev**: MkDocs site at data-wise.github.io/claude-r-dev/
- **zsh-claude-workflow**: MkDocs site at data-wise.github.io/zsh-claude-workflow/
- **Overlap**: 100% (same tech stack)
- **Resolution**: Share `docs-standards/mkdocs-base.yml` for consistency

### MEDIUM OVERLAP (Complementary - Coordinate)

#### 4. Project Detection
- **claude-r-dev**: Checks DESCRIPTION file only
- **zsh-claude-workflow**: `lib/project-detector.sh` - Detects 6+ types
- **Overlap**: 30%
- **Resolution**: zsh-claude-workflow is broader, keep both

#### 5. Claude Integration
- **claude-r-dev**: Profiles installed to `.claude/` per package
- **zsh-claude-workflow**: `proj-claude` command, skill management
- **Overlap**: 40%
- **Resolution**: Bridge via `lib/claude-r-dev-bridge.sh` (already exists!)

### LOW OVERLAP (Distinct - Keep Separate)

#### 6. Project Management
- **data-wise**: Central tracking for 20 repos
- **zsh-claude-workflow**: Proposed `pj-sync` to update data-wise
- **Overlap**: 0% (complementary)

#### 7. Multi-Project Operations
- **zsh-claude-workflow**: Proposed `ecosystem` command
- **claude-r-dev**: Single-package focus
- **Overlap**: 0%

---

## 🎯 Architecture Recommendation

### Current State (Overlapping Circles)

```
┌─────────────────┐
│  claude-r-dev   │
│  (R pkg focus)  │
└────────┬────────┘
         │
    ┌────┴────────────────────┐
    │ zsh-claude-workflow     │
    │ (Multi-type automation) │
    └─────────┬───────────────┘
              │
       ┌──────┴──────┐
       │  data-wise  │
       │ (Tracking)  │
       └─────────────┘
```

### Proposed State (Layered Stack)

```
┌──────────────────────────────────────────────┐
│            data-wise (Layer 4)               │
│      Project Management & Tracking           │
│  • ACTIVE_PROJECTS.md                        │
│  • REPOSITORY_INVENTORY.md                   │
│  • AI_PARITY_TRACKER.md                      │
└─────────────────┬────────────────────────────┘
                  │ (synced by pj-sync)
┌─────────────────▼────────────────────────────┐
│      zsh-claude-workflow (Layer 3)           │
│      Shell Automation & Orchestration        │
│  • Project detection (all types)             │
│  • Workflow dispatcher                       │
│  • Multi-project operations                  │
│  • CLI commands (15)                         │
└──────┬───────────────────────┬───────────────┘
       │                       │
       │ (calls)               │ (integrates)
       │                       │
┌──────▼──────────┐   ┌────────▼──────────────┐
│  claude-r-dev   │   │   docs-standards      │
│   (Layer 2)     │   │     (Layer 1)         │
│                 │   │                       │
│ • R pkg config  │   │ • MkDocs templates    │
│ • Slash commands│   │ • altdoc/Quarto       │
│ • Profiles      │   │ • Theme standards     │
└─────────────────┘   └───────────────────────┘
```

**Key Principle:** Each layer has a distinct role:
1. **Layer 1 (docs-standards)**: Templates & standards
2. **Layer 2 (claude-r-dev)**: R package-specific Claude config
3. **Layer 3 (zsh-claude-workflow)**: Universal shell automation
4. **Layer 4 (data-wise)**: Ecosystem tracking

---

## 🔧 Integration Strategy

### 1. Update zsh-claude-workflow

**Create bridge to claude-r-dev:**

```bash
# In lib/claude-r-dev-bridge.sh (ALREADY EXISTS - enhance it)
install_claude_r_dev_profile() {
    local pkg_dir="$1"
    local profiles="${2:-base}"

    # Call claude-r-dev installer
    "${CLAUDE_R_DEV_PATH}/scripts/install.sh" \
        --profiles "$profiles" \
        --target "$pkg_dir"
}
```

**Update `rpkg-setup` command:**

```bash
# New option: --claude-profile
rpkg-setup mypackage --type statistical --claude-profile base,statistical-methods

# Internally:
# 1. Create package structure
# 2. Call claude-r-dev/install.sh
# 3. Set up workflows
# 4. Activate skills
```

### 2. Update claude-r-dev

**Add shell integration:**

Create `scripts/zsh-integration.sh`:
```bash
# Export functions for zsh-claude-workflow to call
export_profile_list() {
    ls profiles/ | grep -v base
}

export_command_list() {
    find profiles/base/commands -name "*.md" | basename -s .md
}
```

### 3. Update data-wise

**Add automation hooks:**

New files in `planning/`:
- `planning/automation/sync-status.sh` - Called by `pj-sync`
- `planning/automation/update-inventory.sh` - Update REPOSITORY_INVENTORY.md

---

## 🚀 Parallel Development Plan

### Agent 1: zsh-claude-workflow (Primary Focus)

**Mission:** Implement v1.5 multi-project operations + docs integration

**Tasks:**
1. ✅ Create `lib/docs-manager.sh`
2. ✅ Create `commands/docs-setup` (altdoc integration)
3. ✅ Create `commands/altdoc` (R package docs wrapper)
4. ✅ Create `lib/ecosystem-manager.sh`
5. ✅ Create `commands/ecosystem` (multi-repo ops)
6. ✅ Enhance `lib/claude-r-dev-bridge.sh`
7. ✅ Update `rpkg-setup` to use claude-r-dev
8. ✅ Test with all 20 repos

**Files to Create:**
- `lib/docs-manager.sh` (~200 lines)
- `lib/ecosystem-manager.sh` (~300 lines)
- `commands/docs-setup` (~150 lines)
- `commands/altdoc` (~100 lines)
- `commands/ecosystem` (~200 lines)

**Files to Modify:**
- `lib/claude-r-dev-bridge.sh` (+100 lines)
- `commands/rpkg-setup` (+50 lines)
- `CLAUDE.md` (document integration)

**Estimated Effort:** 6-8 hours

---

### Agent 2: data-wise (Secondary Focus)

**Mission:** Set up automation hooks and expand planning infrastructure

**Tasks:**
1. ✅ Create `planning/automation/` directory
2. ✅ Create `sync-status.sh` - Update ACTIVE_PROJECTS.md
3. ✅ Create `update-inventory.sh` - Update REPOSITORY_INVENTORY.md
4. ✅ Create `update-parity.sh` - Update AI_PARITY_TRACKER.md
5. ✅ Add `planning/ECOSYSTEM_ROADMAP.md`
6. ✅ Add `planning/QUARTERLY_GOALS.md`
7. ✅ Add `planning/CRAN_SUBMISSION_TRACKER.md`
8. ✅ Update README.md with automation info

**Files to Create:**
- `planning/automation/sync-status.sh` (~100 lines)
- `planning/automation/update-inventory.sh` (~150 lines)
- `planning/automation/update-parity.sh` (~100 lines)
- `planning/ECOSYSTEM_ROADMAP.md` (~200 lines)
- `planning/QUARTERLY_GOALS.md` (~150 lines)
- `planning/CRAN_SUBMISSION_TRACKER.md` (~100 lines)

**Files to Modify:**
- `README.md` (+30 lines)
- `.claude/CLAUDE.md` (add automation context)

**Estimated Effort:** 3-4 hours

---

### Agent 3: claude-r-dev (Tertiary Focus)

**Mission:** Add zsh integration hooks and enhance documentation

**Tasks:**
1. ✅ Create `scripts/zsh-integration.sh`
2. ✅ Add `--install-path` option to `install.sh`
3. ✅ Create `docs_mkdocs/integration.md` (zsh-claude-workflow)
4. ✅ Update README.md with zsh integration
5. ✅ Add `profiles/zsh-aware/` (optional profile)
6. ✅ Test integration with zsh-claude-workflow

**Files to Create:**
- `scripts/zsh-integration.sh` (~80 lines)
- `docs_mkdocs/integration.md` (~100 lines)
- `profiles/zsh-aware/CLAUDE.md` (~50 lines)

**Files to Modify:**
- `scripts/install.sh` (+30 lines)
- `README.md` (+20 lines)

**Estimated Effort:** 2-3 hours

---

## 📋 Parallel Execution Strategy

### Phase 1: Foundation (Parallel)

**All agents start simultaneously:**

```bash
# Agent 1 (zsh-claude-workflow)
- Create lib/docs-manager.sh
- Create lib/ecosystem-manager.sh
- Create config/ecosystem.conf

# Agent 2 (data-wise)
- Create planning/automation/ directory
- Create sync-status.sh
- Create update-inventory.sh

# Agent 3 (claude-r-dev)
- Create scripts/zsh-integration.sh
- Update install.sh
```

**Duration:** 1-2 hours (parallel)

---

### Phase 2: Implementation (Parallel)

**All agents continue:**

```bash
# Agent 1 (zsh-claude-workflow)
- Create commands/docs-setup
- Create commands/altdoc
- Create commands/ecosystem

# Agent 2 (data-wise)
- Create ECOSYSTEM_ROADMAP.md
- Create QUARTERLY_GOALS.md
- Create CRAN_SUBMISSION_TRACKER.md

# Agent 3 (claude-r-dev)
- Create integration documentation
- Test with zsh-claude-workflow
```

**Duration:** 2-3 hours (parallel)

---

### Phase 3: Integration (Sequential)

**Agent 1 leads, others support:**

```bash
# Agent 1 (zsh-claude-workflow)
- Enhance lib/claude-r-dev-bridge.sh
- Update commands/rpkg-setup
- Test complete integration

# Agent 2 (data-wise)
- Test automation hooks
- Verify sync-status works

# Agent 3 (claude-r-dev)
- Verify installer works from zsh
- Update documentation
```

**Duration:** 1-2 hours (mostly sequential)

---

### Phase 4: Testing & Documentation (Parallel)

**All agents test and document:**

```bash
# Agent 1 (zsh-claude-workflow)
- Update CLAUDE.md
- Update docs site
- Create examples

# Agent 2 (data-wise)
- Update README.md
- Test all automation scripts

# Agent 3 (claude-r-dev)
- Update docs with integration guide
- Create tutorial
```

**Duration:** 1-2 hours (parallel)

---

## 📊 Total Effort Estimate

| Agent | Solo Effort | Parallel Effort | Efficiency Gain |
|-------|-------------|-----------------|-----------------|
| Agent 1 (zsh) | 6-8 hours | 3-4 hours | 50% |
| Agent 2 (data-wise) | 3-4 hours | 2-3 hours | 33% |
| Agent 3 (claude-r-dev) | 2-3 hours | 1-2 hours | 33% |
| **Total** | **11-15 hours** | **4-6 hours** | **60% faster** |

**Key Benefits:**
- No blocking dependencies in Phase 1-2
- Agent 1 can integrate results from Agents 2-3 in Phase 3
- All agents can document simultaneously in Phase 4

---

## ✅ Success Criteria

### Integration Success

- [ ] `rpkg-setup` successfully calls `claude-r-dev/install.sh`
- [ ] `docs-setup --type altdoc` works for R packages
- [ ] `ecosystem check-r` runs across all 6 R packages
- [ ] `pj-sync status` updates data-wise/ACTIVE_PROJECTS.md
- [ ] No duplicate functionality between projects

### Documentation Success

- [ ] All 3 projects have updated CLAUDE.md
- [ ] Integration guide exists in claude-r-dev docs
- [ ] zsh-claude-workflow docs show claude-r-dev integration
- [ ] data-wise README shows automation

### Testing Success

- [ ] End-to-end test: `rpkg-setup` → `docs-setup` → `pj-sync`
- [ ] All R packages can use integrated workflow
- [ ] data-wise tracking stays current

---

## 🎯 Immediate Action Items

### Before Starting Parallel Development

1. **Commit current work** in zsh-claude-workflow
2. **Create feature branches** in all 3 repos:
   - `zsh-claude-workflow/feature/ecosystem-integration`
   - `data-wise/feature/automation-hooks`
   - `claude-r-dev/feature/zsh-integration`
3. **Set up communication**: Shared notes document for agents
4. **Define interfaces**: Exact function signatures for bridge

### Launch Command

```bash
# Agent 1: zsh-claude-workflow
cd ~/projects/dev-tools/zsh-claude-workflow
git checkout -b feature/ecosystem-integration

# Agent 2: data-wise
cd ~/projects/dev-tools/data-wise
git checkout -b feature/automation-hooks

# Agent 3: claude-r-dev
cd ~/projects/dev-tools/claude-r-dev
git checkout -b feature/zsh-integration
```

---

## 📝 Notes

- **Redundancy Resolution**: Make zsh-claude-workflow the *orchestrator*, claude-r-dev the *R specialist*
- **Separation of Concerns**: Shell automation (zsh) vs Claude configuration (claude-r-dev)
- **Leverage Existing**: `lib/claude-r-dev-bridge.sh` already exists!
- **Documentation**: Keep MkDocs sites distinct but cross-linked

---

**Ready for parallel execution!** 🚀
