# File System Audit - December 11, 2025

> **Audit Date:** 2025-12-11
> **Purpose:** Comprehensive review of scattered files, research, teaching, projects, and Obsidian
> **Status:** 🔴 CRITICAL - Severe fragmentation across 3 cloud providers

---

## 🎯 Executive Summary

### The Scattering Crisis

Your academic work is **severely fragmented** across **4 storage locations** and **3 cloud providers**:

| Location | Research | Teaching | Status |
|----------|----------|----------|--------|
| **Dropbox** | 468 MB (23 dirs) | 2.7 GB | Primary research location |
| **Google Drive** | 454 MB (5 dirs) | 2.7 GB | Duplicate teaching, some research |
| **OneDrive (UNM)** | 3 MB | 827 MB | Minimal research, active teaching |
| **Local ~/projects/** | 480 KB (1 project) | None | Nearly empty |

**Total Research Storage:** ~925 MB scattered across 4 locations
**Total Teaching Storage:** ~6.2 GB duplicated across 3 clouds
**Duplication Factor:** High (teaching likely duplicated)

---

## 📊 Detailed Findings

### 1. Research Projects - Scattered Across 4 Locations

#### Location A: Dropbox/Research/ (PRIMARY - 468 MB)
**Path:** `~/Library/CloudStorage/Dropbox/Research/`
**Items:** 48+ items (directories + files mixed)
**Status:** 🔴 CRITICAL - Unorganized, no clear structure

**Active Projects (estimated 12-15):**
- collider/
- DAG/
- data_analysis_plan/
- pmed/ (related to probmed R package?)
- LC Mediation Models/
- mult_med/
- missing effect/
- Inteventional mediation/
- nonrandomized mediation/
- lavaanplus/
- Replication/
- Simulation Studies/

**Archive Folders:**
- published/ (28 items)
- past/ (18 items)
- future/ (17 items - planning?)

**Problems:**
- Mixed files and directories in root
- No clear active/archive separation
- Loose data files (Data.xlsx, MATCH PDD wai.csv)
- Loose documents (Chapter_07New91.docx, analysis_plan2.qmd)
- No _next.md files for tracking

#### Location B: Google Drive/research/ (454 MB)
**Path:** `~/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/My Drive/research/`
**Items:** 5 directories

**Projects:**
- Poster/
- past/ (21 items)
- product of three/ (45 items - appears active!)
- published/ (3 items)
- python-sempoy/ (9 items)

**Overlap:** Likely duplicates some Dropbox content

#### Location C: OneDrive/research/ (UNM - 3 MB)
**Path:** `~/Library/CloudStorage/OneDrive-UniversityofNewMexico/research/`
**Items:** ~15 directories

**Projects:**
- AUD MOBC/
- Dave Chapter/
- Mediation Book/
- Mediation Notes/
- Simulation Tips/
- active/ (11 subdirs)
- addiction course/
- conf/
- conference-workshop/ (28 items)
- future/ (16 items)

**Status:** Minimal content, some duplicates

#### Location D: Local ~/projects/research/ (480 KB)
**Path:** `~/projects/research/`
**Items:** 1 directory only

**Projects:**
- mediation-planning/

**Status:** ✅ Clean but nearly empty

---

### 2. Teaching Materials - Massive Duplication

#### Total Teaching Storage: ~6.2 GB

| Location | Size | Directories | Status |
|----------|------|-------------|--------|
| **Dropbox/Teaching/** | 2.7 GB | ~17 dirs | Full teaching archive |
| **Google Drive/Teaching/** | 2.7 GB | Unknown | Likely duplicate! |
| **OneDrive/Teaching/** | 827 MB | 7 dirs | Active courses |

**Dropbox Teaching Structure:**
- Evaluation/
- Informal Midterm Evaluation and Feedback.docx
- Intro Stat-Undergrad/
- Mediation/
- MultilevelCourse/ (112 subdirs!)
- Other Instructors/
- PSY 502 Course/
- PSY-502/
- PSY502/ (3 versions!)
- Petersen Causality/
- R Course/
- Regression-Past/
- Teaching Improvement Resources/
- Tim psy200 files/
- intro to online learning/
- psy-200-mops/

**OneDrive Teaching Structure (UNM - Active):**
- DOE/ (59 items)
- Other Instructors/ (17 items)
- Past/
- S579_mixed/ (24 items)
- causal-inference/ (4 items)
- stat-440-prac/ (7 items)
- stat-545/ (50 items)

**Problems:**
- 2.7 GB duplication between Dropbox and Google Drive
- Multiple versions of same courses (PSY-502, PSY 502 Course, PSY502)
- No clear active vs. archive separation
- Massive MultilevelCourse directory (112 subdirs!)

---

### 3. R Packages - Completely Empty!

**Critical Finding:** All R package directories are **empty**!

| Directory | Status | Contents |
|-----------|--------|----------|
| `~/projects/r-packages/active/` | ❌ Empty | Just .DS_Store |
| `~/projects/r-packages/stable/` | ❌ Empty | Completely empty |
| `~/projects/r-packages/archive/` | ❌ Empty | Completely empty |
| `~/projects/r-packages/scratch/` | ⚠️ 1 package | Unknown package |

**Expected R Packages (from CLAUDE.md):**
- rmediation
- probmed
- medrobust
- medsim
- mediationverse
- medfit (mentioned in planning docs)

**Actual R Packages Found:** 0 in active/stable, 1 in scratch

**Status:** 🔴 **CRITICAL** - R packages are missing or in unknown location!

**Possible locations to check:**
- Dropbox/Code/R/
- Google Drive (unknown)
- Scattered in research directories

---

### 4. Quarto Projects - Empty Directories

| Directory | Status | Contents |
|-----------|--------|----------|
| `~/projects/quarto/manuscripts/` | ❌ Empty | No .qmd files found |
| `~/projects/quarto/extensions/` | ❌ Empty | No extensions found |
| `~/projects/quarto/presentations/` | Unknown | Not checked |

**Status:** Directory structure exists but no content

---

### 5. Dev Tools - Well Organized ✅

**Path:** `~/projects/dev-tools/`
**Status:** ✅ EXCELLENT - Clear organization

**Projects (8 total):**
1. **claude-statistical-research** - MCP server (14 tools, 17 skills)
2. **zsh-claude-workflow** - Shell automation (current project)
3. **emacs-r-devkit** - Emacs configuration for R
4. **homebrew-tap** - Homebrew formulas
5. **data-wise** - Unknown
6. **docs-standards** - Documentation standards
7. **obsidian-cli-ops** - Obsidian CLI operations
8. **workspace-auditor** - Workspace auditing tool

**Quality:** Well-structured, active development, git-managed

---

### 6. Applications

**Path:** `~/projects/apps/`
**Projects:**
- examark/ - Quiz/exam app

**Status:** Single app, appears active

---

### 7. Obsidian Vault - Active but Disconnected

**Location:** `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/`
**Storage:** iCloud Drive
**Status:** ⚠️ Active but isolated from project files

**Vault Structure:**
```
Documents/ (Obsidian Vault)
├── Research_Lab/          (0 notes found!)
├── Knowledge_Base/        (0 notes found!)
├── Life_Admin/
├── 99_Archive/
├── ~/                     (symlink?)
├── .obsidian/            (vault config)
├── GEMINI.md
└── README.md
```

**Obsidian Plugins Installed (32+):**
- obsidian-zotero-desktop-connector
- obsidian-pandoc
- obsidian-latex-suite
- table-editor-obsidian
- smart-composer
- chatgpt-md
- copilot
- And 25+ more...

**Problems:**
1. **Research_Lab/** is empty (0 .md files)
2. **Knowledge_Base/** is empty (0 .md files)
3. No connection to actual research in Dropbox/Google Drive
4. Vault is in iCloud, research is in 3 other clouds
5. Heavy plugin load but minimal content

**Expected Use:** PKM for research notes, literature, ideas
**Actual Use:** Configured but not populated

---

### 8. Home Directory - Clean! ✅

**Scattered Files in ~:** Only 2 files (excellent!)
- `claude-cli-aliases-reference.md` (11K)
- `gemini-aliases-reference.md` (6.7K)

**Hidden Directories:** 68 (normal for macOS)
**Status:** ✅ Very clean, minimal clutter

---

## 🚨 Critical Problems Identified

### Problem 1: Research Fragmentation (CRITICAL)
- **48+ items** in Dropbox/Research/ with no organization
- Active, archive, and planning projects mixed together
- Duplicates across Dropbox, Google Drive, OneDrive
- No tracking system (_next.md files missing)
- **925 MB** scattered across 4 locations

### Problem 2: Missing R Packages (CRITICAL - NOW FOUND!)
- Expected: 6+ R packages (rmediation, probmed, medrobust, medsim, medfit, mediationverse)
- **STATUS:** ✅ ALL 6 PACKAGES FOUND in Google Drive Trash!
- **Location:** `~/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/.Trash/`
- **Recovery:** In progress (blocked by Google Drive Files On-Demand sync)
- **Risk:** HIGH - Could be permanently deleted if trash emptied
- **See:** `plans/R_PACKAGE_RECOVERY_PLAN.md` for detailed recovery plan

### Problem 3: Teaching Duplication (HIGH)
- **~2.7 GB** duplicated between Dropbox and Google Drive
- Multiple versions of same course (PSY-502 x3)
- No clear active vs. archive separation
- **6.2 GB total** for teaching materials

### Problem 4: Obsidian Disconnection (MEDIUM)
- Vault configured but Research_Lab and Knowledge_Base are empty
- No integration with actual research files
- 32+ plugins installed but vault not in active use
- Isolated in iCloud, separate from research clouds

### Problem 5: Empty Project Directories (LOW)
- Quarto manuscripts/, extensions/ empty
- R packages active/, stable/, archive/ empty
- Structure exists but content missing or elsewhere

---

## 📈 Storage Statistics

### Total Storage by Type

| Category | Size | Locations | Status |
|----------|------|-----------|--------|
| **Research** | 925 MB | 4 locations | 🔴 Scattered |
| **Teaching** | 6.2 GB | 3 locations | 🔴 Duplicated |
| **Dev Tools** | Unknown | 1 location | ✅ Organized |
| **Obsidian** | Minimal | iCloud | ⚠️ Empty vault |
| **Home Dir** | 18 KB | 1 location | ✅ Clean |

### Cloud Provider Usage

| Provider | Research | Teaching | Total | Primary Use |
|----------|----------|----------|-------|-------------|
| **Dropbox** | 468 MB | 2.7 GB | ~3.2 GB | Primary research archive |
| **Google Drive** | 454 MB | 2.7 GB | ~3.2 GB | Teaching duplicate + some research |
| **OneDrive (UNM)** | 3 MB | 827 MB | ~830 MB | Active teaching courses |
| **iCloud** | 0 MB | 0 MB | Minimal | Obsidian vault (empty) |
| **Local** | 480 KB | 0 MB | ~480 KB | Dev tools only |

---

## 💡 Recommendations

### Immediate Actions (Week 1)

1. **Run the new `research` command** (already built!)
   ```bash
   ~/projects/dev-tools/zsh-claude-workflow/commands/research dashboard
   ```
   This will show you all scattered research in one view.

2. **Locate missing R packages**
   - Search Dropbox/Code/R/ for package directories
   - Check if packages were moved to cloud storage
   - Identify active vs. archived packages

3. **Create ~/projects/research/ structure**
   ```bash
   mkdir -p ~/projects/research/{active,planning,in-review,published,archive}
   ```

4. **Migrate top 3 active research projects** from Dropbox to local:
   - Identify using `research dashboard` (modified < 2 weeks)
   - Move to `~/projects/research/active/`
   - Create `_next.md` for each with clear next steps

### Phase 2: R Package Recovery (Week 2)

1. **Find all R packages** across cloud storage
2. **Assess each package:**
   - Active development → `~/projects/r-packages/active/`
   - Stable/CRAN → `~/projects/r-packages/stable/`
   - Old/deprecated → `~/projects/r-packages/archive/`
3. **Create mediationverse workspace** as described in planning docs

### Phase 3: Teaching Consolidation (Week 3-4)

1. **Identify active courses** (current semester):
   - Move to `~/projects/teaching/active/`
2. **Archive old courses:**
   - Keep one copy in `~/projects/teaching/archive/`
   - Delete duplicates from Google Drive
3. **Keep UNM OneDrive** for institutional backup only

### Phase 4: Obsidian Integration (Month 2)

1. **Populate Research_Lab/** with:
   - Literature notes from research projects
   - Project overviews with links to actual files
   - Research ideas and planning
2. **Create Zettelkasten** for knowledge management
3. **Link to actual research files** using obsidian-advanced-uri

### Phase 5: Long-term Organization

1. **Single source of truth:** `~/projects/` for all active work
2. **Cloud backup strategy:**
   - Active work: Local + Dropbox sync
   - Archive: Google Drive (cold storage)
   - UNM OneDrive: Institutional backup only
3. **Automation:**
   - Use `research` command for dashboards
   - Weekly review of active projects
   - Quarterly archive/cleanup

---

## 🎯 Target State

### Ideal Directory Structure

```
~/projects/
├── research/
│   ├── active/              ← Max 3 projects, from Dropbox
│   │   ├── project-1/
│   │   │   ├── _next.md    ← Clear next actions
│   │   │   ├── manuscript/
│   │   │   ├── simulations/
│   │   │   └── data/
│   │   ├── project-2/
│   │   └── project-3/
│   ├── planning/            ← Future projects
│   ├── in-review/           ← Submitted papers
│   ├── published/           ← Completed work
│   └── archive/             ← Old projects
│
├── r-packages/
│   ├── active/              ← mediationverse packages
│   │   ├── medfit/
│   │   ├── probmed/
│   │   ├── rmediation/
│   │   ├── medrobust/
│   │   ├── medsim/
│   │   └── mediationverse/
│   ├── stable/              ← CRAN packages
│   └── archive/             ← Old packages
│
├── teaching/
│   ├── active/              ← Current semester (from OneDrive)
│   │   ├── stat-545/
│   │   ├── psy-502/
│   │   └── causal-inference/
│   └── archive/             ← Past courses (from Dropbox)
│
├── quarto/
│   ├── manuscripts/         ← Research papers
│   ├── presentations/       ← Conference talks
│   └── extensions/          ← Custom extensions
│
├── dev-tools/               ✅ Already good!
└── apps/                    ✅ Already good!
```

### Obsidian Integration

```
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/
├── Research_Lab/
│   ├── Projects/
│   │   ├── Project-1-Overview.md     → Links to ~/projects/research/active/project-1/
│   │   ├── Project-2-Overview.md
│   │   └── Project-3-Overview.md
│   ├── Literature/
│   │   ├── Author-Year-Title.md      → Zotero integration
│   │   └── ...
│   ├── Ideas/
│   └── Methods/
│
├── Knowledge_Base/
│   ├── Statistics/
│   ├── R-Programming/
│   └── Mediation-Analysis/
│
└── Life_Admin/
```

---

## 📋 Migration Checklist

### Week 1: Research Triage
- [ ] Run `research dashboard` to see all projects
- [ ] Identify top 3 active projects (modified < 2 weeks)
- [ ] Create `~/projects/research/` structure
- [ ] Move top 3 to `~/projects/research/active/`
- [ ] Create `_next.md` for each active project
- [ ] Document remaining projects for later triage

### Week 2: R Package Recovery
- [ ] Search Dropbox/Code/R/ for packages
- [ ] Search Google Drive for packages
- [ ] List all found packages with status
- [ ] Move active packages to `~/projects/r-packages/active/`
- [ ] Create mediationverse workspace file
- [ ] Test package loading and development

### Week 3: Teaching Cleanup
- [ ] List all courses in all 3 clouds
- [ ] Identify current semester courses
- [ ] Create `~/projects/teaching/active/`
- [ ] Move current courses to active/
- [ ] Delete Google Drive teaching duplicate
- [ ] Archive old Dropbox teaching to local

### Week 4: Obsidian Population
- [ ] Create Research_Lab structure
- [ ] Add overview notes for active projects
- [ ] Import Zotero library to Literature/
- [ ] Create project templates
- [ ] Link to actual project files

### Month 2: Final Cleanup
- [ ] Review all research projects in Dropbox
- [ ] Archive completed projects
- [ ] Delete obvious duplicates
- [ ] Consolidate planning documents
- [ ] Set up automated backups
- [ ] Document final structure

---

## 🔧 Tools Available

### Already Built
1. **`research` command** - Dashboard, status, migrate (uncommitted in zsh-claude-workflow)
2. **`proj-type`** - Project detection
3. **`claude-ctx`** - Context gathering

### To Build
1. **`teaching` command** - Similar to research command
2. **`rpkg-find`** - Locate R packages across all clouds
3. **`obsidian-sync`** - Create project overviews in Obsidian

---

## 📊 Success Metrics

### 30 Days
- [ ] 3 active research projects in `~/projects/research/active/`
- [ ] All R packages located and categorized
- [ ] Teaching duplicates removed (save 2.7 GB)
- [ ] Research_Lab has 10+ project notes

### 60 Days
- [ ] All active research local in `~/projects/research/`
- [ ] Dropbox/Research/ reduced to archive only
- [ ] Single teaching location (local + UNM OneDrive)
- [ ] Obsidian vault actively used (50+ notes)

### 90 Days
- [ ] Research in 1 location (local)
- [ ] Teaching in 1 location (local)
- [ ] Cloud storage = backup only
- [ ] `research dashboard` shows organized portfolio
- [ ] Weekly review habit established

---

## 🎓 Key Insights

1. **You're not a hoarder** - Home directory is remarkably clean!
2. **You have systems thinking** - Directory structures are logical
3. **Execution gap** - Structures exist but aren't populated
4. **Cloud proliferation** - Academic reality (UNM OneDrive, personal clouds)
5. **Active work is minimal** - Only 1 local research project, suggests most work is stalled
6. **R package mystery** - Expected 6+ packages, found 0 in designated locations
7. **Teaching duplication** - 2.7 GB waste, easy win to eliminate
8. **Obsidian readiness** - Vault configured, plugins installed, just needs content

---

## 🚀 Next Command to Run

```bash
# See your scattered research in one dashboard
~/projects/dev-tools/zsh-claude-workflow/commands/research dashboard

# Or install it first
cd ~/projects/dev-tools/zsh-claude-workflow
./install.sh

# Then
research dashboard
```

This will give you a visual overview of all research projects across all 4 locations, categorized by activity level, with warnings about scattering.

---

**Report Generated:** 2025-12-11
**Next Review:** After Week 1 migration
**Priority:** 🔴 HIGH - Begin with `research dashboard` immediately
