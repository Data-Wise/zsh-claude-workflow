# Home Directory Organization Analysis & Plans

**Date**: 2025-12-07
**Current User**: dt
**Total Home Directories**: 26

---

## CURRENT STATE ANALYSIS

### 1. Coding Projects (Well Organized) ✅

```
~/code/                          # General code projects
  └── zsh-claude-workflow/       # 6.3M - Active

~/dev-tools/                     # Development utilities
  ├── claude-r-dev/              # 1.4M - Active
  ├── examify/                   # 94M - Active (has node_modules)
  └── r-package-dev-gemini/      # 348K

~/R-packages/                    # R package development
  ├── active/                    # 157M - 6 packages (medfit, mediationverse, medrobust, medsim, probmed, rmediation)
  ├── stable/                    # 0B - EMPTY ⚠️
  ├── scratch/                   # 68K - Minimal use
  └── selected/                  # 0B - EMPTY ⚠️ (unclear purpose)

~/quarto-projects/               # Quarto work
  ├── extensions/                # 10M - unm-revealjs
  └── manuscripts/               # 0B - EMPTY ⚠️
```

**Status**: ✅ Good structure, but has empty directories

---

### 2. Planning & Documentation (SCATTERED) ⚠️

```
~/mediation-planning/            # 420K - Git repo
  ├── API-CONTRACTS.md
  ├── BRANCHING-STRATEGY.md
  ├── DEVELOPMENT-STANDARDS.md
  ├── ECOSYSTEM-COORDINATION.md
  ├── INTEGRATION-PLAN.md
  ├── MEDSIM-*.md
  ├── SESSION-SUMMARY.md
  └── templates/

~/Docs Authoring/                # 496K
  ├── content-templates-main/
  └── learn-scaffolding-main/

~/ (root)                        # 9 .md files scattered!
  ├── CLAUDE-SKILLS-GUIDE.md
  ├── DOCUMENTATION-INDEX.md
  ├── HYBRID-STRUCTURE-PLAN.md
  ├── MCP-INTRODUCTION.md
  ├── MIGRATION-COMPLETE.md
  ├── PROJECT-STRUCTURE-ANALYSIS.md
  ├── SSH-KEYCHAIN-SETUP.md
  ├── ZSH-MASTERY-TUTORIAL.md
  └── ZSHRC-IMPROVEMENTS.md
```

**Problem**: Documentation scattered across 3 locations + home root

---

### 3. Working Directories (MESSY) ❌

```
~/Downloads/                     # 105M - DISASTER ZONE
  ├── Working files (.qmd, .md, .docx)
  ├── PDFs
  ├── Actual downloads
  └── All mixed together!

~/Documents/                     # 43M - Various
  ├── Adobe/
  ├── Cline/ (MCP, Rules, Workflows)
  ├── datawow/
  ├── mydocs/
  ├── recepts/
  ├── sample-else-man/
  ├── tex/
  ├── trip/
  ├── Wolfram/
  └── Zoom/

~/Desktop/                       # 8K - CLEAN ✅
```

**Problem**: Downloads used as workspace; Documents has mixed content

---

### 4. Cloud Storage (3 PROVIDERS) 🌥️

```
~/Dropbox/                       # Symlink to Library/CloudStorage/Dropbox
  ├── rprojects/ (medisim, myRfuncs, rmediation, rmediation.worktrees)
  ├── Research/
  └── Code/

~/Google Drive/                  # Symlink to GoogleDrive-dtofighi@gmail.com
  └── My Drive/
      └── (Could not fully access)

~/OneDrive - University of New Mexico/  # Symlink
  └── (Not explored)
```

**Problem**: Unclear organization; potential duplicates with local

---

### 5. Other Directories

```
~/assets/                        # camsa, logos - ✅ OK
~/archive/                       # EMPTY ⚠️
~/pdf/                           # Unknown size
~/tmp/                           # Temporary files
~/node_modules/                  # ❌ SHOULD NOT BE HERE!
~/Zotero/                        # Reference manager
~/chrome-headless-shell/         # Tool
```

