# SCATTERED RESEARCH CRISIS - Urgent Fix Needed

> **Date:** 2025-12-10
> **Severity:** 🔴 CRITICAL for ADHD productivity
> **Impact:** High cognitive load, lost files, duplicate work

---

## 🚨 The Problem

Your research is scattered across **3-4 locations**:

### Location 1: Dropbox/Research/ (PRIMARY - 51 subdirectories!)

```
~/Dropbox/Research/
├── collider/                    ← Active project?
├── DAG/                         ← Active?
├── data_analysis_plan/          ← Active?
├── pmed/                        ← Related to probmed package?
├── sensitivity/                 ← Active?
├── LC Mediation Models/         ← Active?
├── mult_med/                    ← Active?
├── missing effect/              ← Active?
├── Inteventional mediation/     ← Active?
├── nonrandomized mediation/     ← Active?
├── lavaanplus/                  ← Active?
├── Replication/                 ← Active?
├── Simulation Studies/          ← Active?
│
├── published/                   ← 28 items (archive)
├── past/                        ← 18 items (archive)
├── future/                      ← 17 items (planning?)
│
├── Chapter_07New91.docx         ← Mixed files in root!
├── analysis_plan2.qmd           ← Mixed with directories
├── Data.xlsx                    ← Raw data in root!
└── [Many more loose files]      ← Unorganized
```

**Total:** ~51 items in ONE directory

### Location 2: Google Drive/research/

```
~/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/My Drive/research/
└── [Empty or limited - couldn't access]
```

### Location 3: Local ~/projects/research/

```
~/projects/research/
└── mediation-planning/          ← Only 1 project here
```

### Location 4: OneDrive (University of New Mexico)

```
~/Library/CloudStorage/OneDrive-UniversityofNewMexico/
└── [Not checked yet - likely has work files]
```

---

## 💥 ADHD Impact Assessment

### Current Cognitive Load: EXTREME

**Every time you want to work on research:**

1. ❓ "Where did I put that analysis?"
   - Is it in Dropbox/Research/?
   - Or ~/projects/research/?
   - Or Google Drive?
   - Or a subdirectory?

2. ❓ "Which projects are active?"
   - 51 directories in Dropbox/Research/
   - Can't tell active vs archived at a glance
   - No clear hierarchy

3. ❓ "What was I working on?"
   - No _active/ indicator
   - Mixed files and directories
   - past/, future/, published/ but no "current/"

4. ❓ "Did I already do this?"
   - Duplicate projects (mult_med, LC Mediation Models)
   - Can't see what's related
   - Risk of re-doing work

### Time Waste Estimate

**Per research session:**
- 5-10 min: "Where did I put that file?"
- 3-5 min: "Which project am I working on?"
- 2-3 min: "Is this in Dropbox or local?"

**Total:** 10-18 minutes of cognitive load **BEFORE** starting actual work

**Per week:** 50-90 minutes wasted searching

**Per month:** 3-6 hours wasted

---

## 🎯 ADHD-Optimized Research Structure

### Principle: ONE location, clear hierarchy

```
~/research/                       ← NEW: Primary location (local, fast)
│
├── _dashboard.md                 ← What's active, what's next
│
├── active/                       ← ONLY current work (max 3 projects)
│   ├── product-of-three/        ← Main project now
│   │   ├── manuscript/
│   │   ├── simulations/
│   │   ├── literature/
│   │   └── _next.md             ← Clear next action
│   │
│   ├── collider-project/        ← If active
│   └── [MAX 3 projects]         ← ADHD-friendly limit
│
├── planning/                     ← Future projects (not started)
│   ├── missing-effect-study/
│   ├── sensitivity-methods/
│   └── interventional-mediation/
│
├── published/                    ← Completed & published (ARCHIVE)
│   ├── 2023-lc-mediation/
│   ├── 2024-bootstrap-ci/
│   └── [Year-Project naming]
│
├── in-review/                    ← Submitted, waiting
│   ├── pmed-jasa-2025/
│   │   ├── manuscript/
│   │   ├── reviews/
│   │   └── _status.md           ← Submitted date, reviews received
│   └── [Status tracking]
│
├── teaching-related/             ← Research done for teaching
│   ├── simulation-studies/
│   └── tutorial-materials/
│
├── collaborations/               ← Joint projects
│   ├── dave-chapter/
│   └── sarah-analysis/
│
├── archive/                      ← Old, completed, not published
│   ├── pilot-studies/
│   ├── failed-projects/
│   └── deprecated/
│
└── _migration-log.md             ← Track what came from where
```

