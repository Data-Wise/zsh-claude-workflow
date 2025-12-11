# User Needs & Workflow Optimization Brainstorm

> **Date:** 2025-12-10
> **Purpose:** Understand actual needs before building features
> **Approach:** Problem-first, not solution-first

---

## 🎯 Current State Assessment

### Projects You Manage

**R Packages (6 active):**
- medfit, probmed, rmediation, medrobust, medsim, mediationverse

**Development Tools (10):**
- claude-r-dev, r-package-dev-gemini, zsh-claude-workflow, emacs-r-devkit, etc.

**Total Ecosystem:** 20 repositories across 5 layers

---

## 💭 Brainstorming Questions

### 1. Daily Workflow Pain Points

**Question:** What are your biggest frustrations in your current development workflow?

<ANSWER>
[Your answer here - what slows you down daily?]
- Example: "I waste time switching between projects"
- Example: "I forget which packages need CRAN updates"
- Example: "Documentation setup is tedious and inconsistent"
</ANSWER>

---

### 2. Ideal R Package Development Flow

**Question:** Walk me through your IDEAL workflow for developing an R package from start to finish. What would make it effortless?

<ANSWER>
[Your ideal workflow here]
- Step 1: ?
- Step 2: ?
- Step 3: ?
</ANSWER>

---

### 3. Documentation Challenges

**Question:** What frustrates you about documentation?

**Sub-questions:**
- Is setting up pkgdown/altdoc too manual?
- Do you want consistent themes across all packages?
- Is keeping docs updated a pain?
- Do you want one command to update all package docs?

<ANSWER>
[Your documentation pain points]
</ANSWER>

---

### 4. Multi-Project Management

**Question:** How do you currently track progress across your 20 repositories?

**Sub-questions:**
- Do you use GitHub Projects? Notion? Spreadsheets?
- What information do you need to see at a glance?
- How often do you need to check "what needs attention"?
- What would an ideal dashboard show you?

<ANSWER>
[Your current tracking method and ideal state]
</ANSWER>

---

### 5. CRAN Submission Workflow

**Question:** What's your CRAN submission workflow like? What could be automated?

**Sub-questions:**
- How do you track which packages are ready for CRAN?
- What pre-submission checks do you run?
- How do you coordinate breaking changes across packages?
- What's the most tedious part?

<ANSWER>
[Your CRAN workflow and automation wishes]
</ANSWER>

---

### 6. Claude vs Gemini Usage

**Question:** How do you decide when to use Claude Code vs Gemini CLI?

**Sub-questions:**
- Do you switch between them for different tasks?
- Would you like feature parity, or are differences okay?
- What does each do better?
- Should we focus on one and make it great?

<ANSWER>
[Your AI tool usage patterns]
</ANSWER>

---

### 7. Integration Preferences

**Question:** How do you prefer to work - GUI, CLI, or AI chat?

