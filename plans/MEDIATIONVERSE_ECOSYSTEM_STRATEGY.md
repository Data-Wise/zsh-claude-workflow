# MediationVerse Ecosystem Dependency Management Strategy

> **Based on:** tidyverse, r-lib, and CRAN best practices research
> **Date:** 2025-12-10
> **Your Current Challenge:** Coordinating upstream/downstream changes across 6 packages

---

## 📊 Your Current Ecosystem Structure

### Package Dependency Map

```
mediationverse (meta-package)
    ├─ Imports: medfit, probmed, rmediation, medrobust, medsim
    └─ Purpose: Easy install of all packages

medfit (foundation)
    ├─ Role: Infrastructure/base classes (S7)
    └─ Downstream: probmed, rmediation, medrobust, medsim depend on this

probmed (P_med methods)
    ├─ Imports: medfit
    └─ Role: Effect size calculations

rmediation (CI methods)
    ├─ Imports: medfit
    └─ Role: Confidence intervals

medrobust (sensitivity)
    ├─ Imports: medfit, probmed?, rmediation?
    └─ Role: Sensitivity analysis

medsim (simulation)
    ├─ Imports: medfit, probmed?, rmediation?
    └─ Role: Simulation studies

missingmed (missing data)
    ├─ Status: scratch/early development
    └─ Role: Missing data methods
```

**Your Pain Point:** When medfit changes, you don't know how it affects the 5 downstream packages.

---

## 🎯 Best Practices from Successful Ecosystems

### 1. tidyverse Approach

**Meta-Package Philosophy:**
- tidyverse is purely for **installation convenience**
- **Other packages should NOT depend on tidyverse** (use specific packages like dplyr, ggplot2)
- Uses `Imports:` not `Depends:` to avoid namespace conflicts

**For MediationVerse:**
- ✅ mediationverse should be `Imports:` only, no code
- ✅ Other packages should depend on specific packages (medfit, probmed) not mediationverse
- ✅ mediationverse version should track the ecosystem state