**Problems**:
- Empty archive/ directory (not used)
- node_modules/ in home (should be in project)
- Unclear purpose for some

---

## KEY PROBLEMS IDENTIFIED

### 1. **Downloads Folder Abuse** ❌
- 105M of mixed content
- Working files (.qmd, .md, .docx) mixed with actual downloads
- PDFs, research files, code all mixed
- Should be temporary, not a workspace

### 2. **Documentation Scattered** ⚠️
- 9 .md files in home root
- mediation-planning/ git repo
- Docs Authoring/ directory
- No single source of truth

### 3. **Empty Directories** ⚠️
- ~/R-packages/stable/ (0B)
- ~/R-packages/selected/ (0B) - unclear purpose
- ~/quarto-projects/manuscripts/ (0B)
- ~/archive/ (0B)

### 4. **Cloud Storage Confusion** 🌥️
- 3 providers (Dropbox, Google Drive, OneDrive)
- Unclear when to use which
- Potential duplicates (e.g., Dropbox/rprojects/rmediation vs ~/R-packages/active/rmediation)
- No clear backup strategy

### 5. **No Clear Decision Tree** ❓
When creating a new project, where does it go?
- New R package → ~/R-packages/active/ ✅
- New Quarto manuscript → ~/quarto-projects/manuscripts/ (empty!) ⚠️
- New planning doc → ? (scattered) ⚠️
- New code project → ~/code/? ~/dev-tools/? ❓
- Research data → ~/Documents/? ~/Downloads/? ~/Dropbox/? ❓

### 6. **node_modules in Home** ❌
- Should be in ~/dev-tools/examify/node_modules/
- Not in home root

---

## PROPOSED PLANS

---

## 📋 PLAN A: CLEAN & CONSOLIDATE (Recommended)

**Philosophy**: Clear hierarchy, single source of truth, cloud for backup only

### Directory Structure

```
~/
├── projects/                    # 🆕 ALL active work
│   ├── code/                   # General code (not R/Quarto)
│   │   └── zsh-claude-workflow/
│   ├── r-packages/             # R package development
│   │   ├── active/            # Current work (was ~/R-packages/active/)
│   │   ├── stable/            # Finished but maintained
│   │   └── archive/           # Completed/inactive
│   ├── quarto/                # Quarto projects
│   │   ├── extensions/        # Extensions
│   │   ├── manuscripts/       # Papers/research
│   │   └── presentations/     # Slides
│   ├── dev-tools/             # Development utilities
│   │   ├── claude-r-dev/
│   │   ├── examify/
│   │   └── r-package-dev-gemini/
│   └── research/              # Research projects
│       └── mediation-planning/
│
├── docs/                       # 🆕 ALL documentation
│   ├── guides/                # User guides (.md files from ~/)
│   │   ├── claude-skills-guide.md
│   │   ├── hybrid-structure-plan.md
│   │   ├── mcp-introduction.md
│   │   ├── ssh-keychain-setup.md
│   │   ├── zsh-mastery-tutorial.md
│   │   └── zshrc-improvements.md
│   ├── planning/              # Project planning
│   │   ├── documentation-index.md
│   │   ├── migration-complete.md
│   │   └── project-structure-analysis.md
│   ├── authoring/             # Content templates (from ~/Docs Authoring)
│   │   ├── content-templates/
│   │   └── learn-scaffolding/
│   └── personal/              # Personal docs (from ~/Documents/mydocs)
│
├── assets/                     # Keep as-is ✅
│   ├── camsa/
│   └── logos/
│
├── cloud-sync/                 # 🆕 Cloud storage management
│   ├── dropbox/               # Symlink to ~/Dropbox
│   ├── google-drive/          # Symlink to ~/Google Drive
│   └── onedrive/              # Symlink to ~/OneDrive
│
├── workspace/                  # 🆕 Active working area
│   ├── current/               # What you're working on NOW
│   ├── inbox/                 # New downloads/inputs
│   └── scratch/               # Temporary work
│
├── archive/                    # Long-term storage
│   ├── projects/              # Old completed projects
│   ├── documents/             # Old documents
│   └── downloads/             # Old downloads worth keeping
│
└── system/                     # 🆕 System-related
    ├── scripts/               # Utility scripts
    ├── configs/               # Configuration backups
    └── bin/                   # Personal executables
```

