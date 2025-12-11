# HOW IT WORKS - Read When Curious

> Deep explanations of tools and concepts
> Reference only - not required for daily use
> Read when hyperfocusing or need to understand "why"

---

## 📖 Table of Contents

- [MediationVerse Coordination](#mediationverse-coordination)
  - [Why check-breaks works](#ecosystem-check-breaks)
  - [Why install-dev works](#ecosystem-install-dev)
  - [Why status-all works](#ecosystem-status-all)
- [Teaching Organization](#teaching-organization)
  - [Why dedicated directory](#why-teaching-as-dedicated-directory)
  - [Why weekly structure](#why-weekly-structure)
- [Context Management](#context-management)
  - [How remember/recall works](#how-rememberrecall-works)
- [Technical Details](#technical-details)
  - [Remotes field explained](#remotes-field-deep-dive)
  - [revdepcheck explained](#revdepcheck-deep-dive)
  - [Workspace files explained](#workspace-files-explained)

---

## MediationVerse Coordination

### Problem Statement

You have 6 R packages with dependency relationships:

```
medfit (foundation)
  ↓
probmed, rmediation, medrobust (depend on medfit)
  ↓
medsim (depends on medfit, probmed, medrobust)
  ↓
mediationverse (depends on everything)
```

**Challenge:** When you change `medfit`, how do you know what breaks downstream?

### Solution Architecture

Three complementary tools:

1. **ecosystem check-breaks** - Tests downstream packages
2. **ecosystem install-dev** - Uses local development versions
3. **ecosystem status-all** - Visual overview of all packages

---

## `ecosystem check-breaks`

### What It Does

```bash
ecosystem check-breaks medfit
```

**Steps executed:**
1. Install `medfit` locally from source
2. Find all packages that depend on `medfit`
3. For each dependent package:
   - Install it (uses local `medfit`)
   - Run `R CMD check`
   - Capture test results
4. Display visual summary

### Visual Output

```
Checking downstream packages for medfit...

✓ probmed (0.2.0)
  - 127 tests passed
  - 0 failures
  - Build: OK
  - Examples: OK

✗ rmediation (1.4.0)
  - 89 tests passed
  - 2 failures
  - Build: OK
  - Examples: FAILED

  Failing tests:
  • test-confidence-intervals.R:45 - Expected S3, got S7
  • test-print-methods.R:12 - Method signature mismatch

  [Open failing tests? Y/n]

✓ medrobust (0.1.0)
  - 34 tests passed
  - 0 failures
  - Build: OK
  - Examples: OK

SUMMARY:
  2/3 packages passing
  1 package needs attention: rmediation
```

### How It Works Internally

**Step 1: Dependency detection**

```bash
# Read each package's DESCRIPTION file
grep -r "medfit" ~/projects/r-packages/active/*/DESCRIPTION

# Extract package names
# Build dependency graph
```

**Step 2: Local installation**

```bash
cd ~/projects/r-packages/active/medfit
R CMD INSTALL .
```

**Step 3: Testing each package**

```r
# For each dependent package
setwd("~/projects/r-packages/active/probmed")

# Install with local medfit
devtools::install_deps()
devtools::install()

# Run checks
devtools::check()

# Parse results
parse_check_results("probmed.Rcheck/00check.log")
```

**Step 4: Visual summary**

```bash
# Color coding:
GREEN="✓" if all tests pass
RED="✗" if any test fails
YELLOW="⚠" if warnings

# Auto-open failing tests in $EDITOR
```

### Why This Helps (ADHD Perspective)

**Without automation:**
```bash
cd ~/projects/r-packages/active/medfit
R CMD INSTALL .

cd ~/projects/r-packages/active/probmed
R CMD check .
# Read 200 lines of output, interpret manually

cd ~/projects/r-packages/active/rmediation
R CMD check .
# Read 200 lines of output, interpret manually

cd ~/projects/r-packages/active/medrobust
R CMD check .
# Read 200 lines of output, interpret manually

cd ~/projects/r-packages/active/medsim
R CMD check .
# Read 200 lines of output, interpret manually

# Now remember what failed where...
```

**Cognitive load:**
- 5 directories to navigate
- 5 commands to remember
- 1000 lines of output to parse
- Mental tracking of what failed where

**With automation:**
```bash
ecosystem check-breaks medfit
# Wait 2 minutes
# See visual summary
# Auto-opens failing files
```

**Cognitive load:**
- 1 command to remember
- Visual summary (color-coded)
- Automatic focus (opens failing tests)
- External memory (tool tracks what failed)

---

## `ecosystem install-dev`

### What It Does

```bash
ecosystem install-dev medsim
```

**Problem:** `medsim` depends on packages not on CRAN (medfit, probmed, medrobust)

**Normal installation fails:**
```r
install.packages("medsim")
# Error: package 'medfit' is not available
```

**Solution:** Temporarily add local paths to DESCRIPTION

### How It Works

**Step 1: Detect missing packages**

```bash
# Read medsim/DESCRIPTION
# Extract Imports, Depends, Suggests
# Check which are not on CRAN
# Check which exist locally
```

**Step 2: Add Remotes field**

```r
# medsim/DESCRIPTION before:
Package: medsim
Imports:
    medfit (>= 0.1.0),
    probmed,
    medrobust

# After ecosystem install-dev:
Package: medsim
Imports:
    medfit (>= 0.1.0),
    probmed,
    medrobust
Remotes:
    local::/Users/dt/projects/r-packages/active/medfit,
    local::/Users/dt/projects/r-packages/active/probmed,
    local::/Users/dt/projects/r-packages/active/medrobust
```

**Step 3: Install using remotes**

```r
remotes::install("~/projects/r-packages/active/medsim")

# remotes package reads Remotes field
# Installs medfit from local path
# Installs probmed from local path
# Installs medrobust from local path
# Then installs medsim
```

**Step 4: Clean up**

```bash
# Remove Remotes field after installation
# (CRITICAL: Must remove before CRAN submission!)
```

### Why Remotes Field Matters

**The Remotes field is a "sticky note" that tells R:**

> "Don't look for these packages on CRAN. They're over here instead."

**During development:**
```
Remotes: local::/Users/dt/projects/r-packages/active/medfit
```

**For GitHub packages:**
```
Remotes: github::data-wise/medfit
```

**CRITICAL WARNING:**

```
⚠️ CRAN WILL REJECT packages with Remotes field!

Before CRAN submission:
1. Submit medfit to CRAN first
2. Wait for acceptance
3. Remove Remotes field from medsim
4. Submit medsim to CRAN
```

### Visual Diagram

```
CRAN (Official Repository)
  ↓
  ✗ medfit not found
  ✗ probmed not found
  ✗ medrobust not found

Local Development
  ↓
  ✓ medfit at ~/projects/r-packages/active/medfit
  ✓ probmed at ~/projects/r-packages/active/probmed
  ✓ medrobust at ~/projects/r-packages/active/medrobust

Remotes field = "sticky note" pointing to local
```

### Why This Helps (ADHD Perspective)

**Without automation:**
```bash
# Every time you want to test medsim:
1. Manually edit DESCRIPTION
2. Add Remotes field with correct paths
3. Install
4. Test
5. Manually remove Remotes field
6. Hope you remembered to remove it before CRAN
```

**Cognitive load:**
- Remember to edit DESCRIPTION
- Remember exact path syntax
- Remember to remove it later
- Risk forgetting and submitting to CRAN with Remotes

**With automation:**
```bash
ecosystem install-dev medsim
# Handles everything automatically
# Removes Remotes after installation
# Warns if Remotes still present before CRAN
```

**Cognitive load:**
- Remember one command
- Tool handles paths
- Tool prevents CRAN mistakes

---

## `ecosystem status-all`

### What It Does

```bash
ecosystem status-all
```

**Output:**

```
📦 MediationVerse Ecosystem Status

1-medfit       [●] 2 uncommitted files (S7-migration)
               • src/fit_mediation.R
               • tests/testthat/test-s7-classes.R

2-probmed      [✓] Clean (v0.2.0)

3-rmediation   [⚠] Behind upstream 3 commits
               [●] 1 uncommitted file
               • R/confidence-intervals.R

4-medrobust    [✓] Clean (v0.1.0)

5-medsim       [●] 1 uncommitted file (adding-bootstrap)
               • R/bootstrap.R

6-mediationverse [✓] Clean (v1.0.0)

⚠ Actions needed:
  1. Commit changes in medfit (2 files)
  2. Pull rmediation (3 commits behind)
  3. Commit changes in rmediation (1 file)
  4. Commit changes in medsim (1 file)

💡 Next steps:
  → cd ~/projects/r-packages/active/medfit && git add . && git commit
  → cd ~/projects/r-packages/active/rmediation && git pull
```

### How It Works

**Step 1: Find all packages**

```bash
# Based on workspace file
packages=(
  ~/projects/r-packages/active/medfit
  ~/projects/r-packages/active/probmed
  ~/projects/r-packages/active/rmediation
  ~/projects/r-packages/active/medrobust
  ~/projects/r-packages/active/medsim
  ~/projects/r-packages/active/mediationverse
)
```

**Step 2: Check each package**

```bash
for pkg in "${packages[@]}"; do
  cd "$pkg"

  # Git status
  uncommitted=$(git status --porcelain | wc -l)

  # Branch info
  branch=$(git branch --show-current)

  # Upstream status
  git fetch
  ahead=$(git rev-list HEAD@{upstream}..HEAD --count)
  behind=$(git rev-list HEAD..HEAD@{upstream} --count)

  # Package version
  version=$(grep "^Version:" DESCRIPTION | cut -d' ' -f2)

  # Active branch from git log
  active_work=$(git log -1 --format="%s" | grep -o "\w\+-\w\+")
done
```

**Step 3: Visual display**

```bash
# Color coding:
[✓] GREEN  - Clean, no changes
[●] YELLOW - Uncommitted changes
[⚠] ORANGE - Behind upstream
[✗] RED    - Conflicts or errors

# List files if uncommitted
if [[ $uncommitted -gt 0 ]]; then
  git status --porcelain | awk '{print "  •", $2}'
fi
```

**Step 4: Action recommendations**

```bash
# Based on status, suggest:
# - Commit uncommitted files
# - Pull if behind
# - Push if ahead
# - Resolve conflicts if any

# Provide copy-paste commands
```

### Why This Helps (ADHD Perspective)

**Without automation:**
```bash
# Check each package manually:
cd ~/projects/r-packages/active/medfit
git status

cd ~/projects/r-packages/active/probmed
git status

cd ~/projects/r-packages/active/rmediation
git status

cd ~/projects/r-packages/active/medrobust
git status

cd ~/projects/r-packages/active/medsim
git status

cd ~/projects/r-packages/active/mediationverse
git status

# Now remember what was uncommitted where...
# Which package had conflicts?
# Which needed pulling?
```

**Cognitive load:**
- 6 directories to navigate
- 6 commands to run
- Mental tracking of status across all
- Easy to forget one package

**With automation:**
```bash
ecosystem status-all
# See everything at once
# Color-coded visual summary
# Suggested actions provided
```

**Cognitive load:**
- 1 command
- External memory (tool tracks everything)
- Visual at a glance
- No mental tracking needed

---

## Teaching Organization

### Why `~/teaching` as Dedicated Directory

**Principle:** Separate mental contexts = separate physical locations

#### Cognitive Load Theory

**Context switching cost:**
```
Working on R package development
  → Switch to teaching
  → Brain loads teaching context (5-10 min)
  → Find course materials (scattered)
  → Find which files need updating
  → Do teaching work
  → Switch back to R packages
  → Brain reloads dev context (5-10 min)
```

**Total cost:** 10-20 minutes per context switch

**ADHD amplification:** Context switching harder, more time lost

#### Solution: Physical Separation

```
~/projects/                    ← Development context
  Work on R packages
  Think about code, tests, bugs
  Tools: R, git, devtools

~/teaching/                    ← Teaching context
  Work on courses
  Think about students, pedagogy, exams
  Tools: Quarto, examify, Canvas
```

**Benefits:**
- Clear mental boundaries
- Easier to enter "teaching mode"
- All teaching materials in one place
- Separate backup/sync
- No git noise from teaching in dev repos

### Why Weekly Structure

**Traditional semester structure:**
```
stats-415/
├── lectures/
│   ├── 01-intro.qmd
│   ├── 02-probability.qmd
│   ├── ...
│   └── 28-review.qmd
│
├── homework/
│   ├── hw01.qmd
│   ├── hw02.qmd
│   └── ...
│
├── exams/
│   ├── exam01.qmd
│   └── exam02.qmd
```

**Problem:** Files scattered by type, not by time

**ADHD challenge:**
- "I'm working on week 5... where are all the week 5 files?"
- Have to open 3 directories (lectures/, homework/, exams/)
- Hard to see "what's done for week 5"

**Weekly structure:**
```
stats-415/
├── week-01/
│   ├── lecture.qmd
│   ├── homework.qmd
│   └── _checklist.md
│
├── week-02/
│   ├── lecture.qmd
│   ├── homework.qmd
│   └── _checklist.md
│
├── week-05/
│   ├── lecture.qmd
│   ├── homework.qmd
│   ├── quiz.qmd
│   └── _checklist.md
```

**Benefits:**
- Everything for week-05 in one place
- Clear boundaries (week-01 done, week-02 done, working on week-03)
- Checklist per week shows completion
- Sequential (matches how semester flows)

**ADHD-specific benefits:**
- No searching across directories
- Clear "done" criteria (week directory complete)
- Reduces working memory (only think about current week)
- Template prevents blank page anxiety

---

## Context Management

### How `remember/recall` Works

**Problem:** Working memory limitations, especially with ADHD

**Traditional approach:** Remember in your head
- "I was working on adding S7 support to medfit"
- "Next I need to update probmed tests"
- "Then check medsim for compatibility"

**Fails when:**
- Interrupted (phone call, meeting, lunch)
- End of day (tomorrow, what was I doing?)
- Context switch (work on teaching, forget R package state)

### Solution: External Memory

**ecosystem remember:**

```bash
ecosystem remember "Adding S7 support to medfit, next update probmed tests"
```

**What it saves:**
```json
{
  "timestamp": "2025-12-10T14:32:00",
  "project": "medfit",
  "directory": "/Users/dt/projects/r-packages/active/medfit",
  "branch": "S7-migration",
  "message": "Adding S7 support to medfit, next update probmed tests",
  "open_files": [
    "src/fit_mediation.R",
    "tests/testthat/test-s7-classes.R"
  ],
  "uncommitted_files": [
    "src/fit_mediation.R"
  ]
}
```

**ecosystem recall:**

```bash
ecosystem recall
```

**What it does:**
1. cd to saved directory
2. git checkout saved branch
3. Open saved files in $EDITOR
4. Display your message
5. Show uncommitted files
6. Continue where you left off

**Output:**
```
Recalling state from 2025-12-10 14:32

Project: medfit
Branch: S7-migration
Directory: /Users/dt/projects/r-packages/active/medfit

Your note:
  "Adding S7 support to medfit, next update probmed tests"

Uncommitted files:
  • src/fit_mediation.R

Opening files in editor:
  • src/fit_mediation.R
  • tests/testthat/test-s7-classes.R

✓ Context restored - continue working
```

### Advanced: State Stack

**Multiple context switches:**

```bash
# Working on medfit
ecosystem remember "Medfit S7 migration"

# Switch to teaching (urgent)
cd ~/teaching
ecosystem remember "Grade exam 2, update week 7 lecture"

# Switch to fixing bug in rmediation
cd ~/projects/r-packages/active/rmediation
ecosystem remember "Fix CI interval bug"

# Now recall
ecosystem recall      # Returns to rmediation (most recent)
ecosystem recall 1    # Returns to teaching (second most recent)
ecosystem recall 2    # Returns to medfit (third most recent)
```

**Visual:**
```
State Stack:
[2] medfit - "Medfit S7 migration" (2 days ago)
[1] teaching - "Grade exam 2, update week 7 lecture" (1 hour ago)
[0] rmediation - "Fix CI interval bug" (current)
```

---

## Technical Details

### Remotes Field Deep Dive

**What is Remotes?**

Field in DESCRIPTION file that tells R package installers (remotes, pak, devtools) where to find packages that aren't on CRAN.

**Supported by:**
- ✅ devtools::install()
- ✅ remotes::install_github(), install_local()
- ✅ pak::pkg_install()
- ❌ install.packages() (base R - doesn't understand Remotes)

**Syntax:**

```r
# Local path
Remotes: local::/path/to/package

# GitHub
Remotes: github::username/repo

# GitHub with branch
Remotes: github::username/repo@branch

# GitLab
Remotes: gitlab::username/repo

# Bitbucket
Remotes: bitbucket::username/repo

# Git URL
Remotes: git::https://github.com/username/repo.git

# Multiple packages
Remotes:
    local::/path/to/package1,
    github::username/package2,
    github::other/package3@dev
```

**How it works internally:**

1. devtools/remotes reads DESCRIPTION
2. Sees Remotes field
3. For each package in Imports/Depends/Suggests:
   - Check if listed in Remotes
   - If yes: install from Remotes location
   - If no: install from CRAN

**Example:**

```r
# medsim/DESCRIPTION
Package: medsim
Imports:
    medfit (>= 0.1.0),
    ggplot2
Remotes:
    local::/Users/dt/projects/r-packages/active/medfit

# When installing medsim:
# 1. Install medfit from /Users/dt/projects/r-packages/active/medfit
# 2. Install ggplot2 from CRAN (not in Remotes)
# 3. Install medsim
```

**CRAN policy:**

```
❌ Packages on CRAN MUST NOT have Remotes field
✅ OK during development
✅ OK on GitHub repos
❌ WILL BE REJECTED by CRAN
```

**Workflow:**

```
Development:
  Add Remotes → Install → Test → Remove Remotes

CRAN submission:
  1. Dependencies must be on CRAN first
  2. Remove Remotes field
  3. Submit to CRAN
```

---

### revdepcheck Deep Dive

**What is revdepcheck?**

R package that checks if your package changes break packages that depend on it.

**Developed by:** r-lib team (same as devtools, usethis, etc.)

**How it works:**

1. **Find reverse dependencies**
   ```r
   # From CRAN database
   revdeps <- tools::package_dependencies("medfit",
                                         reverse = TRUE)
   # Returns packages that have medfit in Imports/Depends/Suggests
   ```

2. **Install your package**
   ```r
   # Install development version of medfit
   devtools::install("~/projects/r-packages/active/medfit")
   ```

3. **Test each reverse dependency**
   ```r
   for (pkg in revdeps) {
     # Install pkg (uses your dev medfit)
     install.packages(pkg, type = "source")

     # Run R CMD check
     rcmdcheck::rcmdcheck(pkg)

     # Compare to baseline (CRAN version results)
     # Report new failures
   }
   ```

4. **Report results**
   ```
   ✓ probmed: No new problems
   ✗ rmediation: 2 new failures
     - test-print-methods.R:12
     - test-confidence-intervals.R:45
   ```

**Key limitation:**

**revdepcheck only checks CRAN packages!**

```
Your situation:
- medfit NOT on CRAN
- probmed, rmediation, etc. NOT on CRAN
- All are local/GitHub packages

Result:
- revdepcheck finds 0 reverse dependencies
- Need custom local package checker instead
```

**Solution: ecosystem check-breaks**

Custom tool that:
- Checks local packages (not CRAN)
- Reads DESCRIPTION files in ~/projects/r-packages/active/
- Builds dependency graph manually
- Tests local packages with local dependencies

---

### Workspace Files Explained

**What is a VS Code Workspace?**

JSON file that defines a multi-root workspace (multiple project folders in one window).

**Normal VS Code:**
```
One window = One folder
~/projects/r-packages/active/medfit
```

**VS Code Workspace:**
```
One window = Multiple folders
├── medfit
├── probmed
├── rmediation
├── medrobust
├── medsim
└── mediationverse
```

**File format:**

```json
{
  "folders": [
    {
      "name": "1-medfit",
      "path": "./active/medfit"
    },
    {
      "name": "2-probmed",
      "path": "./active/probmed"
    }
  ],
  "settings": {
    "search.exclude": {
      "**/revdep": true,
      "**/.Rcheck": true
    },
    "terminal.integrated.cwd": "${workspaceFolder}",
    "r.lsp.enabled": true
  },
  "extensions": {
    "recommendations": [
      "reditorsupport.r",
      "quarto.quarto"
    ]
  }
}
```

**Benefits:**

1. **Cross-package navigation**
   ```
   Ctrl+P → search across ALL packages
   "fit_mediation" found in:
     - medfit/R/fit_mediation.R
     - probmed/tests/testthat/test-fit.R
     - medsim/vignettes/usage.Rmd
   ```

2. **Unified search**
   ```
   Ctrl+Shift+F → search all packages
   Find all uses of S7_mediation class
   ```

3. **Terminal per package**
   ```
   Terminal 1: ~/projects/r-packages/active/medfit
   Terminal 2: ~/projects/r-packages/active/probmed
   ```

4. **Shared settings**
   ```
   R LSP enabled for all packages
   Consistent formatting
   Same extensions
   ```

**ADHD benefits:**

- See all packages at once (external memory)
- No directory switching (reduce cognitive load)
- Search across packages (find things fast)
- Persistent state (reopens where you left off)

**How to use:**

```bash
# Create workspace
code ~/projects/r-packages/mediationverse-dev.code-workspace

# Save and reopen
# VS Code remembers:
# - Open files
# - Terminal state
# - Search history
# - Git status
```

---

## 🔄 Integration: How It All Works Together

### Workflow Example: Changing medfit API

**Scenario:** You want to change `fit_mediation()` from S3 to S7

**Without tools:**
```
1. Edit medfit code
2. Remember which packages use fit_mediation
3. cd to each package
4. Check if it breaks
5. Remember what broke where
6. Fix each package
7. Re-check everything
8. Hope you didn't miss anything
```

**With tools:**

```bash
# 1. Open workspace
code ~/projects/r-packages/mediationverse-dev.code-workspace

# 2. Make changes to medfit
# (Edit in VS Code)

# 3. Check what breaks
ecosystem check-breaks medfit

# Output:
✓ probmed - OK
✗ rmediation - 2 failures (auto-opens failing tests)
✓ medrobust - OK
✗ medsim - 1 failure (auto-opens failing test)

# 4. Fix rmediation (already open in editor)
# (Make changes)

# 5. Fix medsim (already open in editor)
# (Make changes)

# 6. Re-check
ecosystem check-breaks medfit

# Output:
✓ probmed - OK
✓ rmediation - OK (all fixed!)
✓ medrobust - OK
✓ medsim - OK (all fixed!)

# 7. Check overall status
ecosystem status-all

# Output:
1-medfit       [●] 3 uncommitted files
2-probmed      [✓] Clean
3-rmediation   [●] 2 uncommitted files
4-medrobust    [✓] Clean
5-medsim       [●] 1 uncommitted file
6-mediationverse [✓] Clean

# 8. Commit everything
cd ~/projects/r-packages/active/medfit
git add . && git commit -m "Migrate fit_mediation to S7"

cd ~/projects/r-packages/active/rmediation
git add . && git commit -m "Update for medfit S7 API"

cd ~/projects/r-packages/active/medsim
git add . && git commit -m "Update for medfit S7 API"
```

**Cognitive load:**
- External memory (tools track what breaks)
- Automation (tools test everything)
- Visual feedback (color-coded output)
- Automatic focus (opens relevant files)
- Clear completion (all green = done)

---

## 📚 Further Reading

### For R Package Development
- [R Packages book](https://r-pkgs.org/) - Hadley Wickham & Jenny Bryan
- [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html) - CRAN official guide

### For Dependency Management
- [pak package](https://pak.r-lib.org/) - Modern package installer
- [renv package](https://rstudio.github.io/renv/) - Project-local dependencies

### For ADHD Productivity
- [External Memory Systems](https://www.youtube.com/watch?v=videoid) - Why tools > brain
- [Reducing Decision Fatigue](https://jamesclear.com/decision-fatigue) - James Clear

---

**This document is reference material - read sections as needed**

**Quick reference:** `ACTION_QUICK_REF.md`
**Full restructure:** `ADHD_OPTIMIZED_RESTRUCTURE.md`
