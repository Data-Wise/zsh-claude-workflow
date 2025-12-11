# Full Portfolio ADHD-Optimized Structure

> **Date:** 2025-12-10
> **Extends:** ADHD_OPTIMIZED_RESTRUCTURE.md
> **Scope:** ALL projects (research, quarto, apps, dev-tools, R packages, teaching)

---

## 🎯 The Complete Picture

Your work spans **6 distinct contexts**, each needing different organization:

```
~/projects/
├── r-packages/          ← MediationVerse ecosystem (6 packages)
├── research/            ← Research projects (manuscripts, simulations)
├── quarto/              ← Quarto projects (extensions, presentations)
├── apps/                ← Applications (examify, etc.)
├── dev-tools/           ← Infrastructure (this project, MCP servers)
└── ~/teaching/          ← Teaching (NEW - dedicated directory)
```

**Current problem:** Each context needs different tools, but you're treating them the same.

---

## 📊 Context-Specific Organization

### Context 1: R Packages (Already Solved)

**Structure:**
```
~/projects/r-packages/
├── active/              ← MediationVerse (6 packages)
├── stable/              ← Production ready
├── archive/             ← Old/deprecated
└── scratch/             ← Experiments
```

**ADHD Solution:**
- ✅ Workspace file (`mediationverse-dev.code-workspace`)
- ✅ Commands: `ecosystem status-all`, `ecosystem check-breaks`
- ✅ Clear hierarchy: active > stable > archive > scratch

**Mental mode:** "I'm developing R packages"

---

### Context 2: Research Projects (NEEDS STRUCTURE)

**Current state:**
```
~/projects/research/
└── mediation-planning/  ← Sequential mediation research
```

**Problem:** Research projects span multiple formats
- Literature notes (Zotero, markdown)
- Simulation code (R scripts)
- Manuscripts (Quarto)
- Analysis results (plots, tables)
- Presentation slides (Quarto)

**ADHD-optimized structure:**

```
~/projects/research/
└── mediation-planning/
    ├── _active/                  ← Currently working on
    │   ├── lit-notes/           ← Literature notes
    │   ├── sims/                ← Simulation code
    │   ├── analysis/            ← Analysis scripts
    │   └── _checklist.md        ← What's needed for completion
    │
    ├── manuscripts/
    │   ├── paper-01-product-of-three/
    │   │   ├── manuscript.qmd
    │   │   ├── references.bib
    │   │   ├── figures/
    │   │   └── _status.md       ← Submitted? Under review? Revisions?
    │   └── paper-02-bootstrap/
    │
    ├── presentations/
    │   ├── jsm-2025/
    │   └── aera-2026/
    │
    ├── archive/                  ← Completed work
    │   └── pilot-study/
    │
    └── RESEARCH.md               ← Overview, goals, timeline
```

**Key principles:**
- `_active/` = work in progress (only one thing active)
- `manuscripts/` = paper-specific directories
- `presentations/` = talk-specific directories
- `_checklist.md` in active = clear next actions
- `_status.md` in manuscripts = track submission status

**Commands needed:**
```bash
# See all research projects
research status-all

# Start new manuscript
research new-paper "Product of Three Distributions"
# Creates: manuscripts/paper-03-product-of-three/ with template

# Track submission
research track paper-01 "Submitted to JASA 2025-12-10"

# Archive completed work
research archive pilot-study
```

**Mental mode:** "I'm doing research"

---

### Context 3: Quarto Projects (NEEDS STRUCTURE)

**Current state:**
```
~/projects/quarto/
├── extensions/          ← Quarto extensions
├── manuscripts/         ← Research manuscripts
└── presentations/       ← Slides
```

**Problem:** Mixing different lifecycles
- Extensions are software (versioned, released)
- Manuscripts are one-time deliverables
- Presentations are event-specific

**ADHD-optimized structure:**

