# Parallel Agent Development Plan

> **Execution Date:** 2025-12-10
> **Total Agents:** 3 (running simultaneously)
> **Estimated Time:** 4-6 hours (vs 11-15 hours sequential)
> **Efficiency Gain:** 60%

---

## 🎯 Mission Overview

Integrate the Data-Wise ecosystem by enhancing 3 projects simultaneously:
1. **zsh-claude-workflow** - Add multi-project operations + docs integration
2. **data-wise** - Add automation hooks for project tracking
3. **claude-r-dev** - Add zsh integration for seamless workflows

---

## 🤖 Agent Assignments

### Agent 1: "Workflow Architect"
- **Project:** zsh-claude-workflow
- **Branch:** `feature/ecosystem-integration`
- **Role:** Primary orchestrator
- **Focus:** Multi-project operations, documentation setup, ecosystem management
- **Priority:** HIGH

### Agent 2: "Project Tracker"
- **Project:** data-wise
- **Branch:** `feature/automation-hooks`
- **Role:** Automation & tracking
- **Focus:** Planning infrastructure, sync scripts, roadmap tracking
- **Priority:** MEDIUM

### Agent 3: "R Specialist"
- **Project:** claude-r-dev
- **Branch:** `feature/zsh-integration`
- **Role:** R package integration
- **Focus:** Shell hooks, integration docs, installer enhancements
- **Priority:** MEDIUM

---

## 📋 Phase 1: Foundation (PARALLEL - 1-2 hours)

### Agent 1 Tasks (zsh-claude-workflow)

```bash
cd ~/projects/dev-tools/zsh-claude-workflow
git checkout -b feature/ecosystem-integration
```

**Create Files:**

1. **`lib/docs-manager.sh`** (~200 lines)
   ```bash
   # Functions:
   - setup_altdoc()          # Initialize altdoc for R package
   - setup_mkdocs()          # Initialize MkDocs for tools
   - download_docs_standards() # Fetch from GitHub
   - validate_docs_setup()   # Check configuration
   - update_docs_theme()     # Update from docs-standards
   ```

2. **`lib/ecosystem-manager.sh`** (~300 lines)
   ```bash
   # Functions:
   - find_all_datawise_repos()   # Scan ~/projects/
   - get_repo_layer()            # Standards/IDE/AI/R/Apps
   - get_repo_status()           # active/archived
   - check_cran_status()         # Query CRAN
   - get_package_version()       # From DESCRIPTION
   - update_active_projects()    # Sync to data-wise
   - update_repository_inventory() # Sync inventory
   ```

3. **`config/ecosystem.conf`** (~50 lines)
   ```bash
   # Configuration:
   DATAWISE_REPO_ROOT=~/projects
   DOCS_STANDARDS_REPO=Data-Wise/docs-standards
   PROJECT_MGMT_REPO=Data-Wise/data-wise
   CLAUDE_R_DEV_PATH=~/projects/dev-tools/claude-r-dev
   ```

**Test:** Create files, verify syntax

---

### Agent 2 Tasks (data-wise)

```bash
cd ~/projects/dev-tools/data-wise
git checkout -b feature/automation-hooks
```

**Create Files:**

1. **`planning/automation/sync-status.sh`** (~100 lines)
   ```bash
   #!/usr/bin/env bash
   # Called by: zsh-claude-workflow/commands/pj-sync status
   # Updates: planning/ACTIVE_PROJECTS.md
   # Input: JSON from zsh-claude-workflow
   ```

2. **`planning/automation/update-inventory.sh`** (~150 lines)
   ```bash
   #!/usr/bin/env bash
   # Called by: zsh-claude-workflow/commands/pj-sync inventory
   # Updates: planning/REPOSITORY_INVENTORY.md
   # Scans: All 20 repos
   ```

3. **`planning/automation/update-parity.sh`** (~100 lines)
   ```bash
   #!/usr/bin/env bash
   # Called by: zsh-claude-workflow/commands/pj-sync parity
   # Updates: planning/AI_PARITY_TRACKER.md
   # Compares: claude-r-dev vs r-package-dev-gemini
   ```

**Test:** Create files, verify syntax

---

### Agent 3 Tasks (claude-r-dev)

```bash
cd ~/projects/dev-tools/claude-r-dev
git checkout -b feature/zsh-integration
```

**Create Files:**

