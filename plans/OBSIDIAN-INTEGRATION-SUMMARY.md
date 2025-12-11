# Obsidian Integration - Key Findings

> **Date:** 2025-12-10
> **Discovery:** You have 3,540 notes in Obsidian with active research projects!

---

## 🔍 What I Found

### Your Obsidian Setup

**Location:** `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/`

**Three Vaults:**
1. **Knowledge_Base** (2,810 files - 79%)
   - Programming (R, Python, Julia, git, prompts)
   - Statistics theory
   - Math
   - Teaching resources

2. **Research_Lab** (512 files - 14%)
   - **Prod3_Manuscript** ← Product of 3 distributions
   - **Collider_Research** ← Collider bias
   - **Diabetes_Research** ← Diabetes study
   - **RMediation_Package** ← R package planning
   - **Simulation_Tools**
   - **00_Incubator** ← New ideas
   - **02_Topic_Backlog** ← Future topics

3. **Life_Admin** (218 files - 6%)
   - Career development
   - Personal planning
   - Service admin

### Your Workflow Infrastructure

**Already in ~/projects/dev-tools/:**
- ✅ **emacs-r-devkit** - emacs+r+zsh integration (WORKING)
- ✅ **obsidian-cli-ops** - Vault management tools
- ✅ **claude-statistical-research** - MCP server with Obsidian integration (claude+obsidian)

---

## ⚠️ Key Problem Discovered

### Research Exists in TWO Places!

**Obsidian Vaults (iCloud):**
- Research_Lab/Collider_Research/ (notes, literature, planning)
- Research_Lab/Prod3_Manuscript/ (notes, ideas)
- Research_Lab/Diabetes_Research/ (notes)

**File System (Scattered):**
- ~/Dropbox/Research/collider/ (data, code, manuscripts)
- ~/Dropbox/Research/pmed/ (files)
- ~/research/mediation-planning/ (files)

**Problem:**
- **Duplication:** Same projects in both places
- **Disconnected:** No links between files and notes
- **Confusing:** Which is source of truth?
- **ADHD Impact:** Constant context switching, searching

---

## 🎯 Solution: Unified File + Knowledge System

### Principle: Clear Boundaries

| Content Type | Where It Lives | Example |
|--------------|----------------|---------|
| **Literature notes** | Obsidian | Papers, references, summaries |
| **Ideas & planning** | Obsidian | Brainstorming, hypotheses |
| **Learning** | Obsidian | Statistics theory, R tips |
| **Code** | Files | R scripts, simulations |
| **Data** | Files | Datasets, results |
| **Manuscripts** | Files | .qmd, .Rmd, LaTeX |

### Bidirectional Links

**Every research project gets BOTH:**
1. **File directory** (~/research/active/project-name/)
   - Contains: code, data, manuscripts, results
   - Has: `_obsidian.md` with link to vault

2. **Obsidian folder** (Research_Lab/Project_Name/)
   - Contains: literature, ideas, planning, methods
   - Has: `file://` links to project directory

**Example:**
```
Files:                           Obsidian:
~/research/active/collider/  ←→  Research_Lab/Collider_Research/
├── data/                        ├── Literature/
├── code/                        ├── Ideas/
├── manuscript/                  ├── Methods_Planning/
├── results/                     └── 00_Dashboard.md
└── _obsidian.md                     (with file:// links)
    (with obsidian:// link)
```

---

## 🔧 Three Workflow Integrations

### 1. emacs+r+zsh ✅ (WORKING)

**Powered by:** emacs-r-devkit

**What it does:**
- Emacs with ESS for R development
- LSP for code intelligence
- zsh terminal integration
- Flycheck linting

**Status:** Fully configured

### 2. emacs+obsidian ⚡ (NEEDS COMMANDS)

**How it works:**
- Edit Obsidian notes in Emacs (superior keybindings, modal editing)
- iCloud syncs changes automatically
- View results in Obsidian (graph, links, mobile)

**What's missing:**
- Shell command to open Obsidian notes in Emacs
- Example: `obsidian edit Research_Lab/Collider_Research/Methods`

**Status:** Documented but needs implementation

### 3. claude+obsidian 🔧 (NEEDS SETUP)

**How it works:**
- Claude MCP server can read/write Obsidian notes
- Use for literature review, research synthesis, knowledge organization
- Results saved to vaults

**What's missing:**
- MCP server configuration
- Workflow commands
- Integration with `proj-claude`

**Status:** Tools exist but not configured

---

## 🛠️ New Commands Needed

### 1. `obsidian` Command (NEW)

```bash
# Open vault
obsidian open Knowledge_Base

# Open specific note
obsidian note Research_Lab/Collider_Research/Methods

# Open project's Obsidian notes
obsidian project collider
# → Opens Research_Lab/Collider_Research/ in Obsidian

# Edit in Emacs (emacs+obsidian workflow)
obsidian edit Research_Lab/Collider_Research/Methods
# → Opens note in Emacs for heavy editing
```

### 2. Enhanced `research` Command

```bash
# Show Obsidian integration
research status collider
# Output:
#   Files: ~/research/active/collider/
#   Notes: Research_Lab/Collider_Research/
#   [Open Files] [Open Notes]

# Open Obsidian notes directly
research obsidian collider
# → Opens Research_Lab/Collider_Research/ in Obsidian
```

### 3. `teaching` Command (NEW)

```bash
# Teaching dashboard
teaching dashboard

# Work on course (opens files + Obsidian notes)
teaching work stats-415

# Next week setup
teaching next-week stats-415
# → Creates week-N/ + Obsidian template
```

---