**Sub-questions:**
- Would you rather type `docs-setup` or ask Claude "set up docs"?
- Do you prefer scripted automation or interactive prompts?
- Should tools be invisible (just work) or visible (show what's happening)?

<ANSWER>
[Your interface preferences]
</ANSWER>

---

### 8. Time Investment

**Question:** How much time do you want to spend on tooling vs actual research/coding?

**Sub-questions:**
- Should setup be one-time effort then forget?
- Do you enjoy customizing tools?
- Would you rather have "good enough" automation than perfect manual control?

<ANSWER>
[Your time/effort preferences]
</ANSWER>

---

### 9. Collaboration & Sharing

**Question:** Do you collaborate with others on these packages? Share tools with colleagues?

**Sub-questions:**
- Should docs-standards be shareable for your research group?
- Do you want to onboard others to your workflow?
- Is this just for you, or a team?

<ANSWER>
[Your collaboration needs]
</ANSWER>

---

### 10. MediationVerse Ecosystem

**Question:** How do you coordinate the 6+ MediationVerse packages?

**Sub-questions:**
- Do you update them together or independently?
- How do you handle dependencies between them?
- Would you benefit from "update all" commands?
- Should there be cross-package testing?

<ANSWER>
[Your MediationVerse coordination challenges]
</ANSWER>

---

## 🎯 Priority Ranking

**Question:** Rank these by importance (1 = most important, 10 = least):

- [ ] ___ Fast R package creation with best practices
- [ ] ___ Consistent documentation across all packages
- [ ] ___ One-command CRAN submission prep
- [ ] ___ Dashboard showing all 20 projects at a glance
- [ ] ___ Automated sync between local work and GitHub
- [ ] ___ Easy switching between Claude and Gemini
- [ ] ___ Cross-package dependency management
- [ ] ___ Automated testing across the ecosystem
- [ ] ___ Documentation website deployment
- [ ] ___ Planning and roadmap tracking

---

## 💡 Use Case Scenarios

### Scenario 1: Starting a New R Package

**Current workflow:**
[Describe step-by-step what you do now]

**Ideal workflow:**
[Describe what you wish would happen]

**Time:** Current ___ minutes → Ideal ___ minutes

---

### Scenario 2: Updating Documentation

**Current workflow:**
[What do you do to update docs across packages?]

**Ideal workflow:**
[What would be effortless?]

**Time:** Current ___ minutes → Ideal ___ minutes

---

### Scenario 3: CRAN Submission

**Current workflow:**
[What's your process now?]

**Ideal workflow:**
[What would be automatic?]

**Time:** Current ___ hours → Ideal ___ minutes

---

### Scenario 4: Weekly Planning

**Current workflow:**
[How do you plan your week across 20 repos?]

**Ideal workflow:**
[What information do you need to decide what to work on?]

**Time:** Current ___ minutes → Ideal ___ minutes

---

### Scenario 5: Coordinating MediationVerse Release

**Current workflow:**
[How do you release multiple packages?]

**Ideal workflow:**
[What would coordinated releases look like?]

**Time:** Current ___ hours → Ideal ___ hours

---

## 🚫 What You DON'T Want

**Question:** What should we NOT build?

**Sub-questions:**
- Features you'll never use?
- Complexity you don't need?
- Automation that's more trouble than it's worth?
- Tools that duplicate what you already have?

<ANSWER>
[Things to avoid building]
</ANSWER>

---

## ✨ Dream Features

**Question:** If you could wave a magic wand, what would your development environment do automatically?

<ANSWER>
[Your wildest automation dreams - we'll decide what's feasible]
</ANSWER>

---

## 🎯 Success Definition

**Question:** 6 months from now, what would make you think "this integration was totally worth it"?

<ANSWER>
[What success looks like to you]
</ANSWER>

---

## 📊 Current Time Allocation

**Question:** Roughly, how much time do you spend on:

- [ ] ___ % Writing actual R code
- [ ] ___ % Writing tests
- [ ] ___ % Writing documentation
- [ ] ___ % Package setup/configuration
- [ ] ___ % Debugging CRAN issues
- [ ] ___ % Project management/planning
- [ ] ___ % Context switching between projects
- [ ] ___ % Tooling/workflow maintenance

**Ideal allocation:**
[How would you prefer to spend your time?]

---

## 🔍 Specific Integration Questions

### claude-r-dev Integration

**Question:** When you create a new R package, do you want:

- [ ] A. Automatic claude-r-dev profile installation?
- [ ] B. Prompt to choose profiles interactively?
- [ ] C. Profiles only when you explicitly ask?
- [ ] D. Something else? [Describe]

<ANSWER>
[Your preference]
</ANSWER>

---

### docs-standards Integration

**Question:** For documentation, do you want:

- [ ] A. Automatic theme application to all packages?
- [ ] B. One command to sync all package docs?
- [ ] C. Automatic altdoc/pkgdown setup on package creation?
- [ ] D. Just templates I can copy manually?

<ANSWER>
[Your preference]
</ANSWER>

---

### data-wise Integration

**Question:** For project tracking, do you want:

- [ ] A. Automatic sync every time you commit?
- [ ] B. Manual sync when you run `pj-sync`?
- [ ] C. Just a dashboard you can view?
- [ ] D. Integration with GitHub Projects?

<ANSWER>
[Your preference]
</ANSWER>

---

## 💭 Open Thoughts

**Use this space for any thoughts that don't fit above:**

<THOUGHTS>
[Anything else on your mind about your workflow]
</THOUGHTS>

---

## 📋 Next Steps After Brainstorm

Once you've answered these questions, we'll:

1. **Identify Core Needs** - What you actually need vs nice-to-have
2. **Optimize Integration** - Design around your workflow, not features
3. **Cut Unnecessary Features** - Remove what you won't use
4. **Prioritize by Impact** - Build high-impact, low-effort first
5. **Create Lean Plan** - Focused on solving your real problems

---

**Ready to fill this out! Take your time and be honest about what you actually want.**
