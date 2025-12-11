# Complete Restructuring Summary

> **Date:** 2025-12-10
> **Scope:** Local projects, Cloud storage, GitHub repositories
> **Goal:** ADHD-optimized organization with zero search time

---

## 🎯 Executive Summary

### Current State: SCATTERED & CHAOTIC

**Local Projects:** Mixed across 5 directories
**Cloud Storage:** Research in 2-3 cloud locations
**GitHub:** 6 projects missing from GitHub, inconsistent structure

**ADHD Impact:**
- 10-18 min/session wasted searching
- 3-6 hours/month lost to disorganization
- High cognitive load from mental tracking

### Target State: UNIFIED & CLEAR

**Local Projects:** Single hierarchy in `~/projects/`
**Cloud Storage:** Backup only, not primary workspace
**GitHub:** All projects published with consistent structure

**ADHD Benefit:**
- <10 seconds to find anything
- External memory (tools track everything)
- Clear hierarchy (active > planning > archive)

---

## 📊 Part 1: Local Projects Restructure

### Current Local Structure (BEFORE)

```
~/
├── projects/
│   ├── apps/
│   ├── dev-tools/
│   ├── quarto/
│   ├── r-packages/
│   └── research/              ← Only 1 project here!
│
├── Dropbox/Research/          ← 45+ projects scattered!
│
├── Library/CloudStorage/
│   └── GoogleDrive-*/My Drive/research/  ← Some projects here
│
└── teaching/                  ← Doesn't exist yet
```

**Problems:**
- Research scattered across 3 locations
- No clear active vs archive distinction
- Teaching mixed with research
- Can't see what's important at a glance

### Target Local Structure (AFTER)

```
~/
├── projects/                  ← Primary workspace (local, fast)
│   │
│   ├── apps/                  ← Applications
│   │   ├── examify/
│   │   │   ├── src/
│   │   │   ├── _dev-notes.md
│   │   │   └── _deployment.md
│   │   └── _active.md         ← Which app am I working on?
│   │
│   ├── dev-tools/             ← Infrastructure
│   │   ├── zsh-claude-workflow/
│   │   ├── claude-statistical-research/
│   │   ├── claude-r-dev/
│   │   ├── emacs-r-devkit/
│   │   └── _infrastructure-status.md
│   │
│   ├── quarto/                ← Quarto projects
│   │   ├── extensions/
│   │   │   ├── unm-revealjs/
│   │   │   └── examark/
│   │   ├── presentations/
│   │   │   ├── 2025/
│   │   │   └── 2026/
│   │   └── extensions.code-workspace
│   │
│   ├── r-packages/            ← R packages
│   │   ├── active/            ← Currently developing
│   │   │   ├── medfit/
│   │   │   ├── probmed/
│   │   │   ├── rmediation/
│   │   │   ├── medrobust/
│   │   │   ├── medsim/
│   │   │   └── mediationverse/
│   │   ├── stable/            ← Production ready
│   │   ├── archive/           ← Old/deprecated
│   │   ├── scratch/           ← Experiments
│   │   └── mediationverse-dev.code-workspace
│   │
│   └── research/              ← Research projects (UNIFIED HERE)
│       ├── _dashboard.md      ← What's active, what's next
│       │
│       ├── active/            ← Max 3 projects (ADHD limit)
│       │   ├── product-of-three/
│       │   │   ├── manuscript/
│       │   │   ├── simulations/
│       │   │   ├── literature/
│       │   │   ├── data/
│       │   │   └── _next.md
│       │   ├── collider/
│       │   └── pmed/
│       │
│       ├── planning/          ← Future work (not started)
│       │   ├── missing-effect/
│       │   ├── sensitivity-methods/
│       │   └── interventional-mediation/
│       │
│       ├── in-review/         ← Submitted papers
│       │   └── bootstrap-ci-jasa-2025/
│       │       ├── manuscript/
│       │       ├── reviews/
│       │       └── _status.md
│       │
│       ├── published/         ← Completed & published
│       │   ├── 2023-lc-mediation/
│       │   └── 2024-serial-mediation/
│       │
│       ├── collaborations/    ← Joint projects
│       │   └── dave-chapter/
│       │
│       └── archive/           ← Old/inactive
│           └── pilot-studies/
│
└── teaching/                  ← Teaching (separate context)
    ├── courses/
    │   ├── stats-415/
    │   │   ├── week-01/
    │   │   │   ├── lecture.qmd
    │   │   │   ├── homework.qmd
    │   │   │   └── _checklist.md
    │   │   ├── week-02/
    │   │   └── ...
    │   ├── stats-535/
    │   └── stats-630/
    │
    ├── materials/             ← Shared across courses
    │   ├── datasets/
    │   ├── templates/
    │   └── examples/
    │
    └── generated/             ← Auto-generated by examify
        ├── exams/
        ├── quizzes/
        └── homework/
```