## 📋 Implementation Plan

### Phase 1: Mapping (1 hour)

**Identify overlaps:**
```bash
# Which Research_Lab projects have file counterparts?
Research_Lab/Collider_Research/  ↔  ~/Dropbox/Research/collider/  ✓
Research_Lab/Prod3_Manuscript/   ↔  ~/research/mediation-planning/ ✓
Research_Lab/Diabetes_Research/  ↔  ❓ (not in files yet)
Research_Lab/RMediation_Package/ ↔  ~/r-packages/active/rmediation/ ✓
```

### Phase 2: Create Links (2 hours)

**Add `_obsidian.md` to each file project:**
```bash
# Example for collider
cat > ~/research/active/collider/_obsidian.md << EOF
# Obsidian Notes

[Open in Obsidian](obsidian://open?vault=Research_Lab&file=Collider_Research)
EOF
```

**Add file links to Obsidian dashboards:**
- Manual in Obsidian UI
- Add `file://` links to project directories

### Phase 3: Build Tools (3-5 hours)

1. Create `obsidian` command (2 hours)
2. Update `research` command with Obsidian detection (1 hour)
3. Create `teaching` command (2 hours)
4. Configure MCP server for claude+obsidian (TBD)

---

## 🎯 ADHD Benefits

### Before Integration

**Finding collider research:**
1. Open Finder
2. Navigate to iCloud → Obsidian → Research_Lab
3. Find Collider_Research folder
4. Separately: Find file directory in Dropbox
5. **Time: 3-5 minutes**

**Context switching overhead:**
- Is this in Obsidian or files?
- Did I update both places?
- Which has the latest info?
- **Mental load: HIGH**

### After Integration

**Finding collider research:**
```bash
research work collider
# Opens: ~/research/active/collider/

research obsidian collider
# Opens: Research_Lab/Collider_Research/ in Obsidian

# Time: < 10 seconds
```

**Clear boundaries:**
- Code/data/manuscripts → Always files
- Literature/ideas/planning → Always Obsidian
- **Mental load: ZERO** (rules are automatic)

---

## 📊 Updated Project Structure

### Files (~/projects/)

```
~/projects/
├── research/
│   ├── active/              ← File-based projects
│   │   ├── collider/        ← Links to Research_Lab/Collider_Research/
│   │   ├── product-of-three/ ← Links to Research_Lab/Prod3_Manuscript/
│   │   └── diabetes/        ← Links to Research_Lab/Diabetes_Research/
│   ├── planning/
│   ├── in-review/
│   └── archive/
│
├── r-packages/
│   └── active/
│       └── rmediation/      ← Links to Research_Lab/RMediation_Package/
│
├── teaching/                ← NEW!
│   ├── courses/
│   │   ├── stats-415/       ← Links to Knowledge_Base/Teaching_Resources/
│   │   ├── stats-535/
│   │   └── stats-630/
│   ├── materials/
│   └── generated/
│
└── dev-tools/
    ├── zsh-claude-workflow/       🔒 PRIVATE
    ├── emacs-r-devkit/            ← emacs+r+zsh ✅
    ├── obsidian-cli-ops/          ← Vault management ✅
    └── claude-statistical-research/ ← claude+obsidian ⚠️
```

### Obsidian (iCloud) - No Changes

```
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/
├── Knowledge_Base/ (2,810 files)
│   ├── Programming_Languages/
│   │   ├── R/
│   │   ├── Emacs_DevKit/
│   │   └── [others]
│   └── Teaching_Resources/
│       ├── STATS-415/           ← Links to ~/teaching/courses/stats-415/
│       ├── STATS-535/
│       └── STATS-630/
│
├── Research_Lab/ (512 files)
│   ├── Collider_Research/       ← Links to ~/research/active/collider/
│   ├── Prod3_Manuscript/        ← Links to ~/research/active/product-of-three/
│   ├── Diabetes_Research/       ← Links to ~/research/active/diabetes/
│   └── RMediation_Package/      ← Links to ~/r-packages/active/rmediation/
│
└── Life_Admin/ (218 files)
```

---

## 🚀 Next Steps

### Immediate (Today)

1. **Read:** Full plan at `plans/OBSIDIAN-INTEGRATED-RESTRUCTURE.md`
2. **Map:** Create list of Research_Lab ↔ File overlaps
3. **Decide:** Which 3 research projects are truly active?

### Week 1: Linking

1. Add `_obsidian.md` to file projects
2. Add file links to Obsidian dashboards
3. Test bidirectional navigation

### Week 2: Tools

1. Build `obsidian` command
2. Update `research` command
3. Build `teaching` command
4. Configure claude+obsidian (MCP server)

### Week 3: Migration

1. Migrate research from Dropbox to ~/research/
2. Align with Obsidian Research_Lab/
3. Setup Google Drive backup
4. Test all three workflow integrations

---

## 💡 Key Insight

**You already have an incredible knowledge management system (Obsidian)!**

**Problem:** It's disconnected from your file-based work

**Solution:** Bridge the gap with:
- Clear boundaries (files vs notes)
- Bidirectional links (one-click navigation)
- Shell commands (ADHD-friendly access)
- Three workflow integrations working together

**Result:** Single unified system with:
- ✅ External memory (tools track everything)
- ✅ No decisions (clear rules)
- ✅ Fast access (< 10 seconds to anything)
- ✅ Mobile (Obsidian) + Power (Emacs) + AI (Claude)

---

**Last Updated:** 2025-12-10
**Status:** Analysis complete, ready for implementation
**See Full Plan:** `OBSIDIAN-INTEGRATED-RESTRUCTURE.md`
