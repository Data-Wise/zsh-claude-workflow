# Claude Commands Redesign Plan

**Status**: Planning Complete - Ready for Implementation
**Created**: 2025-12-09
**Target Version**: v1.4
**Priority**: High
**Related**: `docs-check-command.md`, Multi-project coordination

---

## Overview

Comprehensive redesign of Claude Code slash commands using a **hybrid domain + shared activity** structure. Commands will be managed in zsh-claude-workflow and symlinked to `~/.claude/commands/`.

## Design Decision: Option C (Hybrid)

After analysis, the hybrid approach was chosen because:
1. **Domain-specific** categories (research/, teach/) for workflows unique to each
2. **Shared categories** (math/, code/, write/) work in both contexts
3. Natural fit with how work actually flows
4. Leverages existing MCP tools and skills

---

## Final 5-Category Structure

```
~/.claude/commands/              # Symlinked from zsh-claude-workflow
│
├── research/                    # Research-specific (user:research)
│   ├── lit-gap.md              # ✓ EXISTS - Literature gap analysis
│   ├── cite.md                 # ✓ EXISTS - Citation management
│   ├── manuscript.md           # ✓ EXISTS (was manuscript-section)
│   ├── revision.md             # NEW - Reviewer responses
│   ├── sim-design.md           # ✓ EXISTS - Simulation design
│   ├── method-scout.md         # NEW - Find methods for problem
│   ├── hypothesis.md           # NEW - Formulate hypotheses
│   └── analysis-plan.md        # NEW - Pre-registration/SAP
│
├── teach/                       # Teaching-specific (user:teach)
│   ├── exam.md                 # NEW - Full exam (examark)
│   ├── quiz.md                 # NEW - Quick quiz
│   ├── rubric.md               # NEW - Grading rubrics
│   ├── lecture.md              # NEW - Lecture outlines
│   ├── homework.md             # NEW - Problem sets
│   ├── solution.md             # NEW - Solution keys
│   ├── syllabus.md             # NEW - Course syllabus
│   ├── feedback.md             # NEW - Student feedback
│   └── canvas.md               # NEW - Canvas LMS operations
│
├── math/                        # Shared mathematical (user:math)
│   ├── proof.md                # ✓ EXISTS (was proof-check)
│   ├── derive.md               # NEW - Step-by-step derivations
│   ├── notation.md             # NEW - Notation standardization
│   └── example.md              # NEW - Worked examples
│
├── code/                        # Shared development (user:code)
│   ├── rpkg-check.md           # ✓ EXISTS - R package validation
│   ├── ecosystem-health.md     # ✓ EXISTS - Multi-package check
│   ├── docs-check.md           # ✓ EXISTS - Documentation validation
│   ├── release.md              # NEW - Release workflow
│   ├── debug.md                # NEW - Debug assistance
│   ├── refactor.md             # NEW - Refactoring guidance
│   ├── test-gen.md             # NEW - Generate test cases
│   └── demo.md                 # NEW - Code demonstrations
│
└── write/                       # Shared writing (user:write)
    ├── draft.md                # NEW - Generic drafting
    ├── abstract.md             # NEW - Paper abstracts
    ├── cover-letter.md         # NEW - Journal cover letters
    ├── response.md             # NEW - Generic responses
    └── edit.md                 # NEW - Editing/proofreading
```

**Total: 34 commands** (9 existing + 25 new)

---

## Command Details

### Research Category (8 commands)

| Command | Status | Purpose | MCP Integration |
|---------|--------|---------|-----------------|
| `lit-gap` | EXISTS | Find literature gaps | arxiv, crossref, literature-gap-finder skill |
| `cite` | EXISTS | Citation management | bibtex, zotero |
| `manuscript` | EXISTS | Write paper sections | methods-paper-writer skill |
| `sim-design` | EXISTS | Design simulations | simulation-architect skill |
| `revision` | NEW | Respond to reviewers | publication-strategist skill |
| `method-scout` | NEW | Find methods | cross-disciplinary-ideation, method-transfer skills |
| `hypothesis` | NEW | Formulate hypotheses | — |
| `analysis-plan` | NEW | Pre-registration | — |

### Teaching Category (9 commands)