1. **`scripts/zsh-integration.sh`** (~80 lines)
   ```bash
   #!/usr/bin/env bash
   # Export functions for zsh-claude-workflow

   export_profile_list() {
       # List available profiles
   }

   export_command_list() {
       # List slash commands
   }

   get_profile_info() {
       # Get profile metadata
   }
   ```

**Modify Files:**

2. **`scripts/install.sh`** (+30 lines)
   ```bash
   # Add option: --called-from-zsh
   # Skip interactive prompts when called from automation
   # Return JSON status on completion
   ```

**Test:** Verify install.sh works with new option

---

## 📋 Phase 2: Implementation (PARALLEL - 2-3 hours)

### Agent 1 Tasks (zsh-claude-workflow)

**Create Commands:**

1. **`commands/docs-setup`** (~150 lines)
   ```bash
   #!/usr/bin/env zsh
   # Usage: docs-setup [--type altdoc|mkdocs] [--dir .]

   main() {
       # Auto-detect project type
       # For R packages: call altdoc setup
       # For tools: call mkdocs setup
       # Download from docs-standards
       # Replace placeholders
   }
   ```

2. **`commands/altdoc`** (~100 lines)
   ```bash
   #!/usr/bin/env zsh
   # Usage: altdoc [setup|render|preview|deploy|sync-theme]

   # Quick wrapper for altdoc R functions
   # Ensures docs-standards compliance
   ```

3. **`commands/ecosystem`** (~200 lines)
   ```bash
   #!/usr/bin/env zsh
   # Usage: ecosystem [status|check-r|docs-build|cran-status]

   main() {
       case "$1" in
           status)       show_ecosystem_status ;;
           check-r)      run_r_cmd_check_all ;;
           docs-build)   build_all_docs ;;
           cran-status)  check_all_cran ;;
       esac
   }
   ```

**Test:** Run each command with sample data

---

### Agent 2 Tasks (data-wise)

**Create Planning Docs:**

1. **`planning/ECOSYSTEM_ROADMAP.md`** (~200 lines)
   ```markdown
   # Data-Wise Ecosystem Roadmap

   ## Vision (2025-2027)

   ### 2025 Q1-Q4
   - Standards layer expansion
   - MediationVerse CRAN releases
   - AI engine parity

   ### 2026
   - Community adoption
   - Enterprise features

   ### 2027
   - Industry standard for causal inference in R
   ```

2. **`planning/QUARTERLY_GOALS.md`** (~150 lines)
   ```markdown
   # Q1 2025 Goals

   ## Standards Layer
   - [ ] altdoc migration for all R packages

   ## R Packages
   - [ ] medfit S7 CRAN submission
   - [ ] probmed v1.0 release
   ```

3. **`planning/CRAN_SUBMISSION_TRACKER.md`** (~100 lines)
   ```markdown
   # CRAN Submission Tracker

   | Package | Version | Status | Submitted | Notes |
   |---------|---------|--------|-----------|-------|
   | medfit  | 0.1.0   | Planning | - | Foundation |
   | probmed | 1.0.0   | Ready | - | Minor fixes |
   ```

**Test:** Verify markdown renders correctly

---

### Agent 3 Tasks (claude-r-dev)

**Create Documentation:**

1. **`docs_mkdocs/integration.md`** (~100 lines)
   ```markdown
   # Integration with zsh-claude-workflow

   ## Overview

   claude-r-dev integrates seamlessly with zsh-claude-workflow
   for shell-based automation.

   ## Usage

   ```bash
   # From zsh-claude-workflow
   rpkg-setup mypackage --claude-profile base,statistical-methods
   ```

   ## How It Works

   1. zsh-claude-workflow calls install.sh
   2. Profiles installed to .claude/
   3. Ready for Claude Code
   ```

2. **`profiles/zsh-aware/CLAUDE.md`** (~50 lines)
   ```markdown
   # zsh-aware Profile

   Additional context when using claude-r-dev via zsh-claude-workflow.

   ## Available Shell Commands

   - rpkg-setup - Initialize package with profiles
   - docs-setup - Set up documentation
   - workflow-run - Execute workflows
   ```

**Update Files:**

3. **`README.md`** (+20 lines)
   ```markdown
   ## Integration with zsh-claude-workflow

   For shell automation and multi-project workflows, integrate with
   [zsh-claude-workflow](https://github.com/Data-Wise/zsh-claude-workflow).
   ```