### Migration Steps

**Phase 1: Create New Structure** (5 minutes)
```bash
mkdir -p ~/projects/{code,r-packages/{active,stable,archive},quarto/{extensions,manuscripts,presentations},dev-tools,research}
mkdir -p ~/docs/{guides,planning,authoring,personal}
mkdir -p ~/cloud-sync
mkdir -p ~/workspace/{current,inbox,scratch}
mkdir -p ~/archive/{projects,documents,downloads}
mkdir -p ~/system/{scripts,configs,bin}
```

**Phase 2: Move Code Projects** (10 minutes)
```bash
# Code projects
mv ~/code/* ~/projects/code/

# R packages (keep tier structure)
mv ~/R-packages/* ~/projects/r-packages/

# Quarto
mv ~/quarto-projects/* ~/projects/quarto/

# Dev tools
mv ~/dev-tools/* ~/projects/dev-tools/

# Research planning
mv ~/mediation-planning ~/projects/research/
```

**Phase 3: Consolidate Documentation** (15 minutes)
```bash
# Move .md guides from home root
mv ~/*.md ~/docs/guides/
# Rename to lowercase-with-dashes for consistency
cd ~/docs/guides
for f in *.md; do
  mv "$f" "$(echo $f | tr '[:upper:]' '[:lower:]' | tr '_' '-')"
done

# Move Docs Authoring
mv ~/"Docs Authoring"/* ~/docs/authoring/

# Move personal docs
mv ~/Documents/mydocs ~/docs/personal/
```

**Phase 4: Clean Downloads** (30 minutes) ⚠️
```bash
# Create temporary sorting area
mkdir ~/workspace/inbox/from-downloads

# Move all non-.pkg/.dmg/.zip files to inbox for manual sorting
cd ~/Downloads
mv *.md *.qmd *.docx *.pdf ~/workspace/inbox/from-downloads/

# Then manually sort:
# - Current work → ~/workspace/current/
# - Research → ~/projects/research/
# - Archive → ~/archive/downloads/
# - Delete junk

# Keep Downloads clean going forward!
```

**Phase 5: Cloud Storage Links** (2 minutes)
```bash
cd ~/cloud-sync
ln -s ~/Dropbox dropbox
ln -s ~/Google\ Drive google-drive
ln -s ~/OneDrive\ -\ University\ of\ New\ Mexico onedrive
```

**Phase 6: Cleanup** (10 minutes)
```bash
# Remove empty directories
rmdir ~/code ~/dev-tools ~/R-packages ~/quarto-projects

# Move node_modules to correct location
mv ~/node_modules ~/projects/dev-tools/examify/ 2>/dev/null || true

# Clean home root
ls -la ~ | grep -v "^\."  # Check what's left
```

**Phase 7: Update Paths** (5 minutes)
```bash
# Update .zshrc
vim ~/.zshrc
# Change:
#   export R_PACKAGES_DIR="$HOME/R-packages"
# To:
#   export R_PACKAGES_DIR="$HOME/projects/r-packages"
# Change:
#   export QUARTO_DIR="$HOME/quarto-projects"
# To:
#   export QUARTO_DIR="$HOME/projects/quarto"

source ~/.zshrc
```

