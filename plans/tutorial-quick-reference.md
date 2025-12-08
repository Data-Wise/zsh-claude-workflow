# Tutorial System Quick Reference

Visual guide to the proposed learning module structure.

---

## Current vs. Proposed Structure

### Current Documentation (Reference-Style)

```
📚 Documentation
├── Getting Started → "Read this to install"
├── Commands → "Here's what each command does"
├── User Guide → "Here's how things work"
├── Optimization → "Here's how to optimize"
└── Development → "Here's how to contribute"

❌ Missing: "Let me guide you step-by-step"
❌ Missing: "Try this yourself"
❌ Missing: "Check your understanding"
```

### Proposed Structure (Learning-Style)

```
📚 Documentation (existing)
    ... (all current docs remain)

🎓 NEW: Tutorials (hands-on learning)
├── 🟢 Beginner Path
│   ├── First Steps (install → first command)
│   ├── Project Detection (understand types)
│   ├── Claude Context (CLAUDE.md workflow)
│   └── ✅ Practice Exercises
│
├── 🟡 Intermediate Path
│   ├── Workflow Basics (v1.3: workflow-run)
│   ├── R Package Workflow (v1.3: rpkg-setup)
│   ├── Skill Management (v1.3: skill-activate)
│   ├── Multi-Project Workflows
│   └── ✅ Practice Exercises
│
├── 🔴 Advanced Path
│   ├── Custom Workflows (YAML)
│   ├── Custom Skills
│   ├── Template Customization
│   ├── Integration Patterns
│   └── ✅ Practice Exercises
│
├── 🎯 Scenarios (end-to-end)
│   ├── New R Package (complete workflow)
│   ├── Existing Project Setup
│   ├── Multi-Package Suite
│   └── Troubleshooting Guide
│
└── 💪 Challenges (self-assessment)
    ├── Beginner Challenges
    ├── Intermediate Challenges
    └── Advanced Challenges
```

---

## Learning Paths

### Path 1: Quick Start (30 minutes)
For users who want to get started fast:

```
1. Beginner/First Steps (10 min)
2. Beginner/Project Detection (10 min)
3. Scenarios/New R Package (10 min)
✓ Ready to use basic commands
```

### Path 2: R Package Developer (1-2 hours)
For R package developers:

```
1. All Beginner Tutorials (30 min)
2. Intermediate/R Package Workflow (20 min)
3. Intermediate/Skill Management (15 min)
4. Scenarios/New R Package (15 min)
5. Practice Exercises (30 min)
✓ Ready to use full R package workflow
```

### Path 3: Power User (3-4 hours)
For advanced users who want everything:

```
1. All Beginner Tutorials (30 min)
2. All Intermediate Tutorials (1 hour)
3. All Advanced Tutorials (1 hour)
4. All Scenarios (45 min)
5. All Challenges (45 min)
✓ Master of zsh-claude-workflow
```

---

## Tutorial Template Example

Each tutorial follows this pattern:

```markdown
# Tutorial: [Title]

## 🎯 Learning Objectives
- [ ] Objective 1
- [ ] Objective 2
- [ ] Objective 3

## ⏱️ Estimated Time: X minutes

## 📋 Prerequisites
- Requirement 1
- Requirement 2

---

## Step 1: [Action]

**What you'll do:** Clear description

**Command:**
```bash
command-here
```

**Expected Output:**
```
output-here
```

**✓ Checkpoint:**
- Did you see X in the output?
- Does Y match what you expected?

---

## Step 2: [Next Action]

[Repeat pattern]

---

## 💪 Practice Exercise

**Your Challenge:**
Try to do X on your own.

**Hints:**
- Hint 1 (if needed)
- Hint 2 (if needed)

<details>
<summary>Click to reveal solution</summary>

```bash
solution-command
```

Expected output: ...
</details>

---

## ❌ Common Mistakes

1. **Mistake:** Doing X wrong
   **Fix:** Do Y instead

2. **Mistake:** Forgetting Z
   **Fix:** Always remember to Z

---

## ✅ Self-Assessment

- [ ] I can do X without looking at docs
- [ ] I understand why Y works this way
- [ ] I completed the practice exercise
- [ ] I can explain Z to someone else

---

## 🚀 Next Steps

- [Next Tutorial Name](./next-tutorial.md)
- [Related Advanced Topic](../advanced/topic.md)
```

---

## Phase 1 Implementation Checklist

Critical updates needed TODAY:

### Update Command Reference

**File:** `docs/commands/reference.md`

- [ ] Add `workflow-run` section
  - Usage examples
  - Available workflows
  - Custom workflow creation

- [ ] Add `rpkg-setup` section
  - Usage examples
  - Package types (standard, statistical, methodological)
  - Integration with claude-r-dev

- [ ] Add `skill-activate` section
  - Usage examples
  - Available skills
  - Auto-activation vs manual

- [ ] Update aliases table
  - Add new command aliases (if any)

### Update Command Overview

**File:** `docs/commands/overview.md`

- [ ] Add v1.3 commands to tables
- [ ] Update command count (6 → 9 commands)
- [ ] Add v1.3 examples

### Update Quick Start

**File:** `docs/getting-started/quickstart.md`

- [ ] Add workflow-run example
- [ ] Add rpkg-setup example
- [ ] Add skill-activate example
- [ ] Update command reference table

### Update Navigation

**File:** `mkdocs.yml`

- [ ] Verify all new docs are linked
- [ ] Consider adding "v1.3 Features" section

---

## Estimated Effort

### Phase 1: Critical Docs (TODAY)
- **Time:** 1-2 hours
- **Priority:** URGENT
- **Deliverable:** v1.3 commands fully documented

### Phase 2: Tutorial Foundation (THIS WEEK)
- **Time:** 2-4 hours
- **Priority:** HIGH
- **Deliverable:** Beginner tutorials + practice exercises

### Phase 3: Interactive Learning (NEXT WEEK)
- **Time:** 3-5 hours
- **Priority:** MEDIUM
- **Deliverable:** Intermediate + scenario tutorials

### Phase 4: Advanced (WHEN TIME PERMITS)
- **Time:** 2-3 hours
- **Priority:** LOW-MEDIUM
- **Deliverable:** Advanced tutorials + challenges

### Phase 5: Polish (FUTURE)
- **Time:** 2-3 hours
- **Priority:** LOW
- **Deliverable:** Enhanced learning experience

**Total:** 12-20 hours spread across phases

---

## Next Actions

1. **Review assessment** - Read `learning-module-assessment.md`
2. **Decide on approach** - Which phases to implement?
3. **Phase 1 execution** - Update v1.3 command docs (urgent)
4. **Phase 2 planning** - Create tutorial structure
5. **Iterate** - Build, test, refine based on feedback
