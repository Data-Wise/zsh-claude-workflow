# QUICK REFERENCE - LAMINATE THIS

> One-page command reference for daily work
> No explanations - just do it

---

## 🎯 MediationVerse R Packages

### I just changed medfit - what breaks?
```bash
ecosystem check-breaks medfit
```

### See all packages status at once
```bash
ecosystem status-all
```

### Install package with local dependencies
```bash
ecosystem install-dev medsim
```

### Open all packages in one window
```bash
code ~/projects/r-packages/mediationverse-dev.code-workspace
```

### Before committing any package
```bash
ecosystem check-breaks <package-name>
```

---

## 📚 Teaching Courses

### Start new week
```bash
cd ~/teaching/courses/stats-415
ecosystem teaching next-week
```

### Generate exam
```bash
cd ~/teaching/courses/stats-415
examify generate exam03
```

### Preview course website
```bash
cd ~/teaching/courses/stats-415
quarto preview
```

### Week checklist
```bash
cat ~/teaching/courses/stats-415/week-XX/_checklist.md
```

---

## 💭 Context Switching

### Leaving - save where you are
```bash
ecosystem remember "Working on X, next do Y"
```

### Returning - recall where you were
```bash
ecosystem recall
```

### What was I doing on Friday?
```bash
ecosystem history
```

---

## 🔍 Finding Things

### Where is that file?
```bash
pj-search "filename"
```

### Show all my projects
```bash
pj-index
```

### Jump to project
```bash
pj <project-name>
```

---

## 🛠️ Development Tools

### Check documentation across projects
```bash
docs-check
```

### Run development workflow
```bash
workflow-run dev
```

### Activate skills for current project
```bash
skill-activate auto
```

### Check all git repos
```bash
pj-run git status
```

---

## 📊 Project Status

### Overall project status
```bash
plan-status
```

### Specific version progress
```bash
plan-status v1.5
```

### Visual timeline
```bash
plan-status --gantt
```

---

## ⚡ Common Workflows

### Full R package check
```bash
# From package directory
workflow-run pre-commit
```

### Install and test local package
```bash
ecosystem install-dev <package> && ecosystem check-breaks <package>
```

### Coordinated development
```bash
# 1. Open workspace
code ~/projects/r-packages/mediationverse-dev.code-workspace

# 2. Make changes to medfit

# 3. Check what breaks
ecosystem check-breaks medfit

# 4. Fix broken packages

# 5. Verify all clean
ecosystem status-all
```

### Teaching week workflow
```bash
# Monday
cd ~/teaching/courses/stats-415
ecosystem teaching next-week

# Wednesday
quarto render week-XX/lecture.qmd
ecosystem teaching upload lecture

# Friday
examify generate homework-XX
ecosystem teaching upload homework
```

---

## 🆘 When Stuck

### Don't know what to do
```bash
ecosystem help
```

### Forgot what I was doing
```bash
ecosystem recall
```

### Too many things going on
```bash
ecosystem status-all
# Pick one red/yellow item
```

### Need to find a command
```bash
ecosystem <TAB>        # See all commands
pj-<TAB>              # See project commands
workflow-run <TAB>     # See workflows
```

---

## 📍 Key Locations

| What | Where |
|------|-------|
| R packages workspace | `~/projects/r-packages/mediationverse-dev.code-workspace` |
| Teaching courses | `~/teaching/courses/` |
| Generated teaching materials | `~/teaching/generated/` |
| Shared datasets | `~/teaching/materials/` |
| Project plans | `~/projects/dev-tools/zsh-claude-workflow/plans/` |
| This reference | `~/projects/dev-tools/zsh-claude-workflow/plans/ACTION_QUICK_REF.md` |

---

## ✅ Daily Checklist

### Morning (5 min)
- [ ] `ecosystem status-all` - See what needs attention
- [ ] `ecosystem recall` - Remember where you left off
- [ ] Open workspace if working on R packages

### Before Lunch (1 min)
- [ ] `ecosystem remember "Currently doing X, next Y"` - Save state

### Afternoon Return (1 min)
- [ ] `ecosystem recall` - Continue where you left off

### End of Day (2 min)
- [ ] `ecosystem status-all` - See what's uncommitted
- [ ] `ecosystem remember "Summary of day, plan for tomorrow"`
- [ ] Commit or note what's in progress

---

## 🎯 One Command for Common Tasks

| Task | Command |
|------|---------|
| Check all packages | `ecosystem status-all` |
| Test downstream | `ecosystem check-breaks medfit` |
| Install with deps | `ecosystem install-dev medsim` |
| Save state | `ecosystem remember "message"` |
| Restore state | `ecosystem recall` |
| Open all packages | `code ~/projects/r-packages/mediationverse-dev.code-workspace` |
| New teaching week | `ecosystem teaching next-week` |
| Find file | `pj-search "filename"` |
| Jump to project | `pj <name>` |
| Get help | `ecosystem help` |

---

**Print this page • Laminate • Keep on desk**

**Full documentation:** `~/projects/dev-tools/zsh-claude-workflow/plans/ADHD_OPTIMIZED_RESTRUCTURE.md`