**Test:** Build docs site, verify integration page

---

## 📋 Phase 3: Integration (SEQUENTIAL - 1-2 hours)

### Agent 1 Leads (zsh-claude-workflow)

**Enhance Integration:**

1. **`lib/claude-r-dev-bridge.sh`** (+100 lines)
   ```bash
   # Enhance existing file

   install_claude_r_dev_profile() {
       local pkg_dir="$1"
       local profiles="${2:-base}"

       # Call claude-r-dev/scripts/install.sh
       "${CLAUDE_R_DEV_PATH}/scripts/install.sh" \
           --profiles "$profiles" \
           --target "$pkg_dir" \
           --called-from-zsh \
           --quiet

       # Parse JSON response
       # Return status
   }

   list_available_profiles() {
       source "${CLAUDE_R_DEV_PATH}/scripts/zsh-integration.sh"
       export_profile_list
   }
   ```

2. **`commands/rpkg-setup`** (+50 lines)
   ```bash
   # Add option: --claude-profile

   if [[ -n "$claude_profile" ]]; then
       print_info "Installing claude-r-dev profiles: $claude_profile"
       install_claude_r_dev_profile "$pkg_dir" "$claude_profile"
   fi
   ```

3. **`commands/pj-sync`** (NEW - ~150 lines)
   ```bash
   #!/usr/bin/env zsh
   # Usage: pj-sync [status|inventory|parity]

   main() {
       case "$1" in
           status)
               # Gather repo status
               # Call data-wise/planning/automation/sync-status.sh
               ;;
           inventory)
               # Scan all repos
               # Call data-wise/planning/automation/update-inventory.sh
               ;;
           parity)
               # Check claude vs gemini
               # Call data-wise/planning/automation/update-parity.sh
               ;;
       esac
   }
   ```

**Test:** End-to-end integration test

---

### Agent 2 Supports (data-wise)

**Test Automation Scripts:**

```bash
# Test sync-status.sh
cd ~/projects/dev-tools/data-wise
./planning/automation/sync-status.sh --test

# Test update-inventory.sh
./planning/automation/update-inventory.sh --dry-run

# Verify markdown updates
git diff planning/ACTIVE_PROJECTS.md
```

---

### Agent 3 Supports (claude-r-dev)

**Verify Installer:**

```bash
# Test from zsh-claude-workflow
cd /tmp
mkdir test-package
echo "Package: testpkg" > test-package/DESCRIPTION

# Call from zsh
cd ~/projects/dev-tools/zsh-claude-workflow
./commands/rpkg-setup /tmp/test-package --claude-profile base

# Verify .claude/ created
ls -la /tmp/test-package/.claude/
```

---

## 📋 Phase 4: Testing & Documentation (PARALLEL - 1-2 hours)

### Agent 1 (zsh-claude-workflow)

**Documentation:**

1. Update `CLAUDE.md`:
   - Add ecosystem integration section
   - Document new commands
   - Add claude-r-dev integration

2. Update `docs/`:
   - Add `docs/integration/claude-r-dev.md`
   - Add `docs/integration/data-wise.md`
   - Update command reference

3. Create examples:
   - `examples/rpkg-with-claude-r-dev.sh`
   - `examples/ecosystem-status.sh`

**Testing:**

```bash
# End-to-end test
cd /tmp
rpkg-setup test-pkg --type statistical --claude-profile base,statistical-methods
cd test-pkg
docs-setup --type altdoc
altdoc preview
cd ~/projects/dev-tools/zsh-claude-workflow
ecosystem status
pj-sync status
```

---

### Agent 2 (data-wise)

**Documentation:**

1. Update `README.md`:
   - Add "Automation" section
   - Link to planning/automation/
   - Show integration with zsh-claude-workflow

2. Update `.claude/CLAUDE.md`:
   - Add context about automation scripts
   - Document planning workflow

**Testing:**

```bash
# Test all automation scripts
cd ~/projects/dev-tools/data-wise
for script in planning/automation/*.sh; do
    echo "Testing $script..."
    bash "$script" --dry-run
done
```

---

### Agent 3 (claude-r-dev)

**Documentation:**

1. Deploy updated docs:
   ```bash
   cd ~/projects/dev-tools/claude-r-dev
   mkdocs build
   mkdocs gh-deploy
   ```