| Command | Status | Purpose | Integration |
|---------|--------|---------|-------------|
| `exam` | NEW | Create full exam | examark CLI |
| `quiz` | NEW | Quick quiz creation | examark CLI |
| `rubric` | NEW | Grading rubrics | — |
| `lecture` | NEW | Lecture outlines | — |
| `homework` | NEW | Problem sets | examark format |
| `solution` | NEW | Solution keys | math skills |
| `syllabus` | NEW | Course syllabus | — |
| `feedback` | NEW | Student feedback | — |
| `canvas` | NEW | Canvas operations | examark verify/emulate |

### Math Category (4 commands) - SHARED

| Command | Status | Purpose | Works For |
|---------|--------|---------|-----------|
| `proof` | EXISTS | Verify proofs | Research papers, exam solutions |
| `derive` | NEW | Derive formulas | Paper appendix, lecture demos |
| `notation` | NEW | Standardize notation | Papers, courses |
| `example` | NEW | Worked examples | Teaching, paper examples |

### Code Category (8 commands) - SHARED

| Command | Status | Purpose | MCP Tools |
|---------|--------|---------|-----------|
| `rpkg-check` | EXISTS | R package check | r_check, r_test |
| `ecosystem-health` | EXISTS | Multi-package | r_check × N |
| `docs-check` | EXISTS | Documentation | — |
| `release` | NEW | Release workflow | r_check, r_coverage |
| `debug` | NEW | Debug help | r_execute |
| `refactor` | NEW | Refactoring | — |
| `test-gen` | NEW | Generate tests | r_test |
| `demo` | NEW | Code demos | r_execute, r_plot |

### Write Category (5 commands) - SHARED

| Command | Status | Purpose | MCP Skills |
|---------|--------|---------|------------|
| `draft` | NEW | Generic drafting | methods-communicator |
| `abstract` | NEW | Paper abstracts | methods-paper-writer |
| `cover-letter` | NEW | Journal covers | publication-strategist |
| `response` | NEW | Generic responses | — |
| `edit` | NEW | Editing help | — |

---

## Multi-Project Coordination

### Projects Involved