### Benefits
- ✅ Clear hierarchy (projects/ docs/ workspace/)
- ✅ Single location for all documentation
- ✅ Clean Downloads folder (stays temporary)
- ✅ workspace/ for active work (replaces Downloads abuse)
- ✅ Cloud storage clearly separated
- ✅ Easy to find anything
- ✅ Clean home root (only 6 top-level dirs)

### Cloud Storage Strategy
- **Local (~/projects/)**: Active development (fast, no conflicts)
- **Dropbox**: Keep for collaboration/sharing only
- **Google Drive**: Backup of stable/archive projects
- **OneDrive**: University-related only
- **Git/GitHub**: Primary backup for all code

---

## 📋 PLAN B: MINIMAL REORGANIZATION

**Philosophy**: Fix only the worst problems, minimal changes

### Changes

1. **Fix Downloads** ❌→✅
```bash
mkdir ~/workspace/inbox
mv ~/Downloads/*.{md,qmd,docx,pdf} ~/workspace/inbox/
# Sort manually from there
```

2. **Consolidate Documentation** 📄
```bash
mkdir ~/docs
mv ~/*.md ~/docs/
mv ~/mediation-planning ~/docs/planning
mv ~/"Docs Authoring" ~/docs/authoring
```

3. **Remove node_modules** ❌→✅
```bash
rm -rf ~/node_modules  # Or move to examify if needed
```

4. **Use empty directories** ⚠️→✅
```bash
# Actually use ~/R-packages/stable/ for finished packages
# Use ~/quarto-projects/manuscripts/ for papers
# Delete ~/R-packages/selected/ if unclear
rmdir ~/R-packages/selected
```

### Benefits
- ✅ Quick (30 minutes total)
- ✅ Low risk
- ✅ Fixes worst problems
- ❌ Doesn't fully solve organization
- ❌ Still some confusion

---

## 📋 PLAN C: WORKSPACE-CENTRIC

**Philosophy**: Optimize for how you actually work - active workspace + organized archive

### Directory Structure

```
~/
├── work/                       # 🆕 Everything active
│   ├── now/                   # Current focus (max 3 projects)
│   ├── r-packages/            # R development
│   ├── quarto/                # Quarto work
│   ├── code/                  # Other code
│   ├── tools/                 # Dev tools
│   └── research/              # Research planning
│
├── docs/                       # All documentation
│   ├── guides/
│   ├── planning/
│   └── templates/
│
├── inbox/                      # 🆕 Unsorted inputs
│   ├── downloads/             # From Downloads/
│   ├── notes/                 # Quick notes
│   └── to-process/            # Needs sorting
│
├── assets/                     # Images, logos, etc.
│
├── archive/                    # Completed work
│   ├── projects/
│   └── documents/
│
└── cloud/                      # Cloud storage shortcuts
    ├── dropbox → ~/Dropbox
    ├── google → ~/Google Drive
    └── onedrive → ~/OneDrive
```

### Key Concept: `~/work/now/`

This is THE folder for active work:
```bash
~/work/now/
├── paper-mediation-analysis/   # Symlink to ~/work/quarto/manuscripts/med-paper
├── rmediation-v2/              # Symlink to ~/work/r-packages/active/rmediation
└── examify-release/            # Symlink to ~/work/tools/examify
```

**Workflow**:
1. Start new task → create/symlink in `~/work/now/`
2. Stop working on it → remove from `~/work/now/`
3. Archive when done → move to `~/archive/`

### Benefits
- ✅ Clear "what am I working on now?"
- ✅ Inbox for unsorted stuff (Downloads/)
- ✅ Everything else archived/organized
- ✅ Quick access to active work
- ✅ Clean separation of active vs archive

---

## 📋 PLAN D: HYBRID LOCAL + CLOUD

**Philosophy**: Use cloud storage strategically for different purposes

### Strategy

**Local (~/)** - Active development only
```
~/projects/
├── active/                     # What you're working on NOW
│   ├── r-packages/
│   ├── quarto/
│   └── code/
└── tools/                      # Dev utilities
```