### Key Principles

1. **Single source of truth:** Everything in `~/research/`
2. **Active limit:** Max 3 projects in active/ (ADHD-friendly)
3. **Clear states:** active/ → in-review/ → published/ → archive/
4. **Visual hierarchy:** See status at a glance
5. **Next actions:** Every active project has `_next.md`

---

## 🔄 Migration Plan

### Phase 1: Assess (30 min - TODAY)

**Create inventory:**

```bash
# Count active vs archive in Dropbox
cd ~/Dropbox/Research

# Which projects are ACTUALLY active?
# Last modified in past 3 months = active
find . -maxdepth 1 -type d -mtime -90 | sort
```

**Expected active projects:** ~5-10 (not 51!)

### Phase 2: Migrate Active Projects (2 hours - THIS WEEK)

**For each active project:**

```bash
# Create new structure
mkdir -p ~/research/active/project-name/{manuscript,simulations,literature,data}

# Move from Dropbox
mv ~/Dropbox/Research/project-name/* ~/research/active/project-name/simulations/

# Create _next.md
cat > ~/research/active/project-name/_next.md << EOF
# Next Actions

## Immediate (This Week)
- [ ] Run power analysis for n=500
- [ ] Update manuscript methods section

## Soon (Next 2 Weeks)
- [ ] Submit to JASA

## Waiting On
- [ ] Feedback from co-author
EOF
```

### Phase 3: Archive Old Projects (1 hour)

```bash
# Projects not touched in 6+ months
mkdir -p ~/research/archive

# Move to archive
mv ~/Dropbox/Research/old-project ~/research/archive/
```

### Phase 4: Setup Cloud Backup (5 min)

> **Updated 2025-12-10:** Using Google Drive app for backup (migrating FROM Dropbox due to cost)

```bash
# Configure Google Drive app to back up ~/research/
# (Already installed, just configure)

# 1. Open Google Drive app
# 2. Preferences → "Folders from your computer"
# 3. Click "Add folder" and select ~/research/
# 4. Choose "Backup files" (recommended)
# 5. Click "Done"

# That's it! Google Drive app handles automatic backup.
# No symlinks needed.

# Optional: Verify sync
open "https://drive.google.com/drive/my-drive"
# Look for Backup/research/ folder
```

---

## 📊 Dropbox/Research/ Analysis

### Likely Active Projects (needs verification):

Based on names and common patterns:

**Active (work in progress):**
- [ ] collider/ - Collider bias research?
- [ ] DAG/ - Causal diagrams work?
- [ ] data_analysis_plan/ - Current analysis?
- [ ] pmed/ - Related to probmed R package
- [ ] sensitivity/ - Sensitivity analysis methods
- [ ] LC Mediation Models/ - Latent class mediation
- [ ] mult_med/ - Multiple mediators
- [ ] missing effect/ - Missing data methods
- [ ] Inteventional mediation/ - Causal mediation
- [ ] nonrandomized mediation/ - Observational data methods
- [ ] Simulation Studies/ - Simulation work
- [ ] Replication/ - Replication study

**Archive (completed):**
- [ ] published/ - 28 items (DEFINITELY archive)
- [ ] past/ - 18 items (DEFINITELY archive)
- [ ] Dave Chapter/ - Collaboration (check status)

**Planning (future):**
- [ ] future/ - 17 items (move to planning/)

**Questions to ask yourself:**

1. **Which 3 projects am I ACTUALLY working on now?**
   - Project 1: _______________
   - Project 2: _______________
   - Project 3: _______________

2. **Which projects are waiting for something?**
   - Waiting for reviews: _______________
   - Waiting for co-authors: _______________
   - Waiting for data: _______________

3. **Which projects are "someday maybe"?**
   - Interesting but not urgent: _______________

---

## 🚀 Immediate Action Plan

### Today (30 min)