```
~/projects/quarto/
├── extensions/
│   ├── unm-revealjs/           ← Quarto extension for UNM slides
│   │   ├── _extension.yml
│   │   ├── template.qmd
│   │   └── CHANGELOG.md        ← Track versions
│   └── examark/                ← Exam format extension
│
├── manuscripts/ → SYMLINK to ~/projects/research/*/manuscripts/
│   # Don't duplicate - use symlinks to research projects
│
├── presentations/
│   ├── 2025/
│   │   ├── jsm-2025/          ← Event-specific
│   │   └── aera-2025/
│   └── 2026/
│       └── icots-2026/
│
└── templates/
    ├── paper-template/         ← Reusable templates
    ├── slides-template/
    └── poster-template/
```

**Key principles:**
- Extensions are software → treat like R packages (versioning)
- Manuscripts live in research projects → symlink only
- Presentations organized by year → clear boundaries
- Templates prevent blank page anxiety

**Commands needed:**
```bash
# See all Quarto extensions
quarto-ext list

# Create new presentation from template
quarto-pres new "JSM 2026" --template=unm-revealjs

# Preview presentation
quarto-pres preview jsm-2026

# Release extension version
quarto-ext release unm-revealjs 2.1.0
```

**Workspace file:**
```bash
# All Quarto extensions in one workspace
code ~/projects/quarto/extensions.code-workspace
```

**Mental mode:** "I'm creating Quarto content"

---

### Context 4: Apps (NEEDS STRUCTURE)

**Current state:**
```
~/projects/apps/
└── examify/             ← Quiz/exam app
```

**Problem:** Apps have different lifecycle than packages
- Development vs production
- Dependencies (node_modules, etc.)
- Deployment status
- User-facing vs internal tools

**ADHD-optimized structure:**

```
~/projects/apps/
├── examify/
│   ├── src/                    ← Source code
│   ├── tests/
│   ├── docs/
│   ├── _dev-notes.md           ← Current work, TODOs
│   ├── _deployment.md          ← Where deployed, how to deploy
│   └── CHANGELOG.md            ← User-facing changes
│
├── future-app/
│
└── _active.md                  ← Which app am I working on?
```

**Key principles:**
- `_dev-notes.md` = what you're currently working on
- `_deployment.md` = deployment checklist (prevent forgetting steps)
- `_active.md` at top level = only focus on one app at a time

**Commands needed:**
```bash
# See all apps status
apps status-all

# Set active app
apps focus examify

# Deploy app
apps deploy examify production

# Remember state
apps remember "Adding grade import feature, next: CSV parsing"
```

**Mental mode:** "I'm building an app"

---

### Context 5: Dev-Tools (NEEDS STRUCTURE)

**Current state:**
```
~/projects/dev-tools/
├── zsh-claude-workflow/        ← This project
├── claude-statistical-research/ ← MCP server
├── claude-r-dev/               ← R development profiles
├── emacs-r-devkit/             ← Emacs config
├── homebrew-tap/               ← Homebrew formulas
└── r-package-dev-gemini/       ← Gemini integration
```

**Problem:** These are infrastructure that support other work
- Updates affect all other projects
- Need careful testing before rollout
- Documentation critical

**ADHD-optimized structure:**

```
~/projects/dev-tools/
├── _infrastructure-status.md   ← Health dashboard
│
├── zsh-claude-workflow/
│   ├── _active-feature.md     ← What you're building
│   └── _testing-checklist.md  ← Test before deploying
│
├── claude-statistical-research/
│   ├── _mcp-status.md         ← MCP server health
│   └── _skills-catalog.md     ← What skills are available
│
├── claude-r-dev/
│
└── scripts/
    ├── test-all-tools.sh      ← Test ALL tools before commit
    └── update-all-docs.sh     ← Keep docs in sync
```

**Key principles:**
- `_infrastructure-status.md` = see health of all tools
- Test before deploying (affects all other work!)
- Document thoroughly (future you will forget)

**Commands needed:**
```bash
# Check all dev-tools health
devtools health-check

# Test all tools before committing
devtools test-all

# Update documentation across all tools
devtools sync-docs

# Deploy new version
devtools deploy zsh-claude-workflow 1.5.0
```

**Mental mode:** "I'm maintaining infrastructure"

---

### Context 6: Teaching (Already Solved)

