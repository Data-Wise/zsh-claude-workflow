# OBSIDIAN-Integrated Restructuring Plan

> **Date:** 2025-12-10
> **Revision:** Added Obsidian as knowledge management hub
> **Key Finding:** You have 3,540 notes in Obsidian (including active research projects!)

---

## 🎯 The Complete Picture

### Your Workflow Ecosystem

**You have TWO interconnected systems:**

1. **File-Based Projects** (~/projects/) - Code, data, manuscripts, executables
2. **Knowledge-Based Notes** (Obsidian vaults in iCloud) - Ideas, literature, planning, learning

**Current Problem:** These systems are DISCONNECTED
- Research exists in BOTH places (Obsidian Research_Lab + Dropbox/Research/)
- No clear boundary between "project files" vs "knowledge notes"
- Switching contexts requires mental overhead

---

## 📊 Current State Analysis

### Obsidian Vaults (iCloud)

**Location:** `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/`

| Vault | Files | Purpose | Integrates With |
|-------|-------|---------|-----------------|
| **Knowledge_Base** | 2,810 (79%) | Programming, math, stats, teaching | emacs-r-devkit, learning |
| **Research_Lab** | 512 (14%) | Active manuscripts, research planning | File-based research projects |
| **Life_Admin** | 218 (6%) | Career, planning, service | Teaching, personal |
| **99_Archive** | - | Old notes | - |
| **TOTAL** | ~3,540 | Knowledge management | - |

**Key Obsidian Features:**
- ✅ Mobile access (iPhone/iPad)
- ✅ Graph view and linking
- ✅ Rich plugins (LaTeX, Pandoc, Zotero, etc.)
- ✅ iCloud sync (automatic)

### Research_Lab Vault Contents

**Active projects in Obsidian:**
```
Research_Lab/
├── Prod3_Manuscript/         ← Product of 3 distributions research
├── RMediation_Package/       ← R package documentation/planning
├── Collider_Research/        ← Collider bias research
├── Diabetes_Research/        ← Diabetes study
├── Simulation_Tools/         ← Simulation methods
├── Replication_Studies/      ← Replication projects
├── 00_Incubator/            ← New project ideas
└── 02_Topic_Backlog/        ← Future research topics
```

**⚠️ DUPLICATION ALERT:** Some research exists in BOTH places:
- Obsidian: Research_Lab/Collider_Research/ (notes, literature, planning)
- Files: ~/Dropbox/Research/collider/ (data, code, manuscripts)

### File-Based Projects (~/projects/)

**Current structure:**
```
~/projects/
├── apps/              # examify
├── dev-tools/         # Infrastructure
│   ├── zsh-claude-workflow/
│   ├── claude-statistical-research/
│   ├── emacs-r-devkit/          ← Emacs+R+zsh integration
│   ├── obsidian-cli-ops/        ← Obsidian vault management
│   └── claude-r-dev/
├── quarto/            # Extensions, presentations
├── r-packages/        # MediationVerse ecosystem
└── research/          # Only 1 project (most in Dropbox!)
```

### dev-tools/ Ecosystem

**Your workflow infrastructure:**

| Tool | Purpose | Workflow Integration |
|------|---------|---------------------|
| **emacs-r-devkit** | Emacs+ESS+R+zsh | emacs+r+zsh ✅ |
| **obsidian-cli-ops** | Vault sync, plugin management | Obsidian management |
| **zsh-claude-workflow** | Project detection, context | Shell automation |
| **claude-statistical-research** | MCP server (16 tools) | claude+obsidian ✅ |
| **claude-r-dev** | R development profiles | R package development |

**MCP Server has Obsidian integration:**
- Path: `claude-statistical-research/mcp-server/src/tools/obsidian`
- Enables **claude+obsidian** workflow

---

## 🔄 Three Workflow Integrations (You Mentioned)

### 1. emacs+r+zsh ✅ (Working)

**Powered by:** emacs-r-devkit

