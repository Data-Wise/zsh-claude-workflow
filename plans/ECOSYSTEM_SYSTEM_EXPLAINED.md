# MediationVerse Ecosystem Management System - Complete Explanation

> **Purpose:** Crystal-clear explanation of the entire coordination system
> **Date:** 2025-12-10
> **Audience:** Understanding before building

---

## 🎯 The Big Picture

### What Problem Are We Solving?

**You have 6 R packages that depend on each other:**

```
                    mediationverse (meta)
                           |
        +------------------+------------------+
        |                  |                  |
     medrobust          medsim          missingmed
        |                  |
        |         +--------+--------+
        |         |                 |
     medfit    probmed         rmediation
     (foundation)
```

**Two coordination problems:**

1. **DOWNSTREAM:** When you change medfit, what breaks in probmed, rmediation, medrobust, medsim?
2. **UPSTREAM:** When you work on medsim, how do you use development versions of medfit, probmed, rmediation?

**Current pain:**
- You work scattered (jump between packages)
- You don't know what breaks until you test manually
- Hard to coordinate features across multiple packages
- Releases are ad-hoc, not systematic

---

## 🏗️ The Complete System Architecture

### Layer 1: Package Dependencies (What Exists Now)

```
medfit/DESCRIPTION:
  Package: medfit
  Imports: S7, checkmate
  # Foundation package, no MediationVerse deps

probmed/DESCRIPTION:
  Package: probmed
  Imports: medfit, checkmate
  # Depends on medfit only

rmediation/DESCRIPTION:
  Package: rmediation
  Imports: medfit, checkmate
  # Depends on medfit only

medsim/DESCRIPTION:
  Package: medsim
  Imports: medfit, probmed, rmediation
  # Depends on all three!

mediationverse/DESCRIPTION:
  Package: mediationverse
  Imports: medfit, probmed, rmediation, medrobust, medsim
  # Meta-package, imports all
```

**The problem:** These are STATIC dependencies. They point to CRAN versions or installed versions, not your local development versions.

---

### Layer 2: Development Dependencies (What We'll Add)

#### Tool 1: Remotes Field (Temporary Development Links)

**Purpose:** Tell devtools "use my LOCAL version, not CRAN"

**Example - Working on medsim:**

```r
# medsim/DESCRIPTION (DURING DEVELOPMENT ONLY)
Package: medsim
Imports:
    medfit (>= 0.2.0.9000),
    probmed,
    rmediation
Remotes:
    local::/Users/dt/projects/r-packages/active/medfit,
    local::/Users/dt/projects/r-packages/active/probmed,
    local::/Users/dt/projects/r-packages/active/rmediation
```

**What this means:**
- "medfit" should come from `/Users/dt/projects/r-packages/active/medfit` (your local copy)
- NOT from CRAN or my installed library
- Use the development version (0.2.0.9000)

**How it works:**

```r
# When you run:
devtools::install("~/projects/r-packages/active/medsim")

# devtools does this automatically:
# 1. Read Remotes field
# 2. Install medfit from local path first
# 3. Install probmed from local path
# 4. Install rmediation from local path
# 5. NOW install medsim (with local deps available)
```

**⚠️ CRITICAL:** Remove Remotes before CRAN submission!

```r
# medsim/DESCRIPTION (FOR CRAN SUBMISSION)
Package: medsim
Imports:
    medfit (>= 0.2.0),  # CRAN version
    probmed,
    rmediation
# NO Remotes field!
```

**Why use this?**
- ✅ Test medsim against your latest medfit changes
- ✅ Don't wait for medfit to be on CRAN
- ✅ Automatic installation of local deps
- ✅ Standard R ecosystem practice

**When NOT to use:**
- ❌ Never commit Remotes field to main branch
- ❌ Never submit to CRAN with Remotes field
- ❌ Only for development branches/local work

---

#### Tool 2: Reverse Dependency Checking (What Breaks?)

**Purpose:** Before changing medfit, find out what breaks downstream

**How it works:**