### Key Principles

1. **Single source of truth:** Everything in `~/projects/` or `~/teaching/`
2. **Clear hierarchy:** active > planning > in-review > published > archive
3. **ADHD limits:** Max 3 active projects in research/active/
4. **Context separation:** Teaching ≠ Research ≠ Development
5. **Next actions:** Every active project has `_next.md`
6. **Visual status:** Dashboard shows everything at a glance

---

## ☁️ Part 2: Cloud Storage Restructure

### Current Cloud Storage (BEFORE)

**Problem:** Cloud is PRIMARY workspace

```
~/Dropbox/Research/
├── [45+ projects mixed together]
├── published/
├── past/
├── future/
└── [Loose files everywhere]

~/Library/CloudStorage/GoogleDrive-*/My Drive/research/
└── [Some projects here too]

~/Library/CloudStorage/OneDrive-UniversityofNewMexico/
└── [Work files, maybe research?]
```

**ADHD Issues:**
- Cloud storage is SLOW (sync delays)
- Scattered across multiple services
- No clear primary location
- Duplicate files across clouds?

### Target Cloud Storage (AFTER)

**Principle:** Cloud is BACKUP, not primary workspace

> **Updated 2025-12-10:** Migrating FROM Dropbox (cost), TO Google Drive for backup

```
~/Library/CloudStorage/GoogleDrive-*/
└── My Drive/
    ├── Backup/                  ← Automatic backup (Google Drive app)
    │   ├── projects/            ← Mirror of ~/projects/
    │   └── teaching/            ← Mirror of ~/teaching/
    │
    ├── Collaborations/          ← Only for shared docs
    └── University-Admin/        ← Only for admin files

~/Library/CloudStorage/OneDrive-UniversityofNewMexico/
└── Work-Admin/                  ← Only for UNM work files

~/Dropbox/                       ← MIGRATING AWAY (cost)
└── Archive-Old-Research/        ← Temporary: OLD scattered research
    └── [Pre-2025 research, will be deleted after migration]
```

### Cloud Strategy (REVISED)

| Service | Purpose | What Goes Here | Status |
|---------|---------|----------------|--------|
| **Google Drive** | Primary backup | Automatic backup of ~/projects/ and ~/teaching/ | ✅ Active |
| **Google Drive** | Collaboration | Only shared docs, no primary work | ✅ Active |
| **OneDrive (UNM)** | University admin | Only UNM administrative files | ✅ Active |
| **Dropbox** | DEPRECATED | Migrating away due to cost | ⚠️ Phasing out |

**Rules:**
1. ✅ Local is PRIMARY (fast, no sync issues)
2. ✅ Cloud is BACKUP (automatic via Google Drive app)
3. ✅ Never edit files in cloud directly
4. ✅ Let Google Drive app handle sync (no manual scripts needed)

**Setup:**
```bash
# Google Drive app already installed and configured
# Set up Backup & Sync to back up:
#   - ~/projects/
#   - ~/teaching/

# In Google Drive app settings:
# 1. Open Google Drive preferences
# 2. Go to "Preferences" → "Folders from your computer"
# 3. Add folders to back up:
#    - ~/projects → backs up to My Drive/Backup/projects/
#    - ~/teaching → backs up to My Drive/Backup/teaching/

# That's it! No scripts needed.
```

### Migration Steps

**Phase 1: Freeze old research (2 hours)**

```bash
# Move scattered Dropbox research to archive
mkdir -p ~/Dropbox/Archive-Old-Research
mv ~/Dropbox/Research ~/Dropbox/Archive-Old-Research/Research-Pre-2025

# Now ~/Dropbox/Research is empty and ready for symlink
```

