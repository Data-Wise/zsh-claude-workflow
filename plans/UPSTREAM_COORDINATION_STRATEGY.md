# Upstream Development Coordination Strategy

> **Your Question:** When working on medsim (downstream), how do I coordinate with medfit, probmed, rmediation (upstream)?
> **Date:** 2025-12-10
> **Based on:** R package development best practices research

---

## 🎯 The Problem: Upstream Development

### Your Scenario

**When you work on medsim:**
```
medsim (what you're working on)
  ├─ Imports: medfit
  ├─ Imports: probmed
  └─ Imports: rmediation

All 3 dependencies are YOUR packages, under active development!
```

**The challenge:**
- You're developing medsim with new features
- You might need NEW features from medfit that don't exist yet
- You might discover bugs in probmed while testing medsim
- You want to test against development versions, not CRAN versions

**Key questions:**
1. How do I work on medsim using development versions of medfit/probmed/rmediation?
2. How do I make changes across multiple packages?
3. Should I use a workspace/project file?
4. How do I coordinate plans?

---

## 🔧 Solution 1: Local Development with Remotes Field

### The `Remotes` Field Approach

**Best for:** Temporary development against local versions

**Setup:**

```r
# medsim/DESCRIPTION (during development)
Package: medsim
Imports:
    medfit (>= 0.2.0.9000),  # Development version
    probmed,
    rmediation
Remotes:
    local::/Users/dt/projects/r-packages/active/medfit,
    local::/Users/dt/projects/r-packages/active/probmed,
    local::/Users/dt/projects/r-packages/active/rmediation
```

**How it works:**
```r
# Install medsim with local dependencies
devtools::install("~/projects/r-packages/active/medsim")

# devtools automatically:
# 1. Installs medfit from local path
# 2. Installs probmed from local path
# 3. Installs rmediation from local path
# 4. Then installs medsim
```

**⚠️ IMPORTANT:** Remove `Remotes` field before CRAN submission!