**Structure:**
```
~/teaching/
├── courses/
│   ├── stats-415/
│   ├── stats-535/
│   └── stats-630/
├── materials/
└── generated/
```

**ADHD Solution:** Covered in ADHD_OPTIMIZED_RESTRUCTURE.md

**Mental mode:** "I'm teaching"

---

## 🎯 Context-Switching Dashboard

**Problem:** "Which context am I in? What was I doing?"

**Solution:** `pj-dashboard` command

```bash
pj-dashboard
```

**Output:**
```
📊 PROJECT PORTFOLIO DASHBOARD

🔬 RESEARCH
  mediation-planning       [●] Active: simulations in progress
    → Next: Run power analysis for n=500

📦 R PACKAGES
  MediationVerse          [●] 2 packages need commits
    → medfit: 2 uncommitted files
    → medsim: 1 uncommitted file

📝 QUARTO
  unm-revealjs            [✓] Clean (v2.0.3)
  examark                 [●] Working on: table parsing

📱 APPS
  examify                 [✓] Clean, deployed to prod

🛠️ DEV-TOOLS
  zsh-claude-workflow     [●] Building: ecosystem commands
    → Next: Build ecosystem status-all

👨‍🏫 TEACHING
  stats-415               [⚠] Week 8 lecture due Wednesday
  stats-535               [✓] All current

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠ PRIORITY ACTIONS:
  1. Commit medfit changes (2 files)
  2. Finish stats-415 week 8 lecture (due Wed)
  3. Complete power analysis simulation

💭 LAST STATE:
  "Building ecosystem status-all command for zsh-claude-workflow"
  Saved: 1 hour ago

📍 RESUME:
  → ecosystem recall
```

**ADHD Benefits:**
- See everything at once (external memory)
- Color-coded priorities
- Clear next actions
- No need to remember context

---

## 🗂️ Workspace Files for Each Context

### R Packages Workspace
```bash
code ~/projects/r-packages/mediationverse-dev.code-workspace
```
→ See all 6 packages

### Research Workspace
```bash
code ~/projects/research/research.code-workspace
```
→ All research projects + literature + sims

### Quarto Extensions Workspace
```bash
code ~/projects/quarto/extensions.code-workspace
```
→ All Quarto extensions for development

### Dev-Tools Workspace
```bash
code ~/projects/dev-tools/infrastructure.code-workspace
```
→ All infrastructure tools

**ADHD Benefit:** One command enters full context

---

## 📋 Unified Commands Across Contexts

### Pattern: `<context> <action>`

| Context | Status Command | Remember Command | New Command |
|---------|---------------|------------------|-------------|
| R packages | `ecosystem status-all` | `ecosystem remember` | `ecosystem new-package` |
| Research | `research status-all` | `research remember` | `research new-paper` |
| Quarto | `quarto-ext list` | `quarto-pres remember` | `quarto-pres new` |
| Apps | `apps status-all` | `apps remember` | `apps new` |
| Dev-tools | `devtools health-check` | `devtools remember` | `devtools new-tool` |
| Teaching | `teaching status` | `teaching remember` | `teaching next-week` |
| **ALL** | `pj-dashboard` | `pj-remember` | - |

**ADHD Benefit:** Consistent pattern, easy to remember

---

## 🔄 Daily Workflow Examples

### Morning: What needs attention?

```bash
pj-dashboard
```

**Output tells you:**
- Research: Need to run simulations
- R packages: 2 need commits
- Teaching: Lecture due Wednesday
- Apps: All clean

**Pick highest priority** → Enter that context

### Working on Research

```bash
# Enter research context
cd ~/projects/research/mediation-planning

# See what's active
research status

# Output:
# Active: Power analysis simulations
# Next: Run n=500 case
# Files modified: sims/power-analysis.R

# Do work...
Rscript sims/power-analysis.R

# Save state before lunch
research remember "Completed n=500, next: n=1000"
```

### Switching to Teaching