**What it does:**
- Emacs with ESS for R development
- LSP for code intelligence
- zsh integration for terminal workflows
- Flycheck for linting

**Status:** Fully configured and documented

### 2. emacs+obsidian ⚡ (Partially Working)

**How it works:**
- Obsidian notes stored in iCloud
- Edit notes in Emacs (markdown-mode or org-mode)
- iCloud syncs changes automatically
- View in Obsidian (graph, links, preview)

**What you have:**
- ✅ Extensive planning (OBSIDIAN-INTEGRATION-PLAN.md)
- ✅ Workflow designs (OBSIDIAN-WORKFLOW-BRAINSTORM.md)
- ⚠️ Needs: Shell commands to open Obsidian notes in Emacs

### 3. claude+obsidian 🔧 (Needs Setup)

**How it should work:**
- Claude MCP server can read/write Obsidian notes
- Use for research, literature review, knowledge synthesis
- Results saved to Obsidian vaults

**What you have:**
- ✅ MCP server with Obsidian tools
- ⚠️ Needs: Configuration and workflow commands

---

## 🎯 Proposed Unified Structure

### Principle: Clear Boundaries Between Files and Knowledge

**File System (~/projects/):** Executable things
- Code that runs
- Data files
- Compiled manuscripts
- Built applications
- Git repositories

**Obsidian Vaults (iCloud):** Knowledge things
- Literature notes
- Research planning
- Ideas and brainstorming
- Learning notes
- Documentation drafts

**Bridge Between Them:**
- Each research project gets BOTH a file directory AND an Obsidian folder
- Clear naming convention links them
- Tools to switch between contexts

---

## 📁 Revised File Structure

### ~/projects/ (File-Based)

```
~/projects/
│
├── research/                      ← FILE-BASED research
│   ├── active/                    ← Current work (max 3)
│   │   ├── collider/              ← Links to Research_Lab/Collider_Research/
│   │   │   ├── data/
│   │   │   ├── code/
│   │   │   ├── manuscript/
│   │   │   ├── results/
│   │   │   └── _obsidian.md      ← Link: obsidian://open?vault=Research_Lab&file=Collider_Research/00_Dashboard
│   │   │
│   │   ├── product-of-three/      ← Links to Research_Lab/Prod3_Manuscript/
│   │   │   ├── simulations/
│   │   │   ├── manuscript/
│   │   │   ├── figures/
│   │   │   └── _obsidian.md      ← Link to vault
│   │   │
│   │   └── diabetes/              ← Links to Research_Lab/Diabetes_Research/
│   │       ├── data/
│   │       ├── analysis/
│   │       └── _obsidian.md
│   │
│   ├── planning/                  ← Future projects
│   ├── in-review/                 ← Submitted papers
│   ├── published/                 ← Completed work
│   └── archive/                   ← Old projects
│
├── r-packages/                    ← R PACKAGE development
│   ├── active/
│   │   ├── medfit/                ← Links to Research_Lab/RMediation_Package/
│   │   │   ├── R/
│   │   │   ├── tests/
│   │   │   ├── vignettes/
│   │   │   └── _obsidian.md      ← Link to vault notes
│   │   ├── probmed/
│   │   ├── rmediation/
│   │   └── [others]
│   ├── stable/
│   └── archive/
│
├── teaching/                      ← COURSE materials (NEW!)
│   ├── courses/
│   │   ├── stats-415/             ← Links to Knowledge_Base/Teaching_Resources/STATS-415/
│   │   │   ├── week-01/
│   │   │   │   ├── lecture.qmd
│   │   │   │   ├── homework.qmd
│   │   │   │   └── _obsidian.md  ← Link to teaching notes
│   │   │   ├── week-02/
│   │   │   └── syllabus.qmd
│   │   ├── stats-535/
│   │   └── stats-630/
│   ├── materials/                 ← Shared teaching materials
│   └── generated/                 ← examify output
│
├── quarto/                        ← QUARTO projects
│   ├── extensions/
│   │   ├── unm-revealjs/
│   │   └── examark/
│   └── presentations/
│
├── apps/                          ← APPLICATIONS
│   └── examify/
│
└── dev-tools/                     ← INFRASTRUCTURE
    ├── zsh-claude-workflow/       🔒 PRIVATE
    ├── claude-statistical-research/
    ├── emacs-r-devkit/            ← emacs+r+zsh integration
    ├── obsidian-cli-ops/          ← Obsidian vault management
    ├── claude-r-dev/
    └── [others]
```