**Reference:** [remotes - Dependency Resolution](https://remotes.r-lib.org/articles/dependencies.html)

---

## 🔧 Solution 2: Project Workspace Approach

### Using a Project/Workspace File

**Best for:** Coordinated development across multiple packages

**Create:** `~/projects/r-packages/mediationverse-dev.code-workspace`

```json
{
  "folders": [
    { "path": "active/medfit", "name": "1-medfit (foundation)" },
    { "path": "active/probmed", "name": "2-probmed" },
    { "path": "active/rmediation", "name": "3-rmediation" },
    { "path": "active/medrobust", "name": "4-medrobust" },
    { "path": "active/medsim", "name": "5-medsim" },
    { "path": "active/mediationverse", "name": "6-mediationverse (meta)" }
  ],
  "settings": {
    "terminal.integrated.cwd": "${workspaceFolder}"
  }
}
```

**Benefits:**
- Open all 6 packages at once
- See file structure side-by-side
- Make changes across packages
- Numbered order shows dependency hierarchy

**Use in VS Code/RStudio:**
```bash
# VS Code
code ~/projects/r-packages/mediationverse-dev.code-workspace

# RStudio (open all in separate sessions)
# Or use Projects pane
```

---

## 🔧 Solution 3: Load All Dependencies Manually

### The `load_all()` Chain

**Best for:** Quick iteration during development

**Workflow:**

```r
# Terminal 1: Load foundation
cd ~/projects/r-packages/active/medfit
R
devtools::load_all()  # medfit loaded in memory

# Terminal 2: Load medsim (uses loaded medfit)
cd ~/projects/r-packages/active/medsim
R
devtools::load_all()  # medsim loaded, uses medfit from memory
```

**⚠️ Limitation:** `load_all()` doesn't always use in-memory dependencies correctly

**Reference:** [devtools::load_all()](https://devtools.r-lib.org/reference/load_all.html)

---

## 🔧 Solution 4: Install Local, Iterate Fast

### The Install-Test-Modify Loop

**Best for:** Testing integration between packages

**Workflow:**

```bash
# 1. Install upstream packages locally
cd ~/projects/r-packages/active/medfit
R -e "devtools::install()"  # Install medfit to local library

cd ~/projects/r-packages/active/probmed
R -e "devtools::install()"  # Install probmed to local library

# 2. Now work on medsim
cd ~/projects/r-packages/active/medsim
R
devtools::load_all()  # Uses installed versions of dependencies

# 3. Test
devtools::test()

# 4. Found bug in medfit? Go fix it:
cd ~/projects/r-packages/active/medfit
# Fix bug
R -e "devtools::install()"  # Reinstall

# 5. Back to medsim
cd ~/projects/r-packages/active/medsim
# Restart R session to pick up new medfit
R
devtools::load_all()
devtools::test()  # Test again
```

**Reference:** [remotes::install_local()](https://remotes.r-lib.org/reference/install_local.html)

---

## 📊 Comparison of Approaches

| Approach | Best For | Pros | Cons | Complexity |
|----------|----------|------|------|------------|
| **Remotes Field** | Active co-development | Automatic install of local deps | Must remove before CRAN | Medium |
| **Workspace File** | Visual organization | See all packages at once | Doesn't solve dependency loading | Low |
| **load_all() Chain** | Quick iteration | Fast, no install needed | Dependency loading issues | Medium |
| **Install-Test Loop** | Integration testing | Most realistic, like production | Slow, need to reinstall | High |

---

## 🎯 Recommended Workflow for MediationVerse

### Scenario 1: Developing New Feature in medsim

**You want to add a new simulation method to medsim**

**If it requires NEW features from medfit:**

```bash
# Step 1: Work on medfit first
cd ~/projects/r-packages/active/medfit
# Add new S7 class or method
devtools::test()
devtools::install()  # Install locally

# Step 2: Update medsim DESCRIPTION
# medsim/DESCRIPTION:
# Imports: medfit (>= 0.2.0.9000)  # Development version
# Remotes: local::/Users/dt/projects/r-packages/active/medfit

# Step 3: Work on medsim
cd ~/projects/r-packages/active/medsim
devtools::install()  # Installs local medfit automatically
devtools::load_all()
# Develop new feature using new medfit capabilities
devtools::test()

# Step 4: Before CRAN submission
# Remove Remotes field from medsim/DESCRIPTION
# Wait for medfit to be on CRAN
# Update Imports: medfit (>= 0.2.0)  # CRAN version
```

---

### Scenario 2: Bug in medfit Discovered While Using medsim

**You're testing medsim and discover medfit is broken**

**Workflow:**

```bash
# You're in medsim, running tests
cd ~/projects/r-packages/active/medsim
R
devtools::load_all()
devtools::test()
# Test failure! Problem is in medfit, not medsim

# Option A: Fix in same R session
devtools::load_all("~/projects/r-packages/active/medfit")
# Debug medfit
# Fix bug in medfit source files
devtools::test("~/projects/r-packages/active/medfit")
# Commit medfit fix

# Option B: Switch context
cd ~/projects/r-packages/active/medfit
# Fix bug
devtools::test()
devtools::install()  # Install fixed version

# Back to medsim
cd ~/projects/r-packages/active/medsim
# Restart R to pick up new medfit
devtools::load_all()
devtools::test()  # Should pass now
```

---

### Scenario 3: Coordinated Feature Across Multiple Packages

**You want to add a feature that spans medfit, probmed, and medsim**

**Example:** New effect size that requires:
- medfit: New S7 class
- probmed: Calculation method
- medsim: Simulation support

**Workflow:**

```bash
# Step 1: Create feature branch in all 3 repos
cd ~/projects/r-packages/active/medfit
git checkout -b feature/new-effect-size

cd ~/projects/r-packages/active/probmed
git checkout -b feature/new-effect-size

cd ~/projects/r-packages/active/medsim
git checkout -b feature/new-effect-size

# Step 2: Open workspace
code ~/projects/r-packages/mediationverse-dev.code-workspace
# Now you can see all 3 packages side-by-side

# Step 3: Develop in order (foundation → specialized)
# a. medfit: Add S7 class
# b. Install: R -e "devtools::install('~/projects/r-packages/active/medfit')"
# c. probmed: Add calculation using new class
# d. Install: R -e "devtools::install('~/projects/r-packages/active/probmed')"
# e. medsim: Add simulation support
# f. Test: R -e "devtools::test('~/projects/r-packages/active/medsim')"

# Step 4: Use Remotes field during development
# medsim/DESCRIPTION:
# Remotes:
#   local::/Users/dt/projects/r-packages/active/medfit@feature/new-effect-size
#   local::/Users/dt/projects/r-packages/active/probmed@feature/new-effect-size

# Step 5: Test integration
devtools::test()
devtools::check()

# Step 6: Merge in order
# a. Merge medfit feature branch → main
# b. Merge probmed feature branch → main
# c. Merge medsim feature branch → main
```

---

## 📋 Coordination with Planning

### How to Coordinate Plans Across Packages

**Problem:** You need to track "new effect size feature" across 3 packages

**Solution:** Use data-wise project tracking

**Create:** `data-wise/planning/FEATURE_TRACKING.md`

```markdown
# Feature: New Effect Size Support

**Status:** In Development
**Target:** Q1 2025
**Packages Affected:** medfit, probmed, medsim

## Tasks

### medfit
- [ ] Add `NewEffectSize` S7 class
- [ ] Add `compute_new_effect()` method
- [ ] Tests for new class
- **Branch:** `feature/new-effect-size`
- **Status:** In progress

### probmed
- [ ] Add `pmed_new_effect()` calculation
- [ ] Integrate with NewEffectSize class
- [ ] Update vignettes
- **Branch:** `feature/new-effect-size`
- **Status:** Not started (waiting for medfit)

### medsim
- [ ] Add simulation support
- [ ] Add examples
- **Branch:** `feature/new-effect-size`
- **Status:** Not started (waiting for probmed)

## Release Plan
1. Complete medfit → merge → release
2. Complete probmed → merge → release (depends on medfit CRAN)
3. Complete medsim → merge → release (depends on probmed CRAN)
```

**Track with ecosystem command:**

```bash
# New command: ecosystem feature-status
ecosystem feature-status new-effect-size
# Output:
# Feature: New Effect Size Support
# medfit: ● In progress (50% complete)
# probmed: ○ Waiting for medfit
# medsim: ○ Waiting for probmed
```

---

## 🚀 Automation with zsh-claude-workflow

### New Commands for Upstream Coordination

**1. Setup development workspace:**

```bash
# commands/ecosystem-workspace
ecosystem workspace mediationverse create
# → Creates .code-workspace file
# → Opens in editor

ecosystem workspace mediationverse sync
# → Installs all packages in dependency order
# → Sets up Remotes fields for local development
```

**2. Install all dependencies:**

```bash
# commands/ecosystem-install
ecosystem install-deps medsim
# → Finds all local dependencies (medfit, probmed, rmediation)
# → Installs them in dependency order
# → Installs medsim
# → Runs tests to verify
```

**3. Coordinated feature development:**

```bash
# commands/ecosystem-feature
ecosystem feature start new-effect-size --packages medfit,probmed,medsim
# → Creates feature branches in all 3 packages
# → Updates data-wise/FEATURE_TRACKING.md
# → Sets up Remotes fields

ecosystem feature status new-effect-size
# → Shows progress across packages

ecosystem feature test new-effect-size
# → Tests all packages in dependency order
# → Reports integration issues
```

**4. Development iteration:**

```bash
# commands/ecosystem-dev
ecosystem dev-loop medsim
# → Watches for changes in medfit, probmed, rmediation
# → Auto-reinstalls when they change
# → Reruns medsim tests
# → Like hot-reload for R packages!
```

---

## 📊 Monorepo vs Multi-Repo for MediationVerse

### Should You Use a Monorepo?

**Your Current Setup:** Multi-repo (6 separate repos)

**Monorepo Consideration:**

```
mediationverse-monorepo/
├── packages/
│   ├── medfit/
│   ├── probmed/
│   ├── rmediation/
│   ├── medrobust/
│   ├── medsim/
│   └── mediationverse/
├── .github/workflows/
│   └── check-all.yml  # Check all packages
└── README.md
```

**Pros:**
- ✅ Coordinated changes in one commit
- ✅ Easier to track cross-package features
- ✅ Single CI/CD pipeline
- ✅ Direct dependency references

**Cons:**
- ❌ Not common in R ecosystem
- ❌ CRAN expects separate repos
- ❌ GitHub releases more complex
- ❌ Migration effort

**Recommendation:** Stay with multi-repo, but use automation to simulate monorepo benefits.

**Reference:** [Creating a monorepo of R packages](https://blog.insileco.io/2023/11/23/creating-a-monorepo-of-r-packages-with-github/)

---

## 🎯 Recommended Approach for YOU

Based on your workflow (scattered work, independent releases):

### Daily Development Workflow

**Option A: Workspace + Install Loop (Recommended)**

```bash
# 1. Open workspace when working on multiple packages
code ~/projects/r-packages/mediationverse-dev.code-workspace

# 2. When working on medsim:
cd ~/projects/r-packages/active/medsim

# 3. If you need dev version of medfit:
# Add to medsim/DESCRIPTION:
# Remotes: local::/Users/dt/projects/r-packages/active/medfit

# 4. Install medsim (auto-installs local medfit)
R -e "devtools::install()"

# 5. Develop and test
R -e "devtools::load_all(); devtools::test()"

# 6. Before CRAN: Remove Remotes field
```

**Why this works:**
- ✅ Matches your scattered work style
- ✅ Uses standard R tools (Remotes, devtools)
- ✅ Easy to understand
- ✅ Works with independent releases

---

### Coordinated Feature Workflow

**For cross-package features:**

```bash
# 1. Plan in data-wise
# Create planning/features/new-effect-size.md

# 2. Create feature branches
cd ~/projects/r-packages/active/medfit
git checkout -b feature/new-effect-size

cd ~/projects/r-packages/active/probmed
git checkout -b feature/new-effect-size

# 3. Use automation (we'll build this)
ecosystem feature track new-effect-size --packages medfit,probmed,medsim

# 4. Develop in dependency order
# Work on medfit first → install
# Work on probmed next → install
# Work on medsim last → test integration

# 5. Track progress
ecosystem feature status new-effect-size
```

---

## ✅ Immediate Action Items

### This Week: Setup Workspace

1. **Create workspace file:**
   ```bash
   cat > ~/projects/r-packages/mediationverse-dev.code-workspace <<EOF
   {
     "folders": [
       { "path": "active/medfit", "name": "1-medfit" },
       { "path": "active/probmed", "name": "2-probmed" },
       { "path": "active/rmediation", "name": "3-rmediation" },
       { "path": "active/medrobust", "name": "4-medrobust" },
       { "path": "active/medsim", "name": "5-medsim" },
       { "path": "active/mediationverse", "name": "6-mediationverse" }
     ]
   }
   EOF
   ```

2. **Try Remotes field:**
   ```r
   # Next time you need to use dev version of medfit in medsim:
   # Add to medsim/DESCRIPTION:
   # Remotes: local::/Users/dt/projects/r-packages/active/medfit

   devtools::install("~/projects/r-packages/active/medsim")
   # → Automatically installs local medfit!
   ```

3. **Test the workflow:**
   - Make a small change to medfit
   - Use it in medsim with Remotes field
   - See if it works smoothly

### Next Week: Automate

4. **Build ecosystem commands:**
   - `ecosystem workspace create mediationverse`
   - `ecosystem install-deps <package>`
   - `ecosystem feature track <feature>`

---

## 📚 References

1. [devtools::load_all()](https://devtools.r-lib.org/reference/load_all.html)
2. [pkgload Package](https://pkgload.r-lib.org/reference/load_all.html)
3. [remotes - Dependency Resolution](https://remotes.r-lib.org/articles/dependencies.html)
4. [remotes::install_local()](https://remotes.r-lib.org/reference/install_local.html)
5. [R Packages - Dependencies in Practice](https://r-pkgs.org/dependencies-in-practice.html)
6. [Creating a monorepo of R packages](https://blog.insileco.io/2023/11/23/creating-a-monorepo-of-r-packages-with-github/)

---

## 💬 Discussion Points

1. **Have you tried the Remotes field before?**
2. **Would a workspace file help your workflow?**
3. **Do you often work across multiple packages at once?**
4. **Should we build `ecosystem feature` commands?**
5. **How do you currently track cross-package features?**

---

**Summary:** Use Remotes field + workspace file + automation to coordinate upstream dependencies!