**Phase 2: Migrate active projects (3 hours, spread over week)**

```bash
# Move top 3 active projects to local
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/collider ~/projects/research/active/
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/pmed ~/projects/research/active/
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/product-of-three ~/projects/research/active/

# Create _next.md for each
for proj in ~/projects/research/active/*/; do
    cat > "$proj/_next.md" << EOF
# Next Actions

## Immediate (This Week)
- [ ] [Define next action]

## Soon (Next 2 Weeks)
- [ ] [Future task]

## Blocked/Waiting
- [ ] [If any]
EOF
done
```

**Phase 3: Setup automatic backup (5 min)**

```bash
# Configure Google Drive app to back up local folders
# (Already installed, just configure)

# 1. Open Google Drive app
# 2. Preferences → "Folders from your computer"
# 3. Click "Add folder" and select:
#    - ~/projects
#    - ~/teaching

# 4. Choose "Mirror files" or "Backup files" (recommended: Backup)
# 5. Click "Done"

# That's it! Google Drive app handles the rest automatically.

# Optional: Verify sync status
open "https://drive.google.com/drive/my-drive"
# Look for Backup/projects/ and Backup/teaching/
```

**Phase 4: Archive rest (1 hour)**

```bash
# Move planning projects to local
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/future/* ~/projects/research/planning/

# Move published to local
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/published/* ~/projects/research/published/

# Move past to local archive
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/past/* ~/projects/research/archive/

# Everything else to local archive (for now)
mv ~/Dropbox/Archive-Old-Research/Research-Pre-2025/* ~/projects/research/archive/
```

---

## 🐙 Part 3: GitHub Restructure

### Current GitHub State (BEFORE)

From data-wise/data-wise repository inventory:

**Published (14 repos):**
- medfit, probmed, rmediation, medrobust, medsim, mediationverse
- claude-statistical-research
- emacs-r-devkit, homebrew-tap
- docs-standards
- unm-revealjs, examark
- data-wise (tracking repo)
- claude-r-dev

**Missing from GitHub (6 repos):**
- ❌ zsh-claude-workflow ← This project!
- ❌ r-package-dev-gemini
- ❌ Several Quarto projects
- ❌ Other dev-tools

### Target GitHub State (AFTER)

> **Updated 2025-12-10:** zsh-claude-workflow and r-package-dev-gemini will be PRIVATE repos (personal workflow tools)

**Organization:** Data-Wise

**Repository Structure:**

```
Data-Wise/
├── Core Packages (Foundation) - PUBLIC
│   ├── medfit                      ← S7 object system for mediation
│   ├── probmed                     ← Product of coefficients
│   ├── rmediation                  ← Mediation inference
│   ├── medrobust                   ← Robust methods
│   ├── medsim                      ← Simulation tools
│   └── mediationverse              ← Meta package
│
├── Development Tools
│   ├── zsh-claude-workflow         🔒 PRIVATE - Personal workflow tool
│   ├── r-package-dev-gemini        🔒 PRIVATE - Personal tool
│   ├── claude-statistical-research ← MCP server (PUBLIC)
│   ├── claude-r-dev                ← R development profiles (PUBLIC)
│   ├── emacs-r-devkit              ← Emacs config (PUBLIC)
│   └── homebrew-tap                ← Homebrew formulas (PUBLIC)
│
├── Documentation & Standards - PUBLIC
│   ├── docs-standards              ← Shared doc templates
│   └── data-wise                   ← Project tracking
│
└── Quarto Projects - PUBLIC
    ├── unm-revealjs                ← UNM slides theme
    ├── examark                     ← Exam format
    └── [Other Quarto extensions]
```

**Visibility Strategy:**
- **PUBLIC repos** (16 total): R packages, MCP server, community tools, documentation
- **PRIVATE repos** (2 total): zsh-claude-workflow, r-package-dev-gemini
  - Reason: Personal workflow tools with personal preferences and ADHD optimizations
  - Impact: See `plans/GITHUB_PRIVATE_REPO_ANALYSIS.md` for detailed analysis
  - Access: Data-Wise org members have automatic access

### Repository Standards

**Every repo should have:**