### Obsidian Vaults (Knowledge-Based)

**No changes to structure - stays as is:**

```
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/
│
├── Knowledge_Base/ (2,810 files)
│   ├── Programming_Languages/
│   │   ├── R/                     ← Links to ~/projects/r-packages/
│   │   ├── Emacs_DevKit/          ← Links to ~/projects/dev-tools/emacs-r-devkit/
│   │   ├── Python notes/
│   │   └── [others]
│   ├── Statistics_Theory/
│   ├── Math/
│   └── Teaching_Resources/
│       ├── STATS-415/             ← Links to ~/teaching/courses/stats-415/
│       ├── STATS-535/
│       └── STATS-630/
│
├── Research_Lab/ (512 files)
│   ├── Prod3_Manuscript/          ← Links to ~/research/active/product-of-three/
│   ├── Collider_Research/         ← Links to ~/research/active/collider/
│   ├── Diabetes_Research/         ← Links to ~/research/active/diabetes/
│   ├── RMediation_Package/        ← Links to ~/r-packages/active/rmediation/
│   ├── Simulation_Tools/
│   ├── 00_Incubator/              ← New project ideas
│   └── 02_Topic_Backlog/          ← Future topics
│
└── Life_Admin/ (218 files)
    ├── Career_Development/
    ├── Personal_Planning/
    └── [others]
```

---

## 🔗 Linking Strategy

### Bidirectional Links Between Files and Vaults

**In File System:** Add `_obsidian.md` to each project
```markdown
# Obsidian Notes

**Vault:** Research_Lab
**Folder:** Collider_Research

[Open in Obsidian](obsidian://open?vault=Research_Lab&file=Collider_Research/00_Dashboard)

## Quick Access

- Literature notes
- Research planning
- Ideas and brainstorming
- Methods documentation
```

**In Obsidian Vault:** Add file path links
```markdown
# Collider Research

**File Location:** `~/research/active/collider/`

## Quick Links

- [Data](file:///Users/dt/research/active/collider/data/)
- [Code](file:///Users/dt/research/active/collider/code/)
- [Manuscript](file:///Users/dt/research/active/collider/manuscript/)

## Recent Work

- [[Literature Review]]
- [[Methods Planning]]
- [[Analysis Ideas]]
```

---

## 🛠️ Tool Enhancements Needed

### 1. Update `research` Command

**Add Obsidian awareness:**

```bash
# New subcommand: research obsidian <project>
research obsidian collider
# Opens: Research_Lab/Collider_Research/ in Obsidian

# Enhanced: research status <project>
research status collider
# Shows BOTH:
#   - File location: ~/research/active/collider/
#   - Vault location: Research_Lab/Collider_Research/
#   - Bidirectional link status
```

### 2. Create `obsidian` Command

**New command for Obsidian integration:**

```bash
# Open vault in Obsidian
obsidian open Knowledge_Base

# Open specific note in Obsidian
obsidian note Research_Lab/Collider_Research/00_Dashboard

# Open project's Obsidian notes
obsidian project collider
# Opens linked vault folder

# Edit in Emacs (emacs+obsidian workflow)
obsidian edit Research_Lab/Collider_Research/Methods
# Opens note in Emacs
```

### 3. Enhance `proj-claude` Command

**Add claude+obsidian workflow:**

```bash
# When opening Claude Code, detect Obsidian links
proj-claude ~/research/active/collider

# Claude gets context from BOTH:
#   1. Project files (code, data, manuscripts)
#   2. Obsidian notes (literature, planning, ideas)
#
# Via MCP server Obsidian integration
```