2. Update CHANGELOG.md:
   - Add v1.1 entry
   - Document zsh integration

**Testing:**

```bash
# Test installer variations
./scripts/install.sh --help
./scripts/install.sh --profiles base --target /tmp/test --called-from-zsh
```

---

## ✅ Completion Checklist

### Agent 1 (zsh-claude-workflow)

- [ ] `lib/docs-manager.sh` created
- [ ] `lib/ecosystem-manager.sh` created
- [ ] `commands/docs-setup` created
- [ ] `commands/altdoc` created
- [ ] `commands/ecosystem` created
- [ ] `commands/pj-sync` created
- [ ] `lib/claude-r-dev-bridge.sh` enhanced
- [ ] `commands/rpkg-setup` updated
- [ ] Documentation updated
- [ ] Integration tests pass

### Agent 2 (data-wise)

- [ ] `planning/automation/sync-status.sh` created
- [ ] `planning/automation/update-inventory.sh` created
- [ ] `planning/automation/update-parity.sh` created
- [ ] `planning/ECOSYSTEM_ROADMAP.md` created
- [ ] `planning/QUARTERLY_GOALS.md` created
- [ ] `planning/CRAN_SUBMISSION_TRACKER.md` created
- [ ] README.md updated
- [ ] Automation scripts tested

### Agent 3 (claude-r-dev)

- [ ] `scripts/zsh-integration.sh` created
- [ ] `scripts/install.sh` updated
- [ ] `docs_mkdocs/integration.md` created
- [ ] `profiles/zsh-aware/CLAUDE.md` created
- [ ] README.md updated
- [ ] Documentation deployed
- [ ] Installer tested from zsh

---

## 🚀 Launch Commands

### Prepare Branches

```bash
# zsh-claude-workflow
cd ~/projects/dev-tools/zsh-claude-workflow
git checkout -b feature/ecosystem-integration
git push -u origin feature/ecosystem-integration

# data-wise
cd ~/projects/dev-tools/data-wise
git checkout -b feature/automation-hooks
git push -u origin feature/automation-hooks

# claude-r-dev
cd ~/projects/dev-tools/claude-r-dev
git checkout -b feature/zsh-integration
git push -u origin feature/zsh-integration
```

### Launch Agents (in parallel)

**Agent 1 Prompt:**
```
You are Agent 1: Workflow Architect. Your mission is to enhance zsh-claude-workflow
with multi-project operations and documentation integration.

Branch: feature/ecosystem-integration
Working Directory: ~/projects/dev-tools/zsh-claude-workflow

Follow the tasks in PARALLEL_AGENT_PLAN.md Phase 1-4 for Agent 1.
Create files systematically, test as you go, commit frequently.

Start with Phase 1: Create lib/docs-manager.sh
```

**Agent 2 Prompt:**
```
You are Agent 2: Project Tracker. Your mission is to add automation hooks to
data-wise for project tracking and sync.

Branch: feature/automation-hooks
Working Directory: ~/projects/dev-tools/data-wise

Follow the tasks in PARALLEL_AGENT_PLAN.md Phase 1-4 for Agent 2.
Create planning documents and automation scripts.

Start with Phase 1: Create planning/automation/sync-status.sh
```

**Agent 3 Prompt:**
```
You are Agent 3: R Specialist. Your mission is to add zsh integration to
claude-r-dev for seamless shell workflows.

Branch: feature/zsh-integration
Working Directory: ~/projects/dev-tools/claude-r-dev

Follow the tasks in PARALLEL_AGENT_PLAN.md Phase 1-4 for Agent 3.
Create integration scripts and documentation.

Start with Phase 1: Create scripts/zsh-integration.sh
```

---

## 📊 Progress Tracking

Use `plan-status` to track progress:

```bash
# Add agents to tracking
plan-status --add-milestone "Ecosystem Integration" --target 2025-12-15

# Update progress
plan-status --update ecosystem agent-1 in_progress
plan-status --update ecosystem agent-2 in_progress
plan-status --update ecosystem agent-3 in_progress
```

---

## 🎯 Success Metrics

- **Time Saved:** 60% (4-6 hours vs 11-15 hours)
- **Integration:** 100% of planned features
- **Tests:** All integration tests pass
- **Documentation:** Complete for all 3 projects
- **No Conflicts:** Clean merges between branches

---

**Ready to launch! 🚀**