1. **README.md** with badges:
   ```markdown
   # Project Name

   [![License](badge)]()
   [![R-CMD-check](badge)]()
   [![Codecov](badge)]()

   One-line description

   ## Installation
   ## Usage
   ## Documentation
   ## Citation
   ```

2. **CONTRIBUTING.md** - How to contribute

3. **LICENSE** - MIT license (consistent)

4. **.github/** directory:
   ```
   .github/
   ├── workflows/
   │   ├── R-CMD-check.yaml
   │   ├── test-coverage.yaml
   │   └── pkgdown.yaml
   ├── ISSUE_TEMPLATE/
   │   ├── bug_report.md
   │   └── feature_request.md
   └── PULL_REQUEST_TEMPLATE.md
   ```

5. **CLAUDE.md** - Instructions for Claude Code

6. **Consistent branching:**
   - `main` - Production
   - `dev` - Development
   - `feature/*` - Features

### Migration to GitHub

**Priority 1: Publish zsh-claude-workflow (TODAY)**

```bash
cd ~/projects/dev-tools/zsh-claude-workflow

# Already has:
# - README.md ✅
# - LICENSE ✅
# - .github/ ✅
# - CLAUDE.md ✅

# Initialize if not already
git init
git add .
git commit -m "Initial commit: zsh-claude-workflow v1.4

- Project detection and context gathering
- Research dashboard command
- Ecosystem planning documents
- ADHD-optimized workflows"

# Create GitHub repo (unauthenticated to avoid token issues)
env -u GITHUB_TOKEN gh repo create Data-Wise/zsh-claude-workflow \
  --public \
  --description "Smart context manager and workflow automation for Claude Code" \
  --source=. \
  --push

# Verify
env -u GITHUB_TOKEN gh repo view Data-Wise/zsh-claude-workflow
```

**Priority 2: Publish remaining dev-tools (THIS WEEK)**

```bash
# r-package-dev-gemini
cd ~/projects/dev-tools/r-package-dev-gemini
git init
# ... (similar process)

# Other missing projects
# ... (similar process)
```

**Priority 3: Standardize existing repos (NEXT WEEK)**

For each existing repo:

```bash
# Example: medfit
cd ~/projects/r-packages/active/medfit

# Check for missing files
[ -f CONTRIBUTING.md ] || curl -o CONTRIBUTING.md https://raw.githubusercontent.com/Data-Wise/docs-standards/main/templates/CONTRIBUTING.md
[ -f .github/PULL_REQUEST_TEMPLATE.md ] || mkdir -p .github && curl -o .github/PULL_REQUEST_TEMPLATE.md https://...

# Commit and push
git add .
git commit -m "docs: add missing GitHub standards"
git push
```

---

## 🔄 Complete Migration Timeline

### Week 1: Research Organization

**Monday (1 hr):**
- ✅ Run `research dashboard`
- ✅ Identify top 3 active projects
- ✅ Create ~/projects/research/ structure

**Tuesday-Thursday (30 min/day):**
- ✅ Migrate active project 1
- ✅ Migrate active project 2
- ✅ Migrate active project 3

**Friday (1 hr):**
- ✅ Test research dashboard
- ✅ Archive old Dropbox research
- ✅ Setup Dropbox symlinks

### Week 2: Teaching & GitHub

**Monday (1 hr):**
- ✅ Create ~/teaching/ structure
- ✅ Move one course to test
- ✅ Verify structure works

**Tuesday (1 hr):**
- ✅ Publish zsh-claude-workflow to GitHub
- ✅ Verify GitHub Actions work

**Wednesday-Thursday (1 hr/day):**
- ✅ Publish remaining missing repos
- ✅ Standardize existing repos

**Friday (1 hr):**
- ✅ Review all repos on GitHub
- ✅ Update data-wise tracking repo

### Week 3: Automation

**Monday-Thursday (1 hr/day):**
- ✅ Build ecosystem commands
- ✅ Build pj-dashboard
- ✅ Test all commands

**Friday:**
- ✅ Use new workflow exclusively
- ✅ Note friction points
- ✅ Iterate

---

## 📊 Before/After Comparison

| Aspect | BEFORE | AFTER |
|--------|--------|-------|
| **Research Location** | 3 locations (Dropbox + local + GDrive) | 1 location (~/projects/research/) |
| **Find Research File** | 10-15 min searching | <10 seconds (`research dashboard`) |
| **Active Projects** | Unknown (51 directories!) | Clear (3 max in active/) |
| **Teaching Files** | Mixed with research | Separate (~/teaching/) |
| **Cloud Storage** | Primary workspace (slow) | Backup only (fast local) |
| **GitHub Repos** | 6 missing | All published |
| **Repo Standards** | Inconsistent | Standardized |
| **Context Switching** | 5-10 min remembering | 30 sec (`research work project`) |
| **Morning Planning** | "What should I work on?" | `research dashboard` shows top 3 |
| **Time Wasted/Month** | 3-6 hours | <30 minutes |

---

## ✅ Success Criteria

### Week 1
- [ ] Can find any research project in <10 seconds
- [ ] Top 3 active projects in ~/projects/research/active/
- [ ] Dropbox syncing ~/projects/ automatically
- [ ] Morning planning takes <2 minutes

### Month 1
- [ ] All research in ~/projects/research/
- [ ] All teaching in ~/teaching/
- [ ] All dev-tools published on GitHub
- [ ] Using `research dashboard` daily
- [ ] Zero "where did I put that?" moments

### Quarter 1
- [ ] All repos have consistent structure
- [ ] Documentation standardized
- [ ] Ecosystem commands working (status-all, check-breaks)
- [ ] Context switching takes <1 minute
- [ ] Recovered 3-6 hours/month

---

## 🎯 Quick Start Checklist

### Today (30 min)

```bash
# 1. See current state
research dashboard

# 2. Create new structure
mkdir -p ~/projects/research/{active,planning,in-review,published,archive}
mkdir -p ~/teaching/{courses,materials,generated}

# 3. Identify top 3 projects
# Write them down:
# 1. _______________
# 2. _______________
# 3. _______________
```

### This Week (30 min/day)

**Day 1:** Migrate project 1 to ~/projects/research/active/
**Day 2:** Migrate project 2 to ~/projects/research/active/
**Day 3:** Migrate project 3 to ~/projects/research/active/
**Day 4:** Archive rest, setup Dropbox symlinks
**Day 5:** Publish zsh-claude-workflow to GitHub

### Next Week

**Use new structure exclusively**
- Work from ~/projects/research/active/ only
- Use `research dashboard` daily
- Track time saved

---

## 📋 Decision Matrix

### What Goes Where?

| Item | Location | Reason |
|------|----------|--------|
| **Active research project** | ~/projects/research/active/ | Fast local access |
| **Future research idea** | ~/projects/research/planning/ | Not started yet |
| **Submitted paper** | ~/projects/research/in-review/ | Clear status |
| **Published paper** | ~/projects/research/published/ | Archive |
| **Course materials** | ~/teaching/courses/ | Separate context |
| **examify generated files** | ~/teaching/generated/ | Auto-generated |
| **R package (developing)** | ~/projects/r-packages/active/ | Active development |
| **Dev tool** | ~/projects/dev-tools/ | Infrastructure |
| **Backup** | ~/Dropbox/Backup-*/ | Automatic mirror |
| **Shared collaboration** | Google Drive | Collaboration only |