**Dropbox** - Collaboration & Sharing
```
~/Dropbox/
├── shared/                     # Shared with others
├── collaboration/              # Active collaborative projects
└── sync/                       # Auto-synced work
```

**Google Drive** - Archive & Backup
```
~/Google Drive/My Drive/
├── projects-archive/           # Completed projects
│   ├── r-packages-stable/
│   └── manuscripts-published/
├── backup/                     # Weekly backups
└── reference/                  # Reference materials
```

**OneDrive** - University/Work Only
```
~/OneDrive/
├── teaching/
├── admin/
└── uni-research/
```

### Decision Tree

**New Project Type** → **Where It Goes**

- New R package → `~/projects/active/r-packages/` + git push
- Package finished → Move to Google Drive archive + keep in git
- Collaborative project → Start in Dropbox, clone to local for work
- Quarto manuscript → `~/projects/active/quarto/`, published → Google Drive
- Quick notes/docs → Start in Downloads, process to `~/docs/`
- University work → OneDrive only
- Reference PDFs → Google Drive/reference/
- Dev tools → `~/projects/tools/`

### Benefits
- ✅ Clear purpose for each cloud provider
- ✅ Active work local (fast)
- ✅ Auto-backup for important stuff
- ✅ Collaboration enabled
- ✅ University work separated

---

## DECISION MATRIX

| Aspect | Plan A: Clean | Plan B: Minimal | Plan C: Workspace | Plan D: Hybrid |
|--------|---------------|-----------------|-------------------|----------------|
| **Effort** | High (2-3 hrs) | Low (30 min) | Medium (1-2 hrs) | Medium (1 hr) |
| **Risk** | Low | Very Low | Low | Medium |
| **Clarity** | ★★★★★ | ★★★☆☆ | ★★★★☆ | ★★★★☆ |
| **Maintains Current** | No | Yes | Partial | Partial |
| **Cloud Strategy** | Simple | None | Simple | Complex |
| **Home Root Clean** | ★★★★★ | ★★★☆☆ | ★★★★★ | ★★★★☆ |
| **Downloads Fix** | ✅ | ✅ | ✅ | ✅ |
| **Docs Consolidated** | ✅ | ✅ | ✅ | Partial |
| **Best For** | Clean slate | Quick fix | Active workers | Cloud users |

---

## RECOMMENDED APPROACH

### For You: **Plan A (Clean & Consolidate)** 🏆

**Why?**
1. You already have a HYBRID-STRUCTURE-PLAN.md showing you value organization
2. You have scattered documentation that needs consolidating
3. Downloads is a mess (105M) - needs full cleanup
4. Empty directories show partial implementation of previous plan
5. You're a developer - you value clear structure

**Time Investment**: 2-3 hours
**Risk**: Low (everything backed up in git)
**Long-term Benefit**: High

### Implementation Priority

**Week 1: Critical Fixes** (Day 1)
1. Fix Downloads folder (move working files to workspace)
2. Consolidate .md docs from home root
3. Remove ~/node_modules

**Week 2: Reorganization** (Weekend project)
4. Create new structure
5. Move projects to ~/projects/
6. Move docs to ~/docs/
7. Update .zshrc paths

**Week 3: Cloud Strategy** (As needed)
8. Set up cloud-sync/ directory
9. Define what goes in each cloud provider
10. Archive old projects to Google Drive

---

## NEXT STEPS

### Option 1: Full Plan A Implementation
I can help you execute the complete Plan A reorganization step by step.

### Option 2: Start with Critical Fixes
Let's fix Downloads + consolidate docs first (30 min), then decide on full reorganization.

### Option 3: Customize a Plan
Tell me what aspects of each plan you like, and I'll create a custom hybrid plan.

### Option 4: Just Answer Decision Tree
I'll create a simple decision tree for "where do I put new projects?" based on your current structure.

---

**What would you like to do?**