| Project | Role | Responsibility |
|---------|------|----------------|
| **zsh-claude-workflow** | Coordination Hub | Commands, workflows, install |
| **claude-statistical-research** | MCP Server | R tools, literature, 17 skills |
| **examark** | Teaching Tool | Exam → Canvas QTI |
| **~/.claude/** | User Config | Symlinks to commands |

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    COORDINATION ARCHITECTURE                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  zsh-claude-workflow/                                            │
│  ├── claude-commands/        ←── SOURCE OF TRUTH                 │
│  │   ├── research/                                               │
│  │   ├── teach/                                                  │
│  │   ├── math/                                                   │
│  │   ├── code/                                                   │
│  │   └── write/                                                  │
│  │                                                               │
│  ├── commands/               ←── Shell helpers                   │
│  │   ├── exam-gen                                                │
│  │   └── docs-check-cli                                          │
│  │                                                               │
│  ├── integrations/           ←── Cross-project bridges           │
│  │   ├── examark-bridge.sh                                       │
│  │   └── mcp-bridge.sh                                           │
│  │                                                               │
│  └── install.sh              ←── Creates symlinks                │
│           │                                                      │
│           ▼                                                      │
│  ~/.claude/commands/         ←── SYMLINKS                        │
│  ├── research → zsh-claude-workflow/claude-commands/research     │
│  ├── teach → zsh-claude-workflow/claude-commands/teach           │
│  └── ...                                                         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Data Flow Example

```
User: /exam "Create midterm on OLS regression"
  │
  ├─→ Claude reads: zsh-claude-workflow/claude-commands/teach/exam.md
  │
  ├─→ Claude may use: MCP r_execute (for examples)
  │
  ├─→ Claude generates: Markdown in examark format
  │
  ├─→ Claude calls: Bash → examark CLI
  │
  └─→ Output: .qti.zip for Canvas import
```

---

## Implementation Plan

### Phase 1: Structure (zsh-claude-workflow)

```bash
# Create directories
mkdir -p claude-commands/{research,teach,math,code,write}
mkdir -p integrations
mkdir -p workflows/{teaching,research}
```

### Phase 2: Migrate Existing Commands

| Current Location | New Location |
|------------------|--------------|
| `~/.claude/commands/cite.md` | `claude-commands/research/cite.md` |
| `~/.claude/commands/lit-gap.md` | `claude-commands/research/lit-gap.md` |
| `~/.claude/commands/manuscript-section.md` | `claude-commands/research/manuscript.md` |
| `~/.claude/commands/sim-design.md` | `claude-commands/research/sim-design.md` |
| `~/.claude/commands/proof-check.md` | `claude-commands/math/proof.md` |
| `~/.claude/commands/rpkg-check.md` | `claude-commands/code/rpkg-check.md` |
| `~/.claude/commands/ecosystem-health.md` | `claude-commands/code/ecosystem-health.md` |
| `~/.claude/commands/docs-check.md` | `claude-commands/code/docs-check.md` |

### Phase 3: Create New Commands

Priority order:
1. **Teaching (high value)**: exam.md, rubric.md, lecture.md
2. **Research additions**: revision.md, method-scout.md
3. **Shared enhancements**: derive.md, release.md, abstract.md

### Phase 4: Update install.sh

```bash
install_claude_commands() {
    local source_dir="$SCRIPT_DIR/claude-commands"
    local target_dir="$HOME/.claude/commands"

    # Backup existing
    [[ -d "$target_dir" ]] && mv "$target_dir" "$target_dir.backup.$(date +%s)"

    mkdir -p "$target_dir"

    # Create category symlinks
    for category in research teach math code write; do
        if [[ -d "$source_dir/$category" ]]; then
            ln -sf "$source_dir/$category" "$target_dir/$category"
            print_success "Linked $category commands"
        fi
    done
}
```

### Phase 5: Create Integration Bridges

**integrations/examark-bridge.sh:**
```bash
#!/usr/bin/env zsh
# Bridge between Claude commands and examark

exam_create() {
    local input="$1"
    local output="${2:-${input%.md}.qti.zip}"
    examark "$input" -o "$output" -v
}

exam_validate() {
    examark check "$1"
}

exam_preview() {
    examark "$1" --preview
}
```

### Phase 6: Verify & Test

```bash
# After install
/lit-gap          # Should work (user:research)
/exam             # Should work (user:teach)
/proof            # Should work (user:math)
/rpkg-check       # Should work (user:code)
/draft            # Should work (user:write)
```

---

## Key Command Specifications

### /exam (teach/exam.md)

```markdown
# Create Exam

Create a comprehensive exam using examark format for Canvas LMS.

## Required Input
- Course/topic
- Question types (MC, TF, Short, Essay, etc.)
- Number of questions
- Difficulty level

## Process
1. Gather learning objectives (if provided)
2. Generate questions in examark markdown format
3. Include answer key with [x] markers
4. Validate with `examark check`
5. Optionally export to QTI

## Integration
- Uses examark CLI for validation and export
- Supports all 8 question types
- Canvas-ready QTI 1.2 output

## Example
"Create a 15-question final exam on causal inference.
5 MC, 5 TF, 3 short answer, 2 essay. Graduate level."
```

### /derive (math/derive.md)

```markdown
# Derive Formula

Step-by-step mathematical derivation for research or teaching.

## Input
- Starting assumptions/formulas
- Target result
- Context (paper vs lecture)
- Notation preferences

## Process
1. List assumptions clearly
2. Show each step with justification
3. Highlight key insights
4. Format appropriately (LaTeX/Markdown)

## Context Awareness
- Research: Rigorous, cite prior work
- Teaching: Pedagogical, explain intuition

## Example
"Derive the variance of the indirect effect ab.
This is for a methods paper on mediation."
```

### /revision (research/revision.md)

```markdown
# Respond to Reviewers

Draft point-by-point responses to peer review.

## Input
- Review comments (paste or file)
- Original manuscript context
- Changes already made

## Process
1. Parse and number each comment
2. Categorize (major/minor)
3. Draft response for each
4. Note manuscript changes
5. Maintain professional tone

## Output
- Formatted response letter
- Change checklist
- Updated sections (optional)
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| Draft 1.0 | 2025-12-09 | Initial comprehensive plan |

---

## Related Documents

- `docs-check-command.md` - Shell implementation plan for docs-check
- `file-project-management-optimization.md` - v1.4-1.6 roadmap
- `~/.claude/CLAUDE.md` - User global instructions

---

## Next Steps

1. [ ] Review and approve this plan
2. [ ] Create directory structure in zsh-claude-workflow
3. [ ] Migrate existing commands
4. [ ] Create priority new commands (exam, rubric, derive)
5. [ ] Update install.sh
6. [ ] Test installation
7. [ ] Update zsh-claude-workflow CLAUDE.md

---

**Author**: Claude Code
**Status**: Ready for Implementation