```bash
# Save research state
research remember "Power analysis in progress, n=500 done"

# Switch to teaching
cd ~/teaching/courses/stats-415

# Recall teaching state
teaching recall

# Output:
# Last work: Week 8 lecture outline
# Due: Wednesday 5pm
# Files open: week-08/lecture.qmd

# Do teaching work...
quarto preview week-08/lecture.qmd

# Save teaching state
teaching remember "Lecture slides done, need to record video"
```

### Returning to Research

```bash
# Recall research state
cd ~/projects/research/mediation-planning
research recall

# Output:
# Last work: "Power analysis in progress, n=500 done"
# Next: Run n=1000 case
# Opens: sims/power-analysis.R

# Continue where you left off
```

**ADHD Benefit:** Zero mental effort to context switch

---

## 🎯 Project Type Detection

**Enhanced `proj-type` command:**

```bash
proj-type ~/projects/research/mediation-planning
# Output: research

proj-type ~/projects/r-packages/active/medfit
# Output: r-package

proj-type ~/projects/quarto/presentations/jsm-2025
# Output: quarto-presentation

proj-type ~/projects/apps/examify
# Output: app

proj-type ~/projects/dev-tools/zsh-claude-workflow
# Output: dev-tool

proj-type ~/teaching/courses/stats-415
# Output: teaching
```

**Auto-activates context-specific tools:**
```bash
cd ~/projects/research/mediation-planning
# Auto-loads: research skills, Zotero integration, simulation tools

cd ~/projects/r-packages/active/medfit
# Auto-loads: R package skills, devtools, ecosystem commands

cd ~/teaching/courses/stats-415
# Auto-loads: teaching skills, examify, Canvas integration
```

---

## 🗺️ Visual Project Map

```
YOUR COMPLETE PORTFOLIO

├─ 📚 Teaching               ~/teaching/
│  └─ 3 courses              ✓ Organized
│
├─ 🔬 Research               ~/projects/research/
│  └─ mediation-planning     ⬜ Needs structure
│     ├─ Manuscripts
│     ├─ Simulations
│     └─ Literature
│
├─ 📦 R Packages             ~/projects/r-packages/
│  ├─ MediationVerse (6)     ✓ Workspace ready
│  ├─ Stable (production)
│  └─ Scratch (experiments)
│
├─ 📝 Quarto                 ~/projects/quarto/
│  ├─ Extensions (2)         ⬜ Needs workspace
│  └─ Presentations          ⬜ Needs yearly structure
│
├─ 📱 Apps                   ~/projects/apps/
│  └─ examify                ⬜ Needs dev notes
│
└─ 🛠️ Dev-Tools             ~/projects/dev-tools/
   ├─ zsh-claude-workflow    [●] Active development
   ├─ MCP server
   ├─ claude-r-dev
   └─ 3 others               ⬜ Needs health dashboard
```

---

## 🚀 Implementation Priorities

### Phase 1: Dashboard (Build FIRST - 2 hours)

**Why first:** See everything, prioritize rest

```bash
# Build pj-dashboard
# Shows status of all contexts
# Replaces mental tracking
```

**ADHD Impact:** HIGHEST
- External memory for entire portfolio
- Visual priorities
- One command overview

---

### Phase 2: Research Structure (1 hour)

**Why second:** Research is scattered

```bash
# Restructure mediation-planning/
# Add _active/, manuscripts/, presentations/
# Create research commands
```

**Commands to build:**
- `research status-all`
- `research new-paper`
- `research remember`

---

### Phase 3: Quarto Organization (1 hour)

```bash
# Create extensions.code-workspace
# Reorganize presentations/ by year
# Build quarto-pres commands
```

**Commands to build:**
- `quarto-pres new`
- `quarto-pres preview`
- `quarto-ext list`

---

### Phase 4: Apps & Dev-Tools (1.5 hours)

```bash
# Add _dev-notes.md to examify
# Create _infrastructure-status.md
# Build health-check commands
```

**Commands to build:**
- `apps status-all`
- `devtools health-check`
- `devtools test-all`

---

### Phase 5: Context Memory (2 hours)

```bash
# Unified pj-remember/recall
# Works across all contexts
# Stack-based context switching
```

**Commands to build:**
- `pj-remember`
- `pj-recall`
- `pj-history`