```bash
# 1. Create new structure
mkdir -p ~/research/{active,planning,in-review,published,archive,collaborations}

# 2. Identify your TOP 3 active projects
cd ~/Dropbox/Research
ls -lt | head -15  # Recently modified

# Write down your top 3:
echo "1. _____________" > ~/research/_active-projects.txt
echo "2. _____________" >> ~/research/_active-projects.txt
echo "3. _____________" >> ~/research/_active-projects.txt

# 3. Create dashboard
cat > ~/research/_dashboard.md << 'EOF'
# Research Dashboard

Last updated: 2025-12-10

## Active Projects (Max 3)

### 1. [Project Name]
**Status:** In progress
**Next:** [Next action]
**Location:** ~/research/active/project-name/
**Deadline:** [If any]

### 2. [Project Name]
**Status:** In progress
**Next:** [Next action]

### 3. [Project Name]
**Status:** In progress
**Next:** [Next action]

## In Review

- [Paper name] - Submitted to [Journal] on [Date]

## Planning (Future)

- [Project idea 1]
- [Project idea 2]

## Blocked/Waiting

- [Project] - Waiting for [reason]
EOF
```

### This Week (2 hours total, 30 min/day)

**Monday:** Migrate project 1
**Tuesday:** Migrate project 2
**Wednesday:** Migrate project 3
**Thursday:** Archive old projects, clean up

### Next Week

**Use new structure exclusively**
- All new work goes in ~/research/active/
- Update _dashboard.md daily (30 seconds)
- Never search for files again

---

## 🎯 Research Commands to Build

### Priority 1: Dashboard (30 min)

```bash
research dashboard
```

**Output:**
```
🔬 RESEARCH DASHBOARD

ACTIVE PROJECTS (3)
  1. product-of-three       [●] Simulations 80% done
     Next: Run n=500 power analysis
     Modified: 2 hours ago

  2. collider-bias          [●] Writing in progress
     Next: Finish methods section
     Modified: 1 day ago

  3. sensitivity-methods    [⚠] Blocked: waiting for data
     Waiting: Co-author to send dataset

IN REVIEW (1)
  pmed-jasa                 [⏳] Submitted 2025-12-01
     Status: Under review (10 days)

PLANNING (5 projects)
PUBLISHED (28 papers)
ARCHIVE (15 projects)
```

### Priority 2: Research Status

```bash
research status project-name
```

**Output:**
```
📊 Product of Three - Status

Location: ~/research/active/product-of-three/
Status:   In progress (80% complete)
Modified: 2 hours ago

FILES:
  manuscript/paper.qmd              [●] 3,245 words
  simulations/power-analysis.R      [●] Modified today
  literature/notes.md               [✓] Complete
  data/results.csv                  [✓] 1,000 rows

NEXT ACTIONS:
  [ ] Run n=500 power analysis
  [ ] Update methods section
  [ ] Generate final figures

TIMELINE:
  Started:  2025-10-15
  Deadline: 2026-01-15 (JASA submission)
  Days remaining: 36
```

### Priority 3: Quick Start

```bash
research work product-of-three
```

**What it does:**
```bash
# 1. cd to project
cd ~/research/active/product-of-three

# 2. Show next actions
cat _next.md

# 3. Open recent files
code manuscript/paper.qmd simulations/power-analysis.R

# 4. Remind you of context
research recall product-of-three
```

---

## 📋 Decision Matrix

### What Goes Where?

| Type | Location | Reason |
|------|----------|--------|
| **Actively writing paper** | `active/` | Work in progress |
| **Submitted, waiting for reviews** | `in-review/` | Clear status |
| **Published paper** | `published/` | Archive |
| **Interesting idea, not started** | `planning/` | Future work |
| **Old project, not publishing** | `archive/` | Keep but not active |
| **Co-author collaboration** | `collaborations/` | Shared ownership |
| **Teaching example** | `teaching-related/` | Different purpose |
| **Failed/abandoned** | `archive/failed/` | Learn from |

### Active Project Criteria

A project is **active** if:
- ✅ You worked on it in past 2 weeks
- ✅ You plan to work on it this week
- ✅ You can state clear next action

A project should be **archived** if:
- ❌ Not touched in 3+ months
- ❌ No clear next action
- ❌ Waiting indefinitely

---

## 🔍 Comparison: Before vs After

### Before (Current State)