### 4. Create `teaching` Command

**New command for teaching workflow:**

```bash
# Show teaching dashboard
teaching dashboard

# Work on course
teaching work stats-415
# Opens week folder + linked Obsidian notes

# Next week setup
teaching next-week stats-415
# Creates week-N/ folder + Obsidian template
```

---

## 📋 Migration Strategy

### Phase 1: Understand Current State (1 hour)

**Map Obsidian → File overlaps:**

```bash
# What research exists in BOTH places?
# - Obsidian Research_Lab/
# - File-based ~/Dropbox/Research/ or ~/research/

# Create mapping:
Prod3_Manuscript (Obsidian) ↔ product-of-three (Files) ❓
Collider_Research (Obsidian) ↔ collider (Files) ❓
Diabetes_Research (Obsidian) ↔ ❓ (not found in files)
RMediation_Package (Obsidian) ↔ rmediation (Files) ✓
```

**Questions to answer:**
1. Which Research_Lab projects have file counterparts?
2. Which file-based projects have Obsidian counterparts?
3. Which are Obsidian-only (ideas, planning)?
4. Which are file-only (old projects)?

### Phase 2: Establish Clear Boundaries (2 hours)

**Decision rules:**

| Content Type | Goes In | Example |
|--------------|---------|---------|
| Literature notes | Obsidian | Papers, references, summaries |
| Research ideas | Obsidian | Brainstorming, hypotheses |
| Methods planning | Obsidian | Analysis plans, pseudocode |
| Learning notes | Obsidian | Statistics theory, R learning |
| **Code** | Files | R scripts, simulation code |
| **Data** | Files | Raw data, processed datasets |
| **Manuscripts** | Files | .qmd, .Rmd, .tex documents |
| **Results** | Files | Figures, tables, output |

**Apply to each project:**
```bash
# For collider project:
# 1. Literature → Research_Lab/Collider_Research/Literature/
# 2. Ideas → Research_Lab/Collider_Research/Ideas/
# 3. Code → ~/research/active/collider/code/
# 4. Data → ~/research/active/collider/data/
# 5. Manuscript → ~/research/active/collider/manuscript/
```

### Phase 3: Create Bidirectional Links (1 hour)

**Add `_obsidian.md` to file projects:**
```bash
# For each active project
for proj in ~/research/active/*/; do
    # Create _obsidian.md with vault link
    cat > "$proj/_obsidian.md" << EOF
# Obsidian Notes

[Open in Obsidian](obsidian://open?vault=Research_Lab&file=${proj:t})
EOF
done
```

**Add file links to Obsidian notes:**
- Manual process (use Obsidian UI)
- Add `file://` links to project directories
- Create dashboard notes in each vault folder

### Phase 4: Tool Enhancement (3-5 hours)

1. **Update `research` command:**
   - Add Obsidian detection
   - Show vault links in status
   - Add `research obsidian <project>` subcommand

2. **Create `obsidian` command:**
   - Open vaults
   - Open specific notes
   - Edit in Emacs (emacs+obsidian)
   - Link project detection

3. **Enhance `proj-claude`:**
   - Detect `_obsidian.md` links
   - Include vault context in CLAUDE.md
   - MCP server integration for reading notes

4. **Create `teaching` command:**
   - Teaching-specific workflows
   - Link to Knowledge_Base/Teaching_Resources/

---

## 🎯 ADHD-Optimized Integration

### External Memory Principle

**Before:** "Where did I put my collider research notes?"
- Could be in Obsidian
- Could be in Dropbox files
- Could be in Google Drive
- **10-15 min searching**

**After:** "Everything for collider is linked"
```bash
research status collider
# Shows:
#   Files: ~/research/active/collider/
#   Notes: Research_Lab/Collider_Research/
#   [Open Files] [Open Notes]
# < 10 seconds
```