```r
# In medfit/ directory
# You made changes, want to know impact

revdepcheck::revdep_check()

# What happens:
# 1. Finds all packages that depend on medfit
#    - probmed (Imports: medfit)
#    - rmediation (Imports: medfit)
#    - medrobust (Imports: medfit)
#    - medsim (Imports: medfit)
#
# 2. For EACH package:
#    a. Run R CMD check with CRAN version of medfit
#    b. Run R CMD check with YOUR version of medfit
#    c. Compare results
#
# 3. Report differences:
#    ✓ probmed: No new problems
#    ✗ rmediation: 2 new failures
#      - test-bootstrap.R:45 - function renamed
#      - vignette error
#    ✓ medrobust: No new problems
#    ⚠ medsim: 1 new warning (non-breaking)
```

**Now you know:**
- probmed and medrobust: Safe, no problems
- rmediation: BREAKS! Need to fix
- medsim: Warning to investigate

**Why use this?**
- ✅ Know IMMEDIATELY what breaks (don't discover weeks later)
- ✅ Fix downstream packages BEFORE releasing medfit
- ✅ Confident CRAN submissions
- ✅ Standard practice for serious R package developers

---

### Layer 3: Workspace Organization (See Everything)

**Purpose:** Visual organization when working across multiple packages

**The workspace file:**

```json
// ~/projects/r-packages/mediationverse-dev.code-workspace
{
  "folders": [
    { "path": "active/medfit",        "name": "1-medfit (foundation)" },
    { "path": "active/probmed",       "name": "2-probmed" },
    { "path": "active/rmediation",    "name": "3-rmediation" },
    { "path": "active/medrobust",     "name": "4-medrobust" },
    { "path": "active/medsim",        "name": "5-medsim" },
    { "path": "active/mediationverse", "name": "6-mediationverse (meta)" }
  ],
  "settings": {
    "terminal.integrated.cwd": "${workspaceFolder}"
  }
}
```

**What this does:**

```
VS Code Window:
┌─────────────────────────────────────────────────┐
│ EXPLORER                                        │
├─────────────────────────────────────────────────┤
│ ▼ 1-medfit (foundation)                         │
│   ├─ R/                                         │
│   ├─ tests/                                     │
│   └─ DESCRIPTION                                │
│ ▼ 2-probmed                                     │
│   ├─ R/                                         │
│   └─ DESCRIPTION                                │
│ ▼ 3-rmediation                                  │
│ ▼ 4-medrobust                                   │
│ ▼ 5-medsim                                      │
│ ▼ 6-mediationverse (meta)                       │
└─────────────────────────────────────────────────┘
```

**Benefits:**
- ✅ See all 6 packages in one window
- ✅ Navigate between packages easily
- ✅ Edit files across packages
- ✅ Search across entire ecosystem
- ✅ Numbered order shows dependency hierarchy

**Use when:**
- Working on features that span multiple packages
- Need to check how something is implemented in another package
- Coordinating releases
- Debugging cross-package issues

---

### Layer 4: Automation Commands (zsh-claude-workflow)

**Purpose:** Automate the tedious parts

**Commands we'll build:**

```bash
# Reverse dependency checking
ecosystem revdep medfit
# → Runs revdepcheck::revdep_check()
# → Shows summary
# → Updates data-wise tracking

# Install with local dependencies
ecosystem install-deps medsim
# → Finds local deps (medfit, probmed, rmediation)
# → Installs in order
# → Verifies with tests

# Workspace management
ecosystem workspace create mediationverse
# → Creates .code-workspace file
# → Opens in editor

# Feature tracking
ecosystem feature track new-effect-size --packages medfit,probmed,medsim
# → Creates feature branches
# → Updates planning docs
# → Sets up coordination

# Status dashboard
ecosystem mediationverse-status
# → Shows all packages
# → CRAN status
# → Dependency health
# → What needs attention
```

---

### Layer 5: Project Tracking (data-wise)

**Purpose:** Keep track of ecosystem state

**Files in data-wise repo:**

```
data-wise/planning/
├── MEDIATIONVERSE_STATUS.md      # Package status dashboard
├── DEPENDENCY_MAP.md             # Visual dependency map
├── features/
│   ├── new-effect-size.md       # Feature tracking
│   └── s7-migration.md
└── releases/
    └── 2025-q1-releases.md      # Release coordination
```

**Example - MEDIATIONVERSE_STATUS.md:**

```markdown
# MediationVerse Package Status

**Last Updated:** 2025-12-10 15:30

| Package | Version | CRAN | Local | Needs Update | Status |
|---------|---------|------|-------|--------------|--------|
| medfit  | 0.1.0   | ✗    | 0.2.0.9000 | Ready for CRAN | 🟢 |
| probmed | 1.0.0   | ✗    | 1.0.0 | Waiting for medfit | 🟡 |
| rmediation | 1.0.8 | ✓  | 1.0.8 | On CRAN | 🟢 |
| medrobust | 0.1.0 | ✗    | 0.1.0 | Dev | 🟡 |
| medsim  | 0.1.0   | ✗    | 0.1.5.9000 | Active dev | 🟢 |
| mediationverse | 0.1.0 | ✗ | 0.1.0 | Waiting | ⚪ |

## Notes
- medfit ready for CRAN submission (all revdep checks pass)
- probmed waiting for medfit CRAN acceptance
- medsim active development on simulation features
```

**Auto-updated by:**
```bash
ecosystem mediationverse-status --update
```

---

## 🔄 Complete Workflow Examples

### Workflow 1: Normal Day - Working on medfit

**Scenario:** You're improving medfit, scattered work style

```bash
# Monday morning: Start work on medfit
cd ~/projects/r-packages/active/medfit

# Make some changes to medfit
# ... edit R/new-feature.R

# Test locally
R -e "devtools::test()"
# ✓ All tests pass

# BEFORE committing - check downstream impact
R -e "revdepcheck::revdep_check()"
# Output:
# Checking 4 reverse dependencies...
# ✓ probmed: OK
# ✓ rmediation: OK
# ✗ medrobust: 1 new failure
# ✓ medsim: OK

# Oh no! medrobust breaks. Let me check what's wrong.
cat revdep/medrobust.Rcheck/00check.log
# Error: function estimate_effect() not found

# I renamed that function! Need to update medrobust too.

# Option A: Fix medrobust now (coordinated change)
cd ~/projects/r-packages/active/medrobust
# Update to use new function name
git commit -m "Update for medfit API change"

# Option B: Revert medfit change (avoid breaking change)
cd ~/projects/r-packages/active/medfit
# Keep old function as alias with deprecation warning

# Option C: Document breaking change, plan coordinated release
# Add to medfit NEWS.md:
# BREAKING CHANGE: estimate_effect() renamed to compute_effect()
# Affects: medrobust (fix in progress)

# Commit medfit
git commit -m "feat: improve API (breaking: rename estimate_effect)"

# Update ecosystem status
cd ~/projects/dev-tools/zsh-claude-workflow
ecosystem mediationverse-status --update
# → Updates data-wise/MEDIATIONVERSE_STATUS.md
# → Shows medrobust needs attention
```

**What this workflow demonstrates:**
- ✅ You know IMMEDIATELY medrobust breaks
- ✅ You can decide: fix now, revert, or coordinate
- ✅ No surprise "oh, medrobust is broken!" weeks later
- ✅ Automated status tracking

---

### Workflow 2: Feature Across Multiple Packages

**Scenario:** Add "robust mediation" feature (needs medfit + probmed + medrobust)

```bash
# Step 1: Plan the feature
cd ~/projects/dev-tools/data-wise
mkdir -p planning/features
cat > planning/features/robust-mediation.md <<EOF
# Feature: Robust Mediation Analysis

## Packages Affected
- medfit: Add RobustMediationResult S7 class
- probmed: Add pmed_robust() calculation
- medrobust: Add sensitivity analysis for robust methods

## Timeline
Target: Q1 2025

## Tasks
See individual package sections below...
EOF

# Step 2: Use automation to set up
cd ~/projects/dev-tools/zsh-claude-workflow
ecosystem feature track robust-mediation --packages medfit,probmed,medrobust
# Output:
# Creating feature branches in:
# ✓ medfit: feature/robust-mediation
# ✓ probmed: feature/robust-mediation
# ✓ medrobust: feature/robust-mediation
# ✓ Updated data-wise/planning/features/robust-mediation.md
# ✓ Created workspace: robust-mediation.code-workspace

# Step 3: Open workspace (see all 3 packages)
code ~/projects/r-packages/robust-mediation.code-workspace
# Now you have medfit, probmed, medrobust visible in one window

# Step 4: Develop in dependency order

# 4a. Start with medfit (foundation)
cd ~/projects/r-packages/active/medfit
git checkout feature/robust-mediation
# ... add RobustMediationResult S7 class
devtools::test()
devtools::install()  # Install locally

# 4b. Move to probmed (uses medfit)
cd ~/projects/r-packages/active/probmed
git checkout feature/robust-mediation

# Add to DESCRIPTION (temporary, for development):
# Remotes: local::/Users/dt/projects/r-packages/active/medfit@feature/robust-mediation

# ... add pmed_robust() function using RobustMediationResult
devtools::install()  # Auto-installs local medfit!
devtools::test()

# 4c. Move to medrobust (uses both)
cd ~/projects/r-packages/active/medrobust
git checkout feature/robust-mediation

# Add to DESCRIPTION:
# Remotes:
#   local::/Users/dt/projects/r-packages/active/medfit@feature/robust-mediation
#   local::/Users/dt/projects/r-packages/active/probmed@feature/robust-mediation

# ... add sensitivity analysis
devtools::install()  # Auto-installs local medfit + probmed!
devtools::test()

# Step 5: Check feature status
ecosystem feature status robust-mediation
# Output:
# Feature: Robust Mediation Analysis
# medfit:     ✓ Complete (branch merged)
# probmed:    ● In progress (80% tests passing)
# medrobust:  ○ Not started

# Step 6: When all done - merge in order
# Merge medfit → main
# Merge probmed → main (remove Remotes field first!)
# Merge medrobust → main (remove Remotes field first!)

# Step 7: Release coordination
ecosystem release-plan medfit
# Output:
# Release Plan for medfit 0.2.0:
# 1. Submit medfit 0.2.0 → CRAN
# 2. Wait for acceptance (usually 1-7 days)
# 3. Update probmed DESCRIPTION: medfit (>= 0.2.0)
# 4. Submit probmed 1.1.0 → CRAN
# 5. Wait for acceptance
# 6. Update medrobust DESCRIPTION: probmed (>= 1.1.0)
# 7. Submit medrobust 0.2.0 → CRAN
```

**What this workflow demonstrates:**
- ✅ Coordinated development across 3 packages
- ✅ Use development versions via Remotes field
- ✅ Track progress in data-wise
- ✅ Systematic release planning
- ✅ Everything visible in workspace

---

### Workflow 3: Working on Downstream Package (medsim)

**Scenario:** Adding simulation for new medfit feature

```bash
# You want to work on medsim
# medsim needs: medfit, probmed, rmediation

# Current state:
# - medfit: You just added new feature (not on CRAN yet)
# - probmed: Has new method (not on CRAN yet)
# - rmediation: Stable (on CRAN)

# Step 1: Set up medsim to use local versions
cd ~/projects/r-packages/active/medsim

# Option A: Manual (add Remotes field)
# Edit DESCRIPTION:
# Remotes:
#   local::/Users/dt/projects/r-packages/active/medfit,
#   local::/Users/dt/projects/r-packages/active/probmed

# Option B: Automated
ecosystem install-deps medsim --local
# Output:
# Scanning dependencies of medsim...
# Found: medfit, probmed, rmediation
#
# Checking for local versions:
# ✓ medfit: Local version 0.2.0.9000 (newer than CRAN)
# ✓ probmed: Local version 1.1.0.9000 (newer than CRAN)
# ✓ rmediation: CRAN version 1.0.8 (up to date)
#
# Adding Remotes field to DESCRIPTION (temporary)...
# Installing dependencies in order:
# 1. Installing medfit from local... ✓
# 2. Installing probmed from local... ✓
# 3. Installing rmediation from CRAN... ✓
# 4. Installing medsim... ✓
#
# Ready to develop!

# Step 2: Develop medsim
R
devtools::load_all()
# Now medsim has access to latest medfit + probmed features!

# ... add new simulation function
devtools::test()

# Step 3: Found bug in medfit while testing medsim
# Switch to medfit
cd ~/projects/r-packages/active/medfit
# Fix bug
devtools::test()
devtools::install()  # Reinstall medfit

# Step 4: Back to medsim - pick up fix
cd ~/projects/r-packages/active/medsim
# Restart R session (to reload new medfit)
R
devtools::load_all()
devtools::test()  # Should pass now

# Step 5: Before committing medsim
# Remove Remotes field from DESCRIPTION
# (Or use automation)
ecosystem install-deps medsim --clean
# → Removes Remotes field
# → Warns if local versions needed

# Step 6: Commit
git add .
git commit -m "feat: add simulation for new medfit feature"
```

**What this workflow demonstrates:**
- ✅ Use local development versions in medsim
- ✅ Quick iteration between packages
- ✅ Fix bugs immediately when found
- ✅ Clean up before commit (remove Remotes)
- ✅ Automated dependency management

---

## 📊 System Components Summary

### What Each Tool Does

| Tool | What | When to Use | Example |
|------|------|-------------|---------|
| **Remotes field** | Point to local dev versions | Working on downstream pkg needing upstream features | medsim uses dev medfit |
| **revdepcheck** | Find what breaks downstream | Before changing foundation pkg | Change medfit, check impact |
| **Workspace file** | See multiple pkgs at once | Coordinated development | Feature spans 3 packages |
| **ecosystem commands** | Automate coordination | Daily workflow | Quick status, install, track |
| **data-wise tracking** | Record ecosystem state | Planning & releases | What needs attention? |

---

### Decision Tree: Which Tool When?

```
Are you changing a FOUNDATION package (medfit)?
│
├─ YES → Use revdepcheck BEFORE committing
│        ↓
│        Did anything break?
│        ├─ YES → Fix downstream OR revert change
│        └─ NO → Safe to commit
│
└─ NO → Are you working on DOWNSTREAM package?
         │
         ├─ YES → Does it need DEV versions of dependencies?
         │        ├─ YES → Use Remotes field
         │        └─ NO → Normal devtools workflow
         │
         └─ NO → Feature spanning MULTIPLE packages?
                  ├─ YES → Use workspace + feature tracking
                  └─ NO → Normal single-package development
```

---

## 🎯 Remotes Field - Detailed Explanation

### What Problem Does It Solve?

**Without Remotes field:**

```bash
# You're working on medsim
cd ~/projects/r-packages/active/medsim
R
devtools::load_all()

# medsim Imports: medfit
# Which medfit does it use?
# → The one installed in your library (probably old CRAN version)
# → NOT your latest local changes!

# Problem: Can't test medsim against new medfit features
```

**With Remotes field:**

```r
# medsim/DESCRIPTION:
Remotes: local::/Users/dt/projects/r-packages/active/medfit

# Now when you install:
devtools::install("~/projects/r-packages/active/medsim")

# It uses your LOCAL medfit, with latest changes!
```

### How It Works Internally

```r
# devtools::install() reads DESCRIPTION
# Sees: Remotes: local::~/path/to/medfit
# Understands: "Install medfit from local path, not CRAN"

# Step-by-step:
# 1. Parse Remotes field
# 2. For each remote:
#    a. If local::, install from that path
#    b. If github::, install from GitHub
#    c. If regular, install from CRAN
# 3. Install the main package (medsim)
```

### When To Use

**✅ USE when:**
- Working on downstream package that needs upstream features
- Testing integration before upstream is on CRAN
- Coordinated development across packages
- Development branches only

**❌ DON'T USE when:**
- Submitting to CRAN (ERROR!)
- Upstream is already on CRAN (use version requirement instead)
- Main branch (only dev branches)
- Sharing with others (they won't have same paths)

### Safety Checks

```bash
# We'll build this command:
ecosystem check-remotes medsim

# Output:
# ⚠ WARNING: Remotes field detected in DESCRIPTION
#
# Current Remotes:
# - local::/Users/dt/projects/r-packages/active/medfit
#
# This is OK for:
# ✓ Development branches
# ✓ Local testing
#
# This is NOT OK for:
# ✗ CRAN submission (will be REJECTED)
# ✗ Main branch (other developers can't use)
#
# Suggestions:
# 1. Before merging to main: Remove Remotes field
# 2. Before CRAN: Ensure dependencies are on CRAN
# 3. Update Imports: medfit (>= 0.2.0) to require CRAN version
```

---

## 🚀 Automation Commands - Detailed Breakdown

### Command 1: ecosystem revdep

**What it does:**
```bash
ecosystem revdep medfit
```

**Under the hood:**
```bash
# 1. Change to package directory
cd ~/projects/r-packages/active/medfit

# 2. Run revdepcheck
Rscript -e "revdepcheck::revdep_check(num_workers = 4)"

# 3. Parse results
# - Extract failures
# - Categorize (error, warning, note)
# - Compare with baseline

# 4. Generate report
# - Summary in terminal
# - Detailed log in revdep/

# 5. Update tracking
# - Update data-wise/DEPENDENCY_MAP.md
# - Mark packages needing attention

# 6. Output
echo "Reverse dependency check complete"
echo "✓ probmed: No new problems"
echo "✗ rmediation: 2 new failures (see revdep/rmediation.md)"
```

**Options:**
```bash
ecosystem revdep medfit --workers 8     # Use 8 parallel workers
ecosystem revdep medfit --update-only   # Just update tracking, don't re-run
ecosystem revdep medfit --summary       # Show summary only
```

---

### Command 2: ecosystem install-deps

**What it does:**
```bash
ecosystem install-deps medsim --local
```

**Under the hood:**
```bash
# 1. Read medsim/DESCRIPTION
deps=$(grep "^Imports:" medsim/DESCRIPTION | cut -d: -f2)
# deps = medfit, probmed, rmediation

# 2. For each dependency, check if local version exists
for dep in $deps; do
    if [ -d ~/projects/r-packages/active/$dep ]; then
        # Local version exists!
        local_version=$(grep "^Version:" ~/projects/r-packages/active/$dep/DESCRIPTION | cut -d: -f2)
        echo "$dep: Found local version $local_version"
        remotes+=("local::~/projects/r-packages/active/$dep")
    fi
done

# 3. Add Remotes field to DESCRIPTION (if --local flag)
if [ "$LOCAL" = "true" ]; then
    echo "Remotes: ${remotes[@]}" >> medsim/DESCRIPTION
fi

# 4. Install in dependency order
Rscript -e "devtools::install('~/projects/r-packages/active/medsim')"

# 5. Verify
Rscript -e "devtools::test('~/projects/r-packages/active/medsim')"

# 6. Warn about cleanup
echo "⚠ Remember to remove Remotes field before committing!"
```

**Options:**
```bash
ecosystem install-deps medsim --local   # Use local versions
ecosystem install-deps medsim --cran    # Force CRAN versions
ecosystem install-deps medsim --clean   # Remove Remotes field
ecosystem install-deps medsim --dry-run # Show what would happen
```

---

### Command 3: ecosystem workspace

**What it does:**
```bash
ecosystem workspace create mediationverse
```

**Under the hood:**
```bash
# 1. Find all MediationVerse packages
packages=(medfit probmed rmediation medrobust medsim mediationverse)

# 2. Detect dependency order (parse DESCRIPTION files)
# Build dependency graph, topological sort
order=(medfit probmed rmediation medrobust medsim mediationverse)

# 3. Generate workspace JSON
cat > ~/projects/r-packages/mediationverse-dev.code-workspace <<EOF
{
  "folders": [
$(for i in ${!order[@]}; do
    pkg=${order[$i]}
    echo "    { \"path\": \"active/$pkg\", \"name\": \"$((i+1))-$pkg\" },"
done | sed '$ s/,$//')
  ],
  "settings": {
    "terminal.integrated.cwd": "\${workspaceFolder}",
    "search.exclude": {
      "**/revdep/**": true,
      "**/.Rcheck/**": true
    }
  }
}
EOF

# 4. Open workspace
code ~/projects/r-packages/mediationverse-dev.code-workspace
```

**Options:**
```bash
ecosystem workspace create mediationverse          # Create and open
ecosystem workspace create mediationverse --dry    # Show JSON only
ecosystem workspace list                           # List all workspaces
ecosystem workspace open mediationverse            # Open existing
```

---

### Command 4: ecosystem feature

**What it does:**
```bash
ecosystem feature track new-effect-size --packages medfit,probmed,medsim
```

**Under the hood:**
```bash
# 1. Create feature tracking file
mkdir -p ~/projects/dev-tools/data-wise/planning/features
cat > ~/projects/dev-tools/data-wise/planning/features/new-effect-size.md <<EOF
# Feature: New Effect Size

**Packages:** medfit, probmed, medsim
**Created:** $(date)
**Status:** In Progress

## Tasks
[Generated task list for each package]
EOF

# 2. Create feature branches
for pkg in medfit probmed medsim; do
    cd ~/projects/r-packages/active/$pkg
    git checkout -b feature/new-effect-size
    echo "✓ Created feature/new-effect-size in $pkg"
done

# 3. Set up Remotes for coordination (optional)
# Add Remotes: local::...@feature/new-effect-size

# 4. Create feature workspace
ecosystem workspace create new-effect-size --packages medfit,probmed,medsim

# 5. Output
echo "Feature setup complete!"
echo "- Tracking: data-wise/planning/features/new-effect-size.md"
echo "- Branches created in: medfit, probmed, medsim"
echo "- Workspace: new-effect-size.code-workspace"
```

**Options:**
```bash
ecosystem feature track NAME --packages X,Y,Z     # Create new
ecosystem feature status NAME                      # Show progress
ecosystem feature complete NAME --package medfit   # Mark package done
ecosystem feature merge NAME                       # Merge all branches
```

---

### Command 5: ecosystem mediationverse-status

**What it does:**
```bash
ecosystem mediationverse-status
```

**Under the hood:**
```bash
# 1. Scan all packages
for pkg in medfit probmed rmediation medrobust medsim mediationverse; do
    cd ~/projects/r-packages/active/$pkg

    # Get local version
    local_version=$(grep "^Version:" DESCRIPTION | cut -d: -f2)

    # Check CRAN (via web scraping or API)
    cran_version=$(curl -s "https://cran.r-project.org/package=$pkg" | grep "Version:" || echo "Not on CRAN")

    # Check git status
    git_status=$(git status --short | wc -l)

    # Check revdep status (if applicable)
    if [ -f revdep/problems.md ]; then
        revdep_status="⚠ Problems"
    else
        revdep_status="✓ OK"
    fi

    # Store results
    echo "$pkg|$local_version|$cran_version|$git_status|$revdep_status"
done

# 2. Generate markdown table
cat > ~/projects/dev-tools/data-wise/planning/MEDIATIONVERSE_STATUS.md <<EOF
# MediationVerse Status

**Updated:** $(date)

| Package | Local | CRAN | Changes | RevDep | Status |
|---------|-------|------|---------|--------|--------|
[Table rows here]

## Attention Needed
[Packages with issues]

## Next Actions
[Suggested next steps]
EOF

# 3. Display in terminal
cat MEDIATIONVERSE_STATUS.md | bat --language markdown

# 4. Commit to data-wise
cd ~/projects/dev-tools/data-wise
git add planning/MEDIATIONVERSE_STATUS.md
git commit -m "Update MediationVerse status"
```

---

## ✅ Summary

### The Complete System

**5 Layers working together:**

1. **Package Dependencies** (DESCRIPTION files) - What exists
2. **Development Dependencies** (Remotes field) - Link to local versions
3. **Workspace Organization** (.code-workspace) - See everything
4. **Automation Commands** (ecosystem) - Do the tedious parts
5. **Project Tracking** (data-wise) - Remember state

### Key Workflows

1. **Changing foundation** (medfit) → Use revdepcheck
2. **Working downstream** (medsim) → Use Remotes field
3. **Coordinated feature** → Use workspace + feature tracking
4. **Daily status check** → Use mediationverse-status
5. **Release coordination** → Use release-plan

### What You Get

- ✅ Know immediately what breaks
- ✅ Test against local development versions
- ✅ Coordinate features across packages
- ✅ Track ecosystem status
- ✅ Systematic release planning
- ✅ Less manual work, more automation

---

## 💬 Does This Make Sense?

**Questions to clarify:**

1. **Remotes field** - Do you understand how it links to local versions?
2. **revdepcheck** - Clear on when/why to use it?
3. **Workspace** - See the value of having all packages visible?
4. **Commands** - Which commands would you use most?
5. **Workflow** - Which workflow matches how you work?

**What to build first?**

Ready to implement? Or need more clarification on any part?