```bash
# Want to work on collider project
# Mental process:
"Where did I put that?"
→ Check ~/projects/research/ (not there)
→ Check ~/Dropbox/Research/ (51 items!)
→ Scroll through looking for "collider"
→ Open collider/ directory
→ Multiple files, which was I editing?
→ Open several files to remember
→ 10 minutes later, finally starting work
```

**Cognitive load:** HIGH
**Time to start:** 10+ minutes
**Frustration:** HIGH

### After (Proposed Structure)

```bash
# Want to work on collider project
research work collider

# Automatic:
→ cd ~/research/active/collider/
→ Shows _next.md: "Next: Finish methods section"
→ Opens manuscript/paper.qmd at last edit
→ Ready to work in 30 seconds
```

**Cognitive load:** LOW
**Time to start:** 30 seconds
**Frustration:** NONE

---

## ✅ Migration Checklist

### Preparation
- [ ] Read this document
- [ ] Answer: "What are my top 3 active projects?"
- [ ] Create ~/research/ structure
- [ ] Create _dashboard.md template

### Migration (1 project at a time)
- [ ] Choose project from Dropbox/Research/
- [ ] Create ~/research/active/project-name/
- [ ] Move/copy files to new structure
- [ ] Create _next.md with clear actions
- [ ] Update _dashboard.md
- [ ] Test: `research work project-name`

### Cleanup
- [ ] Move published/ to ~/research/published/
- [ ] Move past/ to ~/research/archive/
- [ ] Move future/ to ~/research/planning/
- [ ] Keep Dropbox as backup only

### Validation
- [ ] Can find any project in <10 seconds
- [ ] Know what to work on without thinking
- [ ] Dashboard shows clear status
- [ ] Never search "where did I put..."

---

## 💡 ADHD-Specific Benefits

### External Memory
**Before:** Remember which project is where, what state it's in
**After:** `research dashboard` shows everything

### Reduced Decisions
**Before:** Which project should I work on?
**After:** Dashboard shows top 3, pick one

### Clear Boundaries
**Before:** 51 projects, all look equally important
**After:** 3 active, rest in planning/archive

### Visual Status
**Before:** Open files to see progress
**After:** Dashboard shows % complete, last modified

### Context Restoration
**Before:** Open multiple files to remember what you were doing
**After:** `research work project-name` opens exactly where you left off

---

## 🎯 Success Metrics

### Week 1
- [ ] Can find any active project in <10 seconds
- [ ] Morning: Check dashboard, know what to work on
- [ ] Never ask "where did I put that file?"

### Month 1
- [ ] All research in ~/research/
- [ ] Dropbox/Research/ is backup only
- [ ] Dashboard updated daily
- [ ] Active projects progressing

### Quarter 1
- [ ] Published 1+ papers
- [ ] Clear pipeline: planning → active → in-review → published
- [ ] Zero cognitive load from organization
- [ ] Research time spent on research, not searching

---

## 🚨 Critical Path: Do This NOW

### Next 30 Minutes

```bash
# 1. Create structure (2 min)
mkdir -p ~/research/{active,planning,in-review,published,archive}

# 2. List recent projects (5 min)
cd ~/Dropbox/Research
ls -lt | head -20 > ~/research/_recent.txt

# 3. Identify top 3 active (10 min)
# Write in ~/research/_active-projects.txt

# 4. Create dashboard (10 min)
# Edit ~/research/_dashboard.md

# 5. Commit to migration (3 min)
# Schedule: 30 min/day this week to migrate
```

### This Week

**Daily 30-min migration sessions:**
- Day 1: Migrate project 1
- Day 2: Migrate project 2
- Day 3: Migrate project 3
- Day 4: Archive old projects
- Day 5: Build research dashboard command

**Result:** Organized research, zero search time, clear priorities

---

**URGENCY:** This scattered research is costing you 3-6 hours/month in wasted search time

**SOLUTION:** Implement this structure THIS WEEK

**IMPACT:** Recover 3-6 hours/month = 36-72 hours/year for actual research

**ROI:** 2 hours migration = 36-72 hours saved annually = 18x-36x return

---

**Next:** Answer "What are my top 3 active research projects?" and start migration

**Full portfolio:** `FULL_PORTFOLIO_STRUCTURE.md`
**Quick reference:** `ACTION_QUICK_REF.md`