### Reduced Decisions

**Before:** "Should I write this in Obsidian or a file?"
- Constant context switching
- Duplication
- Inconsistency

**After:** Clear rules
- Literature/ideas → Always Obsidian
- Code/data/manuscripts → Always Files
- **No decision needed**

### Single Command Access

**Before:** Multi-step process
1. Open Finder
2. Navigate to iCloud
3. Find Obsidian folder
4. Find vault
5. Find note
6. **3-5 min**

**After:** One command
```bash
obsidian note Research_Lab/Collider_Research/Methods
# Opens immediately
# < 5 seconds
```

---

## 🔄 Workflow Examples

### Example 1: Starting Research for the Day

**Morning routine:**
```bash
# 1. See all active work
research dashboard
# Shows file-based projects + Obsidian vault links

# 2. Choose project
research work collider
# Opens file directory

# 3. Review notes
obsidian project collider
# Opens Research_Lab/Collider_Research/ in Obsidian

# 4. Start coding
# Work in ~/research/active/collider/code/
# Reference notes in Obsidian (mobile, graph view, links)

# Total time: < 30 seconds
```

### Example 2: Literature Review (claude+obsidian)

**Workflow:**
```bash
# 1. Start Claude with Obsidian context
proj-claude ~/research/active/collider

# 2. Ask Claude to research
"Research collider bias methods.
Save literature notes to Research_Lab/Collider_Research/Literature/"

# 3. Claude uses MCP server Obsidian tools
# - Creates notes in vault
# - Links related concepts
# - Suggests organization

# 4. Review in Obsidian
obsidian note Research_Lab/Collider_Research/Literature/
# Beautiful UI, graph view, mobile access

# 5. Code based on insights
# Back to ~/research/active/collider/code/
```

### Example 3: Heavy Editing (emacs+obsidian)

**Workflow:**
```bash
# 1. Long document in Obsidian
# Research_Lab/Collider_Research/Methods.md is getting long

# 2. Edit in Emacs
obsidian edit Research_Lab/Collider_Research/Methods
# Opens in Emacs with superior keybindings, modal editing

# 3. Save
# iCloud syncs automatically

# 4. View in Obsidian
# Graph updates, links work, mobile access restored
```

### Example 4: Teaching Prep

**Workflow:**
```bash
# 1. Work on week's lecture
teaching work stats-415
# Opens ~/teaching/courses/stats-415/current-week/

# 2. Reference teaching notes
# Auto-opens Knowledge_Base/Teaching_Resources/STATS-415/ in Obsidian

# 3. Edit lecture.qmd in files
# Reference examples from Obsidian vault

# 4. Generate exam with examify
examify exam ~/teaching/courses/stats-415/exam-1.yml
# Output to ~/teaching/generated/
```

---

## 📊 Benefits Summary

### Before Integration

**File System (Scattered):**
- Research in Dropbox (45+ projects)
- Research in ~/projects/research/ (1 project)
- No clear organization
- No connection to knowledge base

**Obsidian (Isolated):**
- Rich notes (3,540 files)
- Active research planning (Research_Lab)
- **BUT:** Disconnected from actual project files
- No way to jump between notes and code

**Problems:**
- Duplication (same project in both places)
- Searching takes 10-15 min
- Context switching overhead
- Mental load tracking everything

### After Integration

**Unified System:**
```
Files (~/projects/)     ←  Bidirectional Links  →    Obsidian (iCloud)
├─ Code                                              ├─ Literature
├─ Data                                              ├─ Ideas
├─ Manuscripts                                       ├─ Planning
└─ Results                                           └─ Learning
```

**Benefits:**
- ✅ Clear boundaries (code vs notes)
- ✅ One command access (`research`, `obsidian`, `teaching`)
- ✅ ADHD-friendly (external memory, no decisions)
- ✅ Three workflow integrations working together:
  - emacs+r+zsh (code development)
  - emacs+obsidian (heavy editing)
  - claude+obsidian (AI research)
