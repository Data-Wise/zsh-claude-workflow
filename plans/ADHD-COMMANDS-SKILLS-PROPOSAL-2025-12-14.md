# ADHD-Friendly Ecosystem Restructure

**Date:** 2025-12-14
**Status:** Proposal (Revised v6 - ADHD Workflow Commands)

---

## The Problem

You have **two domains** but **three projects**:

```
DOMAIN              CURRENT STATE                 PROBLEM
──────────────────────────────────────────────────────────────
ZSH (Shell)         zsh-configuration ✅          Good!
                    zsh-claude-workflow ⚠️        Duplicate!

Claude Code         ~/.claude/ ✅                 Good!
                    zsh-claude-workflow ⚠️        Mixed in!
```

**Solution:** Consolidate into **two projects** matching **two domains**.

---

## Target State: Two Domains, Two Homes

```
┌─────────────────────────────────────────────────────────────┐
│                    ZSH DOMAIN                               │
│              zsh-configuration                              │
├─────────────────────────────────────────────────────────────┤
│  Location: ~/projects/dev-tools/zsh-configuration/          │
│  Config:   ~/.config/zsh/                                   │
│                                                             │
│  OWNS:                                                      │
│  • 144+ shell aliases                                       │
│  • 22-26 workflow functions                                 │
│  • ADHD helpers (js, why, win, gm, bc)                     │
│  • Audit commands (git-audit, file-audit, morning-audit)   │
│  • Focus/session management                                 │
│  • Multi-editor work() function                            │
│  • Project detection for shell (here, proj-type)           │
│  • CLI shortcuts for Claude/Gemini (cc, ccs, gm)           │
│                                                             │
│  STATUS: ✅ Complete (P0-P3 done, 25 tests passing)         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                   CLAUDE DOMAIN                             │
│                    ~/.claude/                               │
├─────────────────────────────────────────────────────────────┤
│  Location: ~/.claude/                                       │
│                                                             │
│  OWNS:                                                      │
│  • /commands/ - 53 slash commands (8 categories)           │
│  • /skills/ - 37 skills                                    │
│  • settings.json - MCP servers, permissions                │
│  • statusline-p10k.sh - Status line                        │
│                                                             │
│  NATIVE CAPABILITIES (no shell needed):                    │
│  • Project type detection                                  │
│  • CLAUDE.md context gathering                             │
│  • Skill activation/management                             │
│                                                             │
│  STATUS: ✅ Working (needs cleanup + discovery)             │
└─────────────────────────────────────────────────────────────┘
```

---

## Community Research Findings

### Official Anthropic Skills (16 available)

| Category | Skills | Priority |
|----------|--------|----------|
| **Documents** | pdf, docx, xlsx, pptx | ⭐ HIGH - Add these |
| **Creative** | algorithmic-art, canvas-design, slack-gif-creator, theme-factory | LOW |
| **Development** | mcp-builder, webapp-testing, web-artifacts-builder, frontend-design | MEDIUM |
| **Enterprise** | brand-guidelines, internal-comms, doc-coauthoring | LOW |
| **Meta** | skill-creator | MEDIUM |

### Community Resources