**Reference:** [tidyverse dependency philosophy](https://tidyverse.org/blog/2019/05/itdepends/)

---

### 2. Reverse Dependency Checking (THE KEY TOOL!)

**Tools Available:**

#### **revdepcheck** (r-lib standard)
```r
# Install
install.packages("revdepcheck")

# In medfit/ directory:
revdepcheck::revdep_check(num_workers = 4)
```

**What it does:**
1. Finds all packages that depend on medfit (probmed, rmediation, etc.)
2. Runs `R CMD check` with CRAN version of medfit
3. Runs `R CMD check` with your NEW local version of medfit
4. Reports **differences** - new problems you introduced

**Output:** Shows exactly which downstream packages break with your changes!

**Reference:** [revdepcheck documentation](https://revdepcheck.r-lib.org/)

---

#### **crandalf** (GitHub Actions automation)
```yaml
# .github/workflows/revdep-check.yml
# Automatically checks reverse deps on every PR
```

**What it does:**
- Runs on GitHub Actions (cloud)
- Checks all reverse dependencies automatically
- Comments on PRs with results

**Reference:** [crandalf by Yihui Xie](https://yihui.org/en/2021/06/crandalf/)

---

### 3. Dependency Management Strategy

**From R Packages book:**

**Use `Imports:` for runtime dependencies:**
```r
# In probmed/DESCRIPTION:
Imports:
    medfit (>= 0.2.0),   # Specify minimum version when needed
    checkmate,
    S7
```

**Use `Suggests:` for optional/development:**
```r
Suggests:
    testthat (>= 3.0.0),
    rmediation,   # Optional - for comparison tests
    knitr,
    rmarkdown
```

**NEVER use `Depends:` in modern packages** (except R version)

**Reference:** [R Packages - Dependencies in Practice](https://r-pkgs.org/dependencies-in-practice.html)

---

### 4. Version Coordination Strategy

**Tidyverse Policy:**
- Specify minimum version **only when using new features**
- Example: `medfit (>= 0.2.0)` when you use a feature added in 0.2.0
- Don't over-specify versions unless necessary

**For MediationVerse:**
```r
# probmed/DESCRIPTION
Imports:
    medfit (>= 0.1.0)  # Only specify when you need a specific feature
```

**Reference:** [R Packages - Version Requirements](https://r-pkgs.org/dependencies-mindset-background.html)

---

## 🔧 Proposed Workflow for MediationVerse

### Scenario 1: Updating medfit (Foundation Package)

**Current Problem:** You change medfit, don't know what breaks downstream.

**Proposed Solution:**

```r
# In medfit/ directory
# 1. Make your changes to medfit

# 2. Before committing, run reverse dependency check
revdepcheck::revdep_check(num_workers = 4)

# 3. Review results
revdepcheck::revdep_report()

# Output shows:
# ✓ probmed: No new problems
# ✗ rmediation: 2 new failures (shows exactly what broke)
# ✓ medrobust: No new problems
# ✗ medsim: 1 new warning
```

**Now you know:**
- rmediation needs updates to work with new medfit
- medsim has a new warning to investigate
- probmed and medrobust are fine

**Action:**
1. Fix rmediation to work with new medfit (or revert medfit change)
2. Investigate medsim warning
3. Document breaking changes in medfit NEWS.md
4. Coordinate releases

---

### Scenario 2: Adding New Feature to medfit

**Workflow:**

```r
# 1. Add feature to medfit (e.g., new S7 class)

# 2. Update medfit version
# DESCRIPTION: Version: 0.2.0 (was 0.1.0)

# 3. Run reverse dep check
revdepcheck::revdep_check()

# 4. If downstream packages need the new feature:
# Update probmed/DESCRIPTION:
# Imports: medfit (>= 0.2.0)

# 5. Release order:
# a. Submit medfit 0.2.0 to CRAN
# b. Wait for CRAN acceptance
# c. Update probmed to require medfit >= 0.2.0
# d. Submit probmed to CRAN
```

---

### Scenario 3: Breaking Changes in medfit

**Best Practice:** Avoid breaking changes, but if necessary:

```r
# 1. Document in medfit NEWS.md:
# medfit 0.3.0
# BREAKING CHANGES
# * renamed estimate_effect() to compute_effect()
# * old function deprecated, will be removed in 0.4.0

# 2. Implement deprecation warnings
estimate_effect <- function(...) {
  lifecycle::deprecate_warn(
    when = "0.3.0",
    what = "estimate_effect()",
    with = "compute_effect()"
  )
  compute_effect(...)
}

# 3. Give downstream packages time to update
# - Release medfit 0.3.0 with deprecation warning
# - Contact probmed, rmediation maintainers (that's you!)
# - Update downstream packages
# - Remove old function in medfit 0.4.0
```

**Reference:** [lifecycle package for deprecations](https://lifecycle.r-lib.org/)

---

## 🚀 Automation Strategy for MediationVerse

### Tool 1: Automated Reverse Dependency Checking

**Setup crandalf for medfit:**

```yaml
# medfit/.github/workflows/revdep-check.yml
name: Reverse Dependency Check

on:
  pull_request:
    branches: [main]

jobs:
  revdep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: r-lib/actions/setup-r@v2
      - name: Check reverse dependencies
        run: |
          install.packages("revdepcheck")
          revdepcheck::revdep_check(num_workers = 2)
```

**Now:** Every PR to medfit automatically checks probmed, rmediation, etc.!

---

### Tool 2: Ecosystem Status Dashboard

**Create in data-wise repo:**

```markdown
# planning/MEDIATIONVERSE_STATUS.md

| Package | Version | CRAN | Depends on | Status | Last Check |
|---------|---------|------|------------|--------|------------|
| medfit  | 0.1.0   | ✗    | -          | Dev    | 2025-12-10 |
| probmed | 1.0.0   | ✗    | medfit     | Ready  | 2025-12-10 |
| rmediation | 1.0.8 | ✓  | medfit     | CRAN   | 2025-12-10 |
| medrobust | 0.1.0 | ✗    | medfit     | Dev    | 2025-12-10 |
| medsim  | 0.1.0   | ✗    | medfit     | Dev    | 2025-12-10 |
| mediationverse | 0.1.0 | ✗ | all    | Meta   | 2025-12-10 |
```

**Automated with zsh-claude-workflow:**

```bash
# New command:
ecosystem mediationverse-status
# → Updates MEDIATIONVERSE_STATUS.md
# → Checks CRAN status
# → Shows dependency health
```

---

### Tool 3: Coordinated Release Workflow

**New zsh-claude-workflow command:**

```bash
# Check if medfit changes break downstream
ecosystem check-revdeps medfit

# Output:
# Checking reverse dependencies of medfit...
# ✓ probmed: OK
# ✗ rmediation: 2 failures
#   - test-bootstrap.R:45 - expects estimate_effect(), got compute_effect()
#   - vignette build failure
# ✓ medrobust: OK
# ⚠ medsim: 1 warning (non-breaking)

# Prepare coordinated release
ecosystem prepare-release medfit
# → Creates release checklist
# → Identifies affected packages
# → Suggests release order
```

---

## 📋 Practical Implementation Plan

### Phase 1: Set Up Reverse Dependency Checking (1 hour)

```bash
# 1. Install revdepcheck
cd ~/projects/r-packages/active/medfit
Rscript -e "install.packages('revdepcheck')"

# 2. Run initial check
Rscript -e "revdepcheck::revdep_check(num_workers = 4)"

# 3. Review results
Rscript -e "revdepcheck::revdep_report()"

# 4. Add to .gitignore
echo "revdep/" >> .gitignore
```

**Do this for:** medfit (most important), probmed, rmediation

---

### Phase 2: Document Dependencies (30 min)

**Create dependency map:**

```bash
# In data-wise repo
# planning/DEPENDENCY_MAP.md

## MediationVerse Dependency Graph

medfit (foundation)
├── probmed depends on medfit
├── rmediation depends on medfit
├── medrobust depends on medfit
├── medsim depends on medfit, probmed, rmediation
└── mediationverse imports all

## Dependency Rules

1. **medfit changes**: Always run revdepcheck before CRAN
2. **probmed/rmediation changes**: Check if medsim affected
3. **Breaking changes**: Deprecation cycle required
4. **CRAN releases**: Foundation → Specialized → Meta (order)
```

---

### Phase 3: Automate with zsh-claude-workflow (2 hours)

**New ecosystem commands:**

```bash
# commands/ecosystem-revdep
ecosystem revdep medfit
# → Runs revdepcheck::revdep_check()
# → Summarizes results
# → Updates data-wise/DEPENDENCY_MAP.md

# commands/ecosystem-release
ecosystem release-prep medfit
# → Checks reverse deps
# → Suggests release order
# → Creates CRAN submission checklist
```

---

### Phase 4: GitHub Actions (1 hour)

**Add to medfit, probmed, rmediation:**

```yaml
# .github/workflows/revdep.yml
name: Check Reverse Dependencies

on:
  pull_request:
  push:
    branches: [main, dev]

jobs:
  revdep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: r-lib/actions/setup-r@v2
      - name: Install revdepcheck
        run: install.packages("revdepcheck")
        shell: Rscript {0}
      - name: Check reverse deps
        run: revdepcheck::revdep_check(num_workers = 2)
        shell: Rscript {0}
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: revdep-results
          path: revdep/
```

---

## 🎯 Your Specific Workflow

### Current Reality (Scattered Work)

**You said:**
- You work on packages scattered (not all at once)
- You try to inform other packages when one changes
- You don't know how to coordinate upstream/downstream changes
- You release independently

**Problem:** When you change medfit on Monday, you don't discover it breaks rmediation until Friday when you work on rmediation.

---

### Proposed Workflow

**When you work on medfit:**

```bash
# 1. Make changes to medfit
cd ~/projects/r-packages/active/medfit

# 2. Before committing, check downstream impact
Rscript -e "revdepcheck::revdep_check()"

# 3. If problems found:
# - Fix downstream packages immediately, OR
# - Adjust medfit changes, OR
# - Document breaking change

# 4. Commit medfit with knowledge of downstream impact
git commit -m "feat: add new S7 class (breaks rmediation - fix pending)"

# 5. Update ecosystem status
cd ~/projects/dev-tools/zsh-claude-workflow
./commands/ecosystem mediationverse-status
# → Updates data-wise/MEDIATIONVERSE_STATUS.md
```

**Now you know immediately** if your change affects other packages!

---

### Coordinated Release Workflow

**Scenario: Ready to release medfit to CRAN**

```bash
# 1. Final reverse dep check
cd ~/projects/r-packages/active/medfit
Rscript -e "revdepcheck::revdep_check()"
# → All green? Good to go!
# → Problems? Fix downstream first

# 2. Check which packages need updates
ecosystem release-plan medfit
# Output:
# medfit 0.2.0 → CRAN
# ├─ probmed needs update (uses new feature) → Queue for release
# ├─ rmediation OK (no changes needed)
# ├─ medrobust needs update (uses new feature) → Queue for release
# └─ medsim OK (no changes needed)
#
# Suggested release order:
# 1. medfit 0.2.0 → CRAN (wait for acceptance)
# 2. probmed 1.1.0 + medrobust 0.2.0 → CRAN (parallel OK)
# 3. mediationverse 0.2.0 → CRAN (after all deps accepted)

# 3. Execute releases in order
# ... (existing CRAN workflow)
```

---

## 📊 Tool Recommendations

### Essential (Implement First)

1. **revdepcheck** - Local reverse dependency checking
   - Use before every medfit commit
   - Run before CRAN submissions
   - **Time saved:** Know immediately what breaks (vs discovering weeks later)

2. **ecosystem mediationverse-status** - Dashboard
   - Shows package status at a glance
   - Tracks CRAN versions vs local
   - **Time saved:** No manual tracking

### Nice to Have (Implement Later)

3. **crandalf** - Automated GitHub Actions checking
   - Runs on every PR
   - Cloud-based, no local resources
   - **Benefit:** Automated, can't forget

4. **ecosystem release-plan** - Coordinated release planning
   - Suggests release order
   - Identifies dependencies
   - **Benefit:** Prevents "oops, forgot to update X"

---

## 🎯 Immediate Action Items

### This Week

1. **Install revdepcheck in medfit:**
   ```r
   install.packages("revdepcheck")
   revdepcheck::revdep_check()  # First run!
   ```

2. **Document current dependency map:**
   - Create `data-wise/planning/DEPENDENCY_MAP.md`
   - List which packages depend on which

3. **Test workflow:**
   - Make a small change to medfit
   - Run revdepcheck
   - See what it tells you

### Next Week

4. **Add ecosystem command:**
   - `ecosystem revdep <package>`
   - Wraps revdepcheck with nicer output

5. **Create status dashboard:**
   - `ecosystem mediationverse-status`
   - Auto-update MEDIATIONVERSE_STATUS.md

---

## ✅ Success Metrics

**You'll know this works when:**

- ✅ You change medfit and **immediately know** what breaks
- ✅ You can release medfit to CRAN **confidently** (no surprises)
- ✅ You have a dashboard showing ecosystem health
- ✅ You coordinate releases **systematically** not ad-hoc
- ✅ You spend **less time debugging** "why did X break?"

---

## 📚 References

1. [R Packages - Dependencies Philosophy](https://r-pkgs.org/dependencies-mindset-background.html)
2. [tidyverse - It Depends (Dependency Philosophy)](https://tidyverse.org/blog/2019/05/itdepends/)
3. [revdepcheck Documentation](https://revdepcheck.r-lib.org/)
4. [crandalf - Automated Reverse Dependency Checking](https://yihui.org/en/2021/06/crandalf/)
5. [R Packages - Dependencies in Practice](https://r-pkgs.org/dependencies-in-practice.html)
6. [Creating Your Own Package Verse](https://www.jdtrat.com/blog/creating-your-own-package-verse/)

---

## 💬 Next Discussion Points

Based on this research, let's discuss:

1. **Do you want to try revdepcheck this week?** (15 min to set up)
2. **Should we build ecosystem commands for this?** (automate the workflow)
3. **How often do you actually break downstream packages?** (to gauge urgency)
4. **Do you want coordinated releases or independent?** (affects tooling)

**What resonates most with your workflow?**