- ✅ Mobile access (Obsidian)
- ✅ Find anything in < 10 seconds
- ✅ Never ask "where is this?"

---

## 🚀 Implementation Timeline

### Week 1: Analysis & Linking (5 hours)

**Day 1-2:** Map overlaps (1 hour)
- List all Research_Lab projects
- List all file-based research
- Create mapping document
- Identify ADHD top 3 active

**Day 3-4:** Create links (2 hours)
- Add `_obsidian.md` to file projects
- Add file links to Obsidian dashboards
- Test bidirectional navigation

**Day 5:** Test workflows (2 hours)
- Try research → obsidian flow
- Try obsidian → files flow
- Document pain points

### Week 2: Tool Building (8 hours)

**Day 1-2:** Update `research` command (3 hours)
- Add Obsidian detection
- Show vault links
- Add `research obsidian` subcommand

**Day 3:** Create `obsidian` command (2 hours)
- `obsidian open <vault>`
- `obsidian note <path>`
- `obsidian project <name>`
- `obsidian edit <path>` (emacs integration)

**Day 4:** Create `teaching` command (2 hours)
- `teaching dashboard`
- `teaching work <course>`
- `teaching next-week <course>`

**Day 5:** Enhance `proj-claude` (1 hour)
- Add Obsidian context detection
- MCP server configuration

### Week 3: Migration & Polish (6 hours)

**Day 1-3:** Migrate research (4 hours)
- Move Dropbox research to ~/research/
- Align with Obsidian Research_Lab/
- Create links for all active projects
- Setup Google Drive backup

**Day 4-5:** Polish & document (2 hours)
- Create workflow docs
- Update ACTION_QUICK_REF.md
- Test all three integrations:
  - emacs+r+zsh ✓
  - emacs+obsidian ✓
  - claude+obsidian ✓

---

## 📋 Success Metrics

### Immediate (Week 1)
- ✅ Can navigate from any research file to Obsidian notes in < 10 seconds
- ✅ Can navigate from any Obsidian note to project files in < 10 seconds
- ✅ Clear decision rules for "file vs note"

### Short-term (Week 2-3)
- ✅ `research` command shows Obsidian links
- ✅ `obsidian` command works for all workflows
- ✅ `teaching` command streamlines course prep
- ✅ All active research migrated from Dropbox

### Long-term (Month 1-2)
- ✅ Three workflow integrations in daily use:
  - emacs+r+zsh for R development
  - emacs+obsidian for heavy editing
  - claude+obsidian for research/learning
- ✅ Zero time wasted searching for files or notes
- ✅ Morning research start time: < 30 seconds
- ✅ Teaching prep time reduced 30%

---

## 🎓 Tool Ecosystem Summary

### Your Complete Workflow Stack

| Layer | Tools | Purpose | Status |
|-------|-------|---------|--------|
| **Knowledge** | Obsidian (3 vaults) | Notes, literature, ideas | ✅ Active |
| **Code** | Emacs+ESS+LSP | R development | ✅ Active |
| **Shell** | zsh + zsh-claude-workflow | Automation, detection | ✅ Active |
| **AI** | Claude + MCP server | Research, synthesis | ✅ Active |
| **Coordination** | obsidian-cli-ops | Vault management | ✅ Active |
| **Integration 1** | emacs-r-devkit | emacs+r+zsh | ✅ Configured |
| **Integration 2** | Emacs markdown-mode | emacs+obsidian | ⚠️ Needs commands |
| **Integration 3** | MCP Obsidian tools | claude+obsidian | ⚠️ Needs config |

**Missing Pieces:**
1. Shell commands for obsidian integration (`obsidian` command)
2. MCP server configuration for claude+obsidian
3. Teaching workflow commands (`teaching` command)
4. Bidirectional linking between files and vaults

---

**Last Updated:** 2025-12-10
**Status:** Comprehensive analysis complete, ready for implementation
**Next:** Map Research_Lab ↔ File overlaps, create linking strategy