---

## 🔍 Common Questions

### Q: What about old Dropbox research?

**A:** Archive it:
```bash
mkdir -p ~/Dropbox/Archive-Old-Research
mv ~/Dropbox/Research ~/Dropbox/Archive-Old-Research/Research-Pre-2025
```

Keep as frozen archive, don't delete. You can search it if needed.

### Q: What if I need to collaborate?

**A:** Two options:

**Option 1:** Work locally, share final version:
```bash
# Work in ~/projects/research/active/project/
# When ready to share:
cp -r ~/projects/research/active/project ~/Google\ Drive/Shared/
```

**Option 2:** Use Git/GitHub:
```bash
# Publish to GitHub
# Collaborators fork/PR
# Much better for version control
```

### Q: What about mobile access?

**A:** Dropbox mobile app sees backups:
- Access ~/Dropbox/Backup-Projects/ on phone
- Read-only (don't edit on mobile)
- Good for reviewing on the go

### Q: How to handle large data files?

**A:** Store in project, exclude from Git:

```bash
# In .gitignore:
data/*.csv
data/*.rds
*.Rdata

# Data syncs to Dropbox backup
# But not pushed to GitHub
```

### Q: What if a project becomes inactive?

**A:** Move to archive:

```bash
# Project not touched in 3 months?
mv ~/projects/research/active/old-project ~/projects/research/archive/

# research dashboard will show it as archived
```

---

## 💡 ADHD-Specific Benefits

### External Memory
✅ `research dashboard` shows all projects
✅ `pj-dashboard` shows all contexts (research + rpkg + quarto + apps + teaching)
✅ Never have to remember what exists or where it is

### Reduced Decisions
✅ Clear "active" threshold (3 max)
✅ Automatic categorization
✅ Recommended next steps in every output

### Clear Hierarchy
✅ active > planning > in-review > published > archive
✅ Visual at a glance
✅ Can't get lost in 51 directories

### Fast Context Switching
✅ `research work project` - Opens immediately
✅ `_next.md` - Remembers where you were
✅ Workspace files - All files open at once

### No More Searching
✅ Local files (fast, no sync delay)
✅ Single source of truth
✅ Everything findable in <10 seconds

---

## 🚀 Implementation Commands

### Create Complete Structure

```bash
# Local projects
mkdir -p ~/projects/{apps,dev-tools,quarto,r-packages,research}
mkdir -p ~/projects/research/{active,planning,in-review,published,archive,collaborations}
mkdir -p ~/projects/quarto/{extensions,presentations/{2025,2026},templates}
mkdir -p ~/projects/r-packages/{active,stable,archive,scratch}

# Teaching
mkdir -p ~/teaching/{courses,materials,generated}
mkdir -p ~/teaching/courses/{stats-415,stats-535,stats-630}
mkdir -p ~/teaching/materials/{datasets,templates,examples}
mkdir -p ~/teaching/generated/{exams,quizzes,homework}

# Cloud backup
ln -s ~/projects ~/Dropbox/Backup-Projects
ln -s ~/teaching ~/Dropbox/Backup-Teaching
```

### Migrate Research

```bash
# Identify active projects (modified < 2 weeks)
research dashboard

# Move top 3 to local
mv ~/Dropbox/Research/project1 ~/projects/research/active/
mv ~/Dropbox/Research/project2 ~/projects/research/active/
mv ~/Dropbox/Research/project3 ~/projects/research/active/

# Archive rest
mkdir -p ~/Dropbox/Archive-Old-Research
mv ~/Dropbox/Research ~/Dropbox/Archive-Old-Research/Research-Pre-2025
```

### Publish to GitHub

```bash
cd ~/projects/dev-tools/zsh-claude-workflow
env -u GITHUB_TOKEN gh repo create Data-Wise/zsh-claude-workflow \
  --public \
  --description "Smart context manager and workflow automation for Claude Code" \
  --source=. \
  --push
```

---

## 📈 Expected Outcomes

### Immediate (Week 1)
- ✅ Can find any file in <10 seconds
- ✅ Know what to work on without deciding
- ✅ Local work (fast, no sync issues)

### Short-term (Month 1)
- ✅ All projects organized and findable
- ✅ Morning planning takes <2 minutes
- ✅ Recovered 3-6 hours/month

### Long-term (Quarter 1)
- ✅ Zero cognitive load from organization
- ✅ Seamless context switching
- ✅ All work visible on GitHub
- ✅ Automated workflows reducing manual tasks

---

## 🎯 Priority Order

**Week 1: Research** (Highest ROI)
1. Run `research dashboard`
2. Create local structure
3. Migrate top 3 active projects
4. Setup Dropbox backup

**Week 2: Teaching & GitHub**
5. Create ~/teaching/ structure
6. Publish missing repos to GitHub

**Week 3: Automation**
7. Build ecosystem commands
8. Build pj-dashboard
9. Refine workflows

---

**READY TO START?**

**First command:** `research dashboard`

**See:** `SCATTERED_RESEARCH_CRISIS.md` for detailed research migration

**Then:** Follow Week 1 timeline above

**Result:** Organized, findable, ADHD-friendly workspace in 3 weeks