| Resource | Description | Action |
|----------|-------------|--------|
| [anthropics/skills](https://github.com/anthropics/skills) | Official 16 skills | Clone for documents |
| [claude-code-plugins-plus](https://github.com/jeremylongshore/claude-code-plugins-plus) | 243 plugins hub | Browse for ideas |
| [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) | Curated list | Reference |
| [skillsmp.com](https://skillsmp.com/) | 10,000+ skills marketplace | Search when needed |
| [obra/superpowers](https://github.com/obra/superpowers) | 20+ battle-tested skills | Consider TDD, debugging |
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Commands, workflows | Reference |

---

## Current Inventory Analysis

### Commands: 53 total (8 categories) - PROPOSED

| Category | Count | Commands (Best Practice Names) |
|----------|-------|--------------------------------|
| 💻 `code/` | 12 | project-check, test-run, test-generate, test-coverage, lint-check, lint-fix, release-prep, deps-check, deps-audit, debug-trace, refactor-clean, demo-create |
| 📖 `site/` | 5 | site-init, site-build, site-preview, site-deploy, site-check |
| 🐙 `github/` | 4 | gh-pages, gh-actions, gh-release, ci-status |
| 🧠 `workflow/` | 6 | recap, next, focus, done, brain-dump, stuck |
| 🧮 `math/` | 4 | derive, example, notation, proof |
| 🔬 `research/` | 8 | analysis-plan, cite, hypothesis, lit-gap, manuscript, method-scout, revision, sim-design |
| 📚 `teach/` | 9 | canvas, exam, feedback, homework, lecture, quiz, rubric, solution, syllabus |
| ✍️ `write/` | 5 | abstract, cover-letter, draft, edit, response |

### Skills: 37 total (mixed sources)

| Source | Count | Examples |
|--------|-------|----------|
| **MCP symlinks** | 17 | proof-architect, simulation-architect, methods-paper-writer |
| **Local files** | 16 | r-package-development, teaching-workflow, emacs-r-devkit |
| **Google Drive** | 3 | manuscript-writing-guide, statistical-simulation-guide, r-simulation-config |
| **Backup (DELETE)** | 1 | research-writing-workflow.md.backup |

---

## Skills Categorization Brainstorm

### Proposed Skill Categories

```
~/.claude/skills/
├── SKILLS-INDEX.md                    # Master index
│
├── documents/                         # Document operations
│   ├── pdf.md → anthropic-official    # Read/create PDFs
│   ├── docx.md → anthropic-official   # Word documents
│   ├── xlsx.md → anthropic-official   # Excel spreadsheets
│   └── pptx.md → anthropic-official   # PowerPoints
│
├── statistical/                       # Statistical research
│   ├── mathematical/                  # Theory & proofs
│   │   ├── proof-architect → MCP
│   │   ├── asymptotic-theory → MCP
│   │   ├── identification-theory → MCP
│   │   └── mathematical-foundations → MCP
│   ├── implementation/                # Algorithms & code
│   │   ├── algorithm-designer → MCP
│   │   ├── simulation-architect → MCP
│   │   ├── numerical-methods → MCP
│   │   ├── computational-inference → MCP
│   │   └── statistical-software-qa → MCP
│   ├── research/                      # Research workflows
│   │   ├── literature-gap-finder → MCP
│   │   ├── method-transfer-engine → MCP
│   │   ├── sensitivity-analyst → MCP
│   │   ├── mediation-meta-analyst → MCP
│   │   └── cross-disciplinary-ideation → MCP
│   └── writing/                       # Academic writing
│       ├── methods-paper-writer → MCP
│       ├── methods-communicator → MCP
│       └── publication-strategist → MCP
│
├── teaching/                          # Education
│   ├── statistics-exam-generator.md
│   ├── quarto-examark-generator.md
│   ├── teaching-workflow.md
│   └── examark-*.md (consolidated)
│
├── development/                       # Dev environment
│   ├── r-package-development.md
│   ├── emacs-r-devkit.md
│   ├── zsh-environment.md
│   └── mac-webapp-cleanup/
│
├── meta/                              # About Claude/workflows
│   ├── statistical-research-workflow.md
│   ├── research-writing-meta.md
│   └── data-wise-documentation.md
│
└── archive/                           # Deprecated/backup
    └── (moved items)
```

### Category Icons for /hub

| Category | Icon | Description |
|----------|------|-------------|
| Documents | 📄 | PDF, Word, Excel, PowerPoint |
| Statistical | 📊 | Research, math, implementation |
| Teaching | 📚 | Exams, courses, feedback |
| Development | 🔧 | R, Emacs, shell, tools |
| Meta | ⚙️ | Workflows, documentation |

---

## Implementation Plan

### Phase 1: Cleanup (30 min) ✅ REQUIRED

```bash
# Delete backup file
rm ~/.claude/skills/research-writing-workflow.md.backup

# Create archive directory
mkdir -p ~/.claude/skills/archive

# Create skills index
touch ~/.claude/skills/SKILLS-INDEX.md
```

### Phase 2: Add Anthropic Document Skills (15 min) ✅ REQUIRED

```bash
cd ~/.claude/skills

# Clone official skills repo
git clone https://github.com/anthropics/skills anthropic-official

# Create document skills symlinks
mkdir -p documents
ln -s ../anthropic-official/skills/pdf/SKILL.md documents/pdf.md
ln -s ../anthropic-official/skills/xlsx/SKILL.md documents/xlsx.md
ln -s ../anthropic-official/skills/docx/SKILL.md documents/docx.md
ln -s ../anthropic-official/skills/pptx/SKILL.md documents/pptx.md
```

### Phase 3: Migrate Google Drive Skills (15 min) ✅ REQUIRED

```bash
# Copy from Google Drive to local (removes sync dependency)
cp ~/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/My\ Drive/research/product\ of\ three/.claude/skills/* ~/.claude/skills/archive/gdrive-backup/

# Update symlinks to point to MCP versions (already have these)
# manuscript-writing-guide → MCP methods-paper-writer
# statistical-simulation-guide → MCP simulation-architect
# r-simulation-config → keep as local copy
```

### Phase 4: Create /hub Discovery Command (1-2 hours) ⭐ RECOMMENDED

```markdown
# ~/.claude/commands/hub.md

# /hub - Command & Skill Discovery

You are a command discovery assistant. Show available commands
organized by category with context-aware suggestions.

## When invoked:

1. **Detect context** from current directory:
   - R package? Suggest: /rpkg-check, /test-gen, /release
   - Research project? Suggest: /manuscript, /sim-design, /cite
   - Teaching materials? Suggest: /exam, /quiz, /rubric
   - Documentation? Suggest: /mkdocs, /draft, /edit

2. **Display format:**

┌─────────────────────────────────────────────────────────┐
│ 📦 medfit (R package) on main                           │
├─────────────────────────────────────────────────────────┤
│ 💡 SUGGESTED FOR THIS PROJECT:                          │
│    /rpkg-check  /test-gen  /release  /refactor          │
├─────────────────────────────────────────────────────────┤
│ 📂 ALL CATEGORIES:                                      │
│                                                         │
│  💻 code (8)        │  🔬 research (8)                  │
│  debug, refactor,   │  manuscript, cite,                │
│  test-gen, release  │  sim-design, lit-gap              │
│                     │                                   │
│  🧮 math (4)        │  📚 teach (9)                     │
│  proof, derive,     │  exam, quiz, rubric,              │
│  notation, example  │  homework, feedback               │
│                     │                                   │
│  ✍️ write (5)       │  📖 docs (3)                      │
│  draft, edit,       │  mkdocs, mkdocs-init,             │
│  abstract, response │  mkdocs-preview                   │
├─────────────────────────────────────────────────────────┤
│ 🎯 SKILLS ACTIVE: r-package-development,                │
│                   methods-paper-writer                  │
│                                                         │
│ Type /hub <category> for details                        │
│ Type /hub skills for skill categories                   │
└─────────────────────────────────────────────────────────┘

3. **Sub-commands:**
   - `/hub code` - Show all code commands with descriptions
   - `/hub skills` - Show skill categories
   - `/hub skills statistical` - Show statistical skills
```

### Phase 5: Retire zsh-claude-workflow (OPTIONAL)

```bash
# Update CLAUDE.md to mark as deprecated
# Keep only:
#   - lib/project-detector.sh (shared with iterm2-context-switcher)
#   - lib/core.sh (shared utilities)
#   - claude-commands/ (symlinked to ~/.claude/commands/)
# Archive everything else to archive/
```

### Phase 6: Migrate to zsh-configuration (OPTIONAL)

```bash
# If plan-status and research functions are still useful,
# add them to: ~/.config/zsh/functions/workflow-extras.zsh
# Otherwise, just archive them
```

---

## Command Naming Best Practices

### Research Sources

- [clig.dev](https://clig.dev/) - Command Line Interface Guidelines
- [wshobson/commands](https://github.com/wshobson/commands) - 57 production-ready commands
- [Claude Code Docs](https://code.claude.com/docs/en/slash-commands) - 38 built-in commands

### Naming Conventions

| Rule | Example | Avoid |
|------|---------|-------|
| **Kebab-case** | `deps-audit` | `depsAudit`, `deps_audit` |
| **Verb-noun pattern** | `test-generate` | `generate-test` (noun-verb) |
| **2-3 words max** | `gh-pages` | `github-pages-deploy-now` |
| **Standard verbs** | check, audit, generate, create | inspect, make, build |
| **Descriptive** | `deps-audit` | `da` (too cryptic) |

### ⚠️ Built-in Command Conflicts

**DO NOT USE** - These are Claude Code built-in commands:

| Built-in | Purpose | Our Alternative |
|----------|---------|-----------------|
| `/init` | Creates CLAUDE.md | `/docs-init` or `/site-init` |
| `/review` | Code review | `/code-review` (if needed) |
| `/todos` | List TODOs | (don't duplicate) |
| `/doctor` | Health check | `/project-check` |
| `/security-review` | Security audit | (don't duplicate) |
| `/compact` | Compress context | (don't duplicate) |

### Recommended Naming Patterns

| Pattern | Use For | Examples |
|---------|---------|----------|
| `*-check` | Validation, audits | `deps-check`, `project-check` |
| `*-generate` | Creating new things | `test-generate`, `docs-generate` |
| `*-audit` | Deep analysis | `deps-audit`, `security-audit` |
| `site-*` | Documentation sites | `site-init`, `site-build`, `site-deploy` |
| `gh-*` | GitHub operations | `gh-pages`, `gh-actions`, `gh-release` |

---

## Context-Aware Commands (NEW)

### Design Principle

Commands should **detect project type** and adapt behavior automatically:

```
┌─────────────────────────────────────────────────────────────┐
│                    CONTEXT DETECTION                        │
├─────────────────────────────────────────────────────────────┤
│  DESCRIPTION file?     → R Package                          │
│  pyproject.toml?       → Python Package                     │
│  package.json?         → Node.js Project                    │
│  _quarto.yml?          → Quarto Project                     │
│  mkdocs.yml?           → MkDocs Project                     │
│  Otherwise             → Generic Project                    │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 Code Commands (Context-Aware)

### `/project-check` - Project Health Check (RENAMED from rpkg-check)

**Purpose:** Run project-appropriate checks and tests.

| If Project Is... | Actions |
|------------------|---------|
| **R Package** | `devtools::check()`, `lintr::lint_package()`, `covr::package_coverage()` |
| **Python** | `pytest`, `ruff check`, `mypy` |
| **Node.js** | `npm test`, `npm run lint`, `npm audit` |
| **Generic** | Check for common issues, suggest setup |

**Usage:** `/project-check` or `/project-check --fix` (auto-fix linting)

**Why this name:** Avoids conflict with built-in `/doctor`, follows `*-check` pattern.

---

### `/test-run` - Run Tests / `/test-generate` - Generate Tests

**Purpose:** Run existing tests or generate new ones.

| If Project Is... | Test Framework | Generate With |
|------------------|----------------|---------------|
| **R Package** | `testthat` | Create `tests/testthat/test-*.R` |
| **Python** | `pytest` | Create `tests/test_*.py` |
| **Node.js** | `jest` or `vitest` | Create `*.test.js` |

**Usage:**
- `/test-run` - Run all tests
- `/test-generate <function>` - Generate tests for function
- `/test-coverage` - Show coverage report

**Why split:** Verb-noun pattern (`test-run`, `test-generate`) is clearer than overloaded `/test`.

---

### `/lint-check` - Code Quality Check / `/lint-fix` - Auto-fix

**Purpose:** Check and fix code style issues.

| If Project Is... | Linter | Formatter |
|------------------|--------|-----------|
| **R Package** | `lintr` | `styler` |
| **Python** | `ruff` | `black` |
| **Node.js** | `eslint` | `prettier` |

**Usage:**
- `/lint-check` - Check only (report issues)
- `/lint-fix` - Auto-fix issues

**Why split:** Explicit action in name prevents accidental changes.

---

### `/release-prep` - Release Workflow

**Purpose:** Guide through release process.

| If Project Is... | Release Steps |
|------------------|---------------|
| **R Package** | `devtools::release()`, CRAN checks, NEWS.md, version bump |
| **Python** | Build, twine upload, PyPI |
| **Node.js** | `npm version`, `npm publish` |
| **Generic** | Git tag, GitHub release, changelog |

**Includes:** Version bump, changelog generation, pre-release checks

**Why this name:** `release-prep` is more descriptive than just `release`.

---

### `/deps-check` - Dependency Status / `/deps-audit` - Security Audit

**Purpose:** Analyze and update dependencies.

| If Project Is... | Commands |
|------------------|----------|
| **R Package** | `renv::status()`, update DESCRIPTION, `pak::pkg_deps_tree()` |
| **Python** | `pip list --outdated`, update requirements.txt/pyproject.toml |
| **Node.js** | `npm outdated`, `npm update`, `npm audit fix` |

**Usage:**
- `/deps-check` - Show dependency status
- `/deps-update` - Update all dependencies
- `/deps-audit` - Security vulnerability audit

**Why split:** Different actions, different risk levels.

---

### `/debug-trace` - Systematic Debugging

**Purpose:** Systematic debugging with trace analysis.

Works for any language. Follows systematic debugging workflow:
1. Reproduce the issue
2. Isolate the problem
3. Trace execution
4. Identify root cause
5. Propose fix

**Why this name:** `debug-trace` follows community pattern, more specific than `/debug`.

---

### `/refactor-clean` - Code Improvement

**Purpose:** Improve code structure without changing behavior.

Works for any language. Suggests refactoring opportunities.

**Why this name:** `refactor-clean` is more descriptive, follows community pattern.

---

### `/demo-create` - Create Examples

**Purpose:** Create working demonstrations and examples.

Adapts to project language.

**Why this name:** Verb-noun pattern (`demo-create`).

---

## 📖 Site Commands (Documentation Sites)

### `/site-init` - Initialize Documentation Site

**Purpose:** Initialize a documentation site for your project.

| If Project Is... | Tool | Site Type |
|------------------|------|-----------|
| **R Package** | **Quarto + altdoc** or **pkgdown** | Package docs |
| **Python** | **MkDocs** or **Sphinx** | API docs |
| **Node.js** | **MkDocs** or **TypeDoc** | API docs |
| **Generic** | **MkDocs** | General docs |

**Why `site-*` not `docs-*`:** Avoids conflict with built-in `/init` and is clearer about purpose.

---

### `/site-build` - Build Documentation Site

**Purpose:** Build static documentation site.

| If Project Is... | Build Command |
|------------------|---------------|
| **R Package** | `quarto render` or `pkgdown::build_site()` |
| **Non-R** | `mkdocs build` |

---

### `/site-preview` - Preview Locally

**Purpose:** Start local preview server.

| If Project Is... | Preview Command |
|------------------|-----------------|
| **R Package** | `quarto preview` or `pkgdown::preview_site()` |
| **Non-R** | `mkdocs serve` |

---

### `/site-deploy` - Deploy to GitHub Pages

**Purpose:** Deploy documentation to GitHub Pages.

| If Project Is... | Deploy Method |
|------------------|---------------|
| **R Package** | Push `docs/` to gh-pages branch |
| **Non-R** | `mkdocs gh-deploy` |

---

### `/site-check` - Validate Documentation

**Purpose:** Check for broken links, spelling, etc.

Works for all project types.

---

### R Package Documentation Details

```
/site-init (R Package)
├── Option 1: Quarto + altdoc (RECOMMENDED)
│   ├── Creates _quarto.yml
│   ├── Sets up altdoc for function reference
│   ├── Integrates with pkgdown-style layouts
│   └── Output: docs/ or _site/
│
└── Option 2: pkgdown (Traditional)
    ├── Creates _pkgdown.yml
    ├── Builds reference from roxygen2
    └── Output: docs/
```

**R Package site workflow:**
1. Build roxygen2 documentation
2. Generate function reference (altdoc or pkgdown)
3. Render vignettes (Quarto or R Markdown)
4. Build site
5. Preview locally

---

### Non-R Project Documentation Details

```
/site-init (Non-R)
├── Creates mkdocs.yml
├── Sets up docs/ directory structure
├── Configures Material theme
└── Adds GitHub Pages workflow
```

**Non-R site workflow:**
1. Initialize MkDocs structure
2. Write markdown in `docs/`
3. Preview with `mkdocs serve`
4. Deploy with `mkdocs gh-deploy`

---

## 🐙 GitHub Commands (NEW)

### `/gh-pages` - GitHub Pages Deployment

**Purpose:** Setup and deploy GitHub Pages.

| If Project Is... | Deploy Method |
|------------------|---------------|
| **R Package** | Deploy `docs/` from pkgdown/altdoc |
| **Non-R** | Deploy from MkDocs `site/` |
| **Any** | Can also deploy from `gh-pages` branch |

**Usage:**
- `/gh-pages init` - Setup GitHub Pages
- `/gh-pages deploy` - Deploy current docs
- `/gh-pages status` - Check deployment status

---

### `/gh-actions` - CI/CD Workflows (NEW)

**Purpose:** Create or debug GitHub Actions.

| If Project Is... | Suggested Workflows |
|------------------|---------------------|
| **R Package** | R CMD check, pkgdown, test coverage |
| **Python** | pytest, ruff, publish to PyPI |
| **Node.js** | test, lint, publish to npm |

**Usage:**
- `/gh-actions init` - Create standard workflows
- `/gh-actions debug` - Debug failing workflow
- `/gh-actions add <workflow>` - Add specific workflow

---

### `/gh-release` - Create GitHub Release (NEW)

**Purpose:** Create a GitHub release with notes.

**Actions:**
1. Generate release notes from commits
2. Create git tag
3. Create GitHub release
4. Attach artifacts (if any)

**Usage:** `/gh-release v1.2.0`

---

### `/ci-status` - Check CI Status (NEW)

**Purpose:** Check and debug CI/CD status.

**Actions:**
1. Show recent workflow runs
2. Identify failing jobs
3. Fetch error logs
4. Suggest fixes

**Usage:** `/ci-status` or `/ci-status --fix`

---

## Command Summary Table (Revised Names)

### 💻 Code Commands (11 total)

| Command | R Package | Python | Node.js | Generic |
|---------|-----------|--------|---------|---------|
| `/project-check` | devtools::check | pytest + ruff | npm test + lint | Basic checks |
| `/test-run` | testthat | pytest | jest/vitest | — |
| `/test-generate` | testthat templates | pytest templates | jest templates | — |
| `/test-coverage` | covr | coverage.py | c8/istanbul | — |
| `/lint-check` | lintr | ruff | eslint | — |
| `/lint-fix` | styler | black | prettier | — |
| `/release-prep` | CRAN workflow | PyPI | npm publish | Git tag |
| `/deps-check` | renv status | pip outdated | npm outdated | — |
| `/deps-audit` | — | pip-audit | npm audit | — |
| `/debug-trace` | ✅ | ✅ | ✅ | ✅ |
| `/refactor-clean` | ✅ | ✅ | ✅ | ✅ |
| `/demo-create` | ✅ | ✅ | ✅ | ✅ |

### 📖 Site Commands (5 total)

| Command | R Package | Non-R |
|---------|-----------|-------|
| `/site-init` | Quarto+altdoc or pkgdown | MkDocs |
| `/site-build` | quarto render / pkgdown | mkdocs build |
| `/site-preview` | Local server | mkdocs serve |
| `/site-deploy` | gh-pages | mkdocs gh-deploy |
| `/site-check` | Link/spell check | Link/spell check |

### 🐙 GitHub Commands (4 total)

| Command | Description |
|---------|-------------|
| `/gh-pages` | Setup/deploy GitHub Pages |
| `/gh-actions` | Create/debug workflows |
| `/gh-release` | Create release with notes |
| `/ci-status` | Check CI status |

---

## 🧠 ADHD Workflow Commands (NEW)

### Research Background

From [ADHD Developer Productivity Guide](https://super-productivity.com/blog/adhd-developer-productivity-guide/):

> "Context switching is the single largest drain on engineering velocity. After an interruption, it takes **20+ minutes** to return to the original task."

From [CodeState](https://www.codestate.dev/):

> "Save your entire workspace: git state, terminal sessions... captures mental context with notes."

### Built-in Command Conflicts

| Command | Status | Built-in Purpose |
|---------|--------|------------------|
| `/resume` | ⛔ TAKEN | Resume conversation |
| `/status` | ⛔ TAKEN | Open Settings Status tab |
| `/context` | ⛔ TAKEN | Visualize context usage |
| `/next` | ✅ Available | — |
| `/recap` | ✅ Available | — |

### The ADHD Developer Loop

```
┌─────────────────────────────────────────────────────────────┐
│                    ADHD WORKFLOW LOOP                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   /recap ──────► /next ──────► /focus ──────► /done        │
│      ↑                                           │          │
│      └───────────────────────────────────────────┘          │
│                                                             │
│   "Where was I?"  "What's next?"  "Do ONE thing"  "Save"   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

### `/recap` - "Where Was I?" (Context Restoration)

**Purpose:** Restore mental context when resuming work.

**Enhances:** Shell `here()` function with AI-powered analysis.

**Actions:**
1. Read `.STATUS` file (existing template format)
2. Check recent git commits (last 24-48h)
3. Read `TODO.md`, `PLAN.md`, `PROJECT-HUB.md` if present
4. Check open issues/PRs via `gh` CLI
5. AI-summarize: what's done, what's in progress, what's blocked

**Output:**
```
┌─────────────────────────────────────────────────────────────┐
│ 📍 RECAP: medfit (R package)                                │
├─────────────────────────────────────────────────────────────┤
│ 📅 LAST SESSION: 2 days ago                                 │
│                                                             │
│ ✅ COMPLETED:                                               │
│    • Added bootstrap CI for indirect effects                │
│    • Fixed edge case in sensitivity analysis                │
│                                                             │
│ 🔄 IN PROGRESS:                                             │
│    • Vignette for multi-mediator models (60% done)         │
│                                                             │
│ 📋 NEXT UP:                                                 │
│    • Add unit tests for new functions                       │
│    • Update pkgdown site                                    │
│                                                             │
│ ⚠️ BLOCKERS:                                                │
│    • Waiting on reviewer feedback (PR #42)                  │
└─────────────────────────────────────────────────────────────┘
```

---

### `/next` - "What Should I Do?" (Decision Support)

**Purpose:** Reduce decision paralysis by suggesting ONE task.

**Enhances:** Shell `next()` function with AI prioritization.

**Actions:**
1. Read "🎯 Next Action" section from `.STATUS`
2. Analyze git activity for momentum
3. AI-prioritize by: blocked items, deadlines, quick wins
4. Suggest ONE concrete next step with reasoning
5. Show 2-3 alternatives with time estimates

**Output:**
```
┌─────────────────────────────────────────────────────────────┐
│ 🎯 SUGGESTED NEXT STEP                                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Continue: Vignette for multi-mediator models              │
│                                                             │
│   File: vignettes/multi-mediator.Rmd                        │
│   Progress: Section 3 of 5 (examples)                       │
│   Est. time: 30-45 min to complete                          │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│ 💡 ALTERNATIVES:                                            │
│    • Quick win: Add 2 unit tests (15 min)                   │
│    • Important: Review PR #42 feedback                      │
│    • Maintenance: Update dependencies                       │
└─────────────────────────────────────────────────────────────┘
```

---

### `/focus` - "Lock In" (Single-Task Mode)

**Purpose:** Commit to ONE task, block distractions mentally.

**Usage:** `/focus <task>` or `/focus` (uses `/next` suggestion)

**Actions:**
1. Confirm the one task to focus on
2. Set a timer suggestion (25/45/90 min)
3. Create mental "contract" - only this task
4. Optionally update `.STATUS` with focus task

**Output:**
```
┌─────────────────────────────────────────────────────────────┐
│ 🎯 FOCUS MODE                                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   TASK: Complete multi-mediator vignette                    │
│   TIME: 45 minutes suggested                                │
│                                                             │
│   📝 When done, run /done to save progress                  │
│   🚫 If distracted, return here                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

### `/done` - "Wrap Up" (Session End)

**Purpose:** Capture progress before context is lost.

**Enhances:** Shell `endwork()` function with guided prompts.

**Actions:**
1. Prompt: What did you accomplish? (→ "✅ Just Completed")
2. Prompt: What's the next step? (→ "🎯 Next Action")
3. Update `.STATUS` file (existing template format)
4. Update "📊 Progress" bars if applicable
5. Optionally commit with summary
6. Clear mental load - permission to stop

**Output:**
```
┌─────────────────────────────────────────────────────────────┐
│ ✅ SESSION SAVED                                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ACCOMPLISHED:                                             │
│   • Finished examples section of vignette                   │
│   • Added 3 unit tests                                      │
│                                                             │
│   NEXT TIME:                                                │
│   • Write conclusion section                                │
│   • Run R CMD check                                         │
│                                                             │
│   📁 Updated: .STATUS                                       │
│   💾 Ready to commit? (y/n)                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

### `/brain-dump` - "Quick Capture" (Interrupt Handler)

**Purpose:** Capture thoughts/ideas without losing focus.

**Usage:** `/brain-dump <thought>` or `/brain-dump` (interactive)

**Actions:**
1. Append to `NOTES.md` or `IDEAS.md` with timestamp
2. Don't require organization - just capture
3. Return to current task immediately

**Output:**
```
💭 Captured: "Maybe add support for moderated mediation"
📁 Added to: NOTES.md
🎯 Back to: multi-mediator vignette
```

---

### `/stuck` - "I'm Blocked" (Unblock Helper)

**Purpose:** Help when you don't know what to do.

**Actions:**
1. Ask clarifying questions
2. Suggest breaking down the problem
3. Offer to research/search
4. Suggest taking a break if appropriate

---

### `.STATUS` File Format (Coordinated with zsh-configuration)

**IMPORTANT:** The `.STATUS` system already exists in `zsh-configuration`. Claude Code commands should **enhance**, not duplicate.

**Existing Template:** `~/projects/.templates/.STATUS-template-enhanced`

```markdown
# PROJECT_NAME Status

**Last Updated:** YYYY-MM-DD HH:MM | **Session:** __ min | **Status:** 🟢

---

## ✅ Just Completed
-

---

## 🎯 Next Action

**Choose one:**
- **A)** [Primary task] [__ min] 🟢
- **B)** [Alternative task] [__ min] 🟡
- **C)** [Quick win] [__ min] ⚡

**Selected:** ___

---

## 📊 Progress

```
Item 1: [X/Y] ████████░░ XX%
Item 2: [X/Y] ██████░░░░ XX%
```

---

## 🚀 Quick Commands

```bash
$ command1     # Description
```

---

## 🔴 Blockers

None

---

## 🔗 Links

- [Resource 1](url)

---

## 🎉 Wins This Session

- [ ] Completed task 1

---

## 📝 Notes

```

---

### Coordination: Shell Functions ↔ Claude Commands

| Shell Function | Claude Command | Relationship |
|----------------|----------------|--------------|
| `here()` | `/recap` | Claude **enhances** with git history, PR status |
| `next()` | `/next` | Claude **enhances** with prioritization, alternatives |
| `endwork()` | `/done` | Claude **enhances** with prompts, auto-update |
| `new.stat` | — | Use existing alias to create .STATUS |
| `stat` | — | Use existing alias to view .STATUS |
| `e.stat` | — | Use existing alias to edit .STATUS |

**Existing Shell Commands (from zsh-configuration):**

```bash
# View
stat            # View .STATUS (bat or cat)
here            # Full context (location + .STATUS + git)
next            # Show just "Next Action" section
progress_check  # Show just progress bars

# Edit
e.stat          # Edit .STATUS in $EDITOR
endwork         # Prompt to update at session end

# Create
new.stat        # Create from template

# Scan All
pstat           # Scan all .STATUS → JSON
pstatview       # View all project statuses
```

**Claude Commands ADD:**
- AI-powered summarization of git history
- Intelligent task prioritization
- PR/issue status checking
- Guided session wrap-up prompts
- Quick capture without leaving flow

---

### 🧠 ADHD Workflow Summary (6 total)

| Command | Purpose | ADHD Benefit |
|---------|---------|--------------|
| `/recap` | Restore context | Eliminates "where was I?" anxiety |
| `/next` | Suggest one task | Reduces decision paralysis |
| `/focus` | Commit to one thing | Blocks mental wandering |
| `/done` | Save progress | Permission to stop, captures context |
| `/brain-dump` | Quick capture | Don't lose ideas, stay focused |
| `/stuck` | Get unstuck | Gentle guidance when blocked |

---

## /hub Category Details (Updated with Best Practice Names)

### 💻 Code Commands (12)

| Command | Description | Context-Aware |
|---------|-------------|---------------|
| `/project-check` | Run project checks | ✅ R/Python/Node |
| `/test-run` | Run tests | ✅ R/Python/Node |
| `/test-generate` | Generate test files | ✅ R/Python/Node |
| `/test-coverage` | Show coverage report | ✅ R/Python/Node |
| `/lint-check` | Check code style | ✅ R/Python/Node |
| `/lint-fix` | Auto-fix style | ✅ R/Python/Node |
| `/release-prep` | Release workflow | ✅ R/Python/Node |
| `/deps-check` | Dependency status | ✅ R/Python/Node |
| `/deps-audit` | Security audit | ✅ R/Python/Node |
| `/debug-trace` | Systematic debugging | Generic |
| `/refactor-clean` | Code improvement | Generic |
| `/demo-create` | Create examples | Generic |

### 📖 Site Commands (5)

| Command | Description | Context-Aware |
|---------|-------------|---------------|
| `/site-init` | Initialize docs site | ✅ Quarto/MkDocs |
| `/site-build` | Build static site | ✅ Quarto/MkDocs |
| `/site-preview` | Local preview | ✅ Quarto/MkDocs |
| `/site-deploy` | Deploy to GH Pages | ✅ Quarto/MkDocs |
| `/site-check` | Validate docs | Generic |

### 🐙 GitHub Commands (4)

| Command | Description | Context-Aware |
|---------|-------------|---------------|
| `/gh-pages` | GitHub Pages setup | ✅ R/Non-R |
| `/gh-actions` | CI/CD workflows | ✅ R/Python/Node |
| `/gh-release` | Create release | Generic |
| `/ci-status` | Check CI status | Generic |

### 🧠 ADHD Workflow Commands (6)

| Command | Purpose | ADHD Benefit |
|---------|---------|--------------|
| `/recap` | Restore context | Eliminates "where was I?" anxiety |
| `/next` | Suggest one task | Reduces decision paralysis |
| `/focus` | Commit to one thing | Blocks mental wandering |
| `/done` | Save progress | Permission to stop, captures context |
| `/brain-dump` | Quick capture | Don't lose ideas, stay focused |
| `/stuck` | Get unstuck | Gentle guidance when blocked |

### 🔬 Research Commands (8)

| Command | Description | Context |
|---------|-------------|---------|
| `/analysis-plan` | Statistical analysis plan | Starting analysis |
| `/cite` | Find and format citations | Writing |
| `/hypothesis` | Formulate hypotheses | Study design |
| `/lit-gap` | Literature gap analysis | Proposal |
| `/manuscript` | Full manuscript workflow | Writing paper |
| `/method-scout` | Find methods | Methods section |
| `/revision` | Handle revisions | R&R |
| `/sim-design` | Simulation study design | Methods dev |

### 🧮 Math Commands (4)

| Command | Description | Context |
|---------|-------------|---------|
| `/derive` | Mathematical derivation | Theory |
| `/example` | Worked example | Teaching/paper |
| `/notation` | Notation consistency | Writing |
| `/proof` | Formal proof | Theory |

### 📚 Teach Commands (9)

| Command | Description | Context |
|---------|-------------|---------|
| `/canvas` | Canvas LMS formatting | Course mgmt |
| `/exam` | Create exam | Assessment |
| `/feedback` | Student feedback | Grading |
| `/homework` | Homework assignment | Course |
| `/lecture` | Lecture materials | Teaching |
| `/quiz` | Quick quiz | Assessment |
| `/rubric` | Grading rubric | Assessment |
| `/solution` | Solution key | Assessment |
| `/syllabus` | Course syllabus | Course |

### ✍️ Write Commands (5)

| Command | Description | Context |
|---------|-------------|---------|
| `/abstract` | Write abstract | Paper |
| `/cover-letter` | Journal cover letter | Submission |
| `/draft` | Draft text | Any writing |
| `/edit` | Edit/polish text | Revision |
| `/response` | Reviewer response | R&R |

---

## Quick Reference: Where Does It Go?

| If it's... | It goes in... |
|------------|---------------|
| Shell alias | **zsh-configuration** |
| Shell function | **zsh-configuration** |
| ADHD helper | **zsh-configuration** |
| Audit command | **zsh-configuration** |
| Focus/timer | **zsh-configuration** |
| CLI shortcut (cc, gm) | **zsh-configuration** |
| Slash command (/foo) | **~/.claude/commands/** |
| Skill | **~/.claude/skills/** |
| MCP config | **~/.claude/settings.json** |

---

## Options

### Option A: Quick Cleanup (~45 min)
- Phase 1: Delete backup, create archive
- Phase 2: Add Anthropic document skills
- Phase 3: Migrate Google Drive skills
- **Impact:** Cleaner skills directory

### Option B: Cleanup + /hub (~2-3 hours) ⭐ RECOMMENDED
- All of Option A
- Phase 4: Create `/hub` discovery command
- **Impact:** Major ADHD improvement with discovery

### Option C: Full Consolidation (add ~1 hour)
- All of Option B
- Phase 5: Retire zsh-claude-workflow (OPTIONAL)
- Phase 6: Migrate functions (OPTIONAL)
- **Impact:** Clean two-project ecosystem

---

## Summary

```
BEFORE                          AFTER
────────────────────────────    ────────────────────────────
ZSH:                            ZSH:
  zsh-configuration ✅            zsh-configuration ✅
  zsh-claude-workflow ⚠️          (optionally consolidated)

Claude:                         Claude:
  ~/.claude/ ✅                   ~/.claude/ ✅
  37 commands, 37 skills          + /hub discovery
  no organization                 + document skills
                                  + categorized skills

3 projects, confusion           2 projects, clarity
No discovery                    /hub shows everything
```

**Key insight:** You already have great commands and skills. The main improvement is **discoverability** via `/hub` and **organization** via skill categories.

---

## Sources

- [anthropics/skills](https://github.com/anthropics/skills) - Official 16 skills
- [claude-code-plugins-plus](https://github.com/jeremylongshore/claude-code-plugins-plus) - 243 plugins
- [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) - Curated list
- [skillsmp.com](https://skillsmp.com/) - Skills marketplace
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Community resources