---

## 📊 Before/After Comparison

| Task | Before | After |
|------|--------|-------|
| **See all work** | Remember mentally | `pj-dashboard` |
| **Switch contexts** | Remember where you were | `research recall` |
| **Check research status** | Open files manually | `research status-all` |
| **Start new paper** | Create dirs manually | `research new-paper "Title"` |
| **Preview presentation** | cd, find file, run quarto | `quarto-pres preview jsm-2025` |
| **Check app deployment** | Look at notes? | `apps status-all` |
| **Test dev-tools** | Manual testing | `devtools test-all` |
| **Morning planning** | Think about what needs doing | `pj-dashboard` shows priorities |

---

## ✅ Complete Implementation Checklist

### Week 1: Foundations (4 hrs)

**Monday (1 hr):**
- [ ] Build `pj-dashboard` command
- [ ] Create `lib/project-portfolio.sh` library
- [ ] Test on all project types

**Tuesday (1 hr):**
- [ ] Restructure `mediation-planning/`
- [ ] Add `_active/`, `manuscripts/`, `presentations/`
- [ ] Create `_checklist.md` template

**Wednesday (1 hr):**
- [ ] Build `research status-all` command
- [ ] Build `research new-paper` command
- [ ] Test research workflow

**Thursday (1 hr):**
- [ ] Create Quarto workspaces
- [ ] Build `quarto-pres` commands
- [ ] Test Quarto workflow

### Week 2: Advanced (4 hrs)

**Monday (1 hr):**
- [ ] Add `_dev-notes.md` to examify
- [ ] Build `apps status-all`
- [ ] Build `apps remember/recall`

**Tuesday (1 hr):**
- [ ] Create `_infrastructure-status.md`
- [ ] Build `devtools health-check`
- [ ] Build `devtools test-all`

**Wednesday (2 hrs):**
- [ ] Build unified `pj-remember/recall`
- [ ] Implement context stack
- [ ] Test cross-context switching

### Week 3: Refinement (2 hrs)

**Use everything daily, note friction points, iterate**

---

## 🎯 Success Criteria

### Daily Success
- [ ] Can see entire portfolio status in <10 seconds
- [ ] Can switch contexts in <1 minute
- [ ] Never forget where you were in a project

### Weekly Success
- [ ] Research, teaching, R packages all progressing
- [ ] No "where did I put that file?" moments
- [ ] Context switching is effortless

### Monthly Success
- [ ] All 6 contexts have clear structure
- [ ] Morning planning takes <5 minutes
- [ ] External memory systems working smoothly

---

## 📍 Quick Reference by Project Type

### When working on RESEARCH
```bash
pj-dashboard              # See all projects
research status-all       # See research status
research new-paper "Title" # Start new manuscript
research remember "State"  # Save state
research recall           # Continue work
```

### When working on QUARTO
```bash
quarto-pres new "Event"   # New presentation
quarto-pres preview name  # Preview slides
quarto-ext list           # List extensions
quarto-ext release name   # Release extension
```

### When working on APPS
```bash
apps status-all           # See all apps
apps focus examify        # Set active app
apps remember "State"     # Save state
apps deploy name prod     # Deploy to production
```

### When working on DEV-TOOLS
```bash
devtools health-check     # Check all tools
devtools test-all         # Test before commit
devtools sync-docs        # Update docs
devtools deploy name ver  # Deploy new version
```

### When working on R PACKAGES
```bash
ecosystem status-all      # See all packages
ecosystem check-breaks    # Test downstream
ecosystem install-dev     # Install with local deps
```

### When working on TEACHING
```bash
teaching status           # See all courses
teaching next-week        # Create next week
ecosystem teaching upload # Upload to Canvas
```

### ANY CONTEXT
```bash
pj-dashboard             # See everything
pj-remember "State"      # Save any context
pj-recall                # Resume any context
```

---

**Next:** Build `pj-dashboard` to see your complete portfolio at a glance

**Full restructure:** `ADHD_OPTIMIZED_RESTRUCTURE.md`
**Quick reference:** `ACTION_QUICK_REF.md`
