# Claude Slash Commands

A comprehensive suite of 34 Claude Code slash commands organized into 5 categories for research, teaching, coding, writing, and mathematics.

## Overview

These commands are designed to work with [Claude Code](https://claude.com/claude-code) and integrate with the MCP server tools and skills from [claude-statistical-research](https://github.com/Data-Wise/claude-statistical-research).

## Categories

| Category | Commands | Purpose |
|----------|----------|---------|
| [research/](research.md) | 8 | Literature, manuscripts, simulations |
| [teach/](teach.md) | 9 | Exams, rubrics, lectures (examark integration) |
| [math/](math.md) | 4 | Proofs, derivations, notation |
| [code/](code.md) | 8 | R packages, docs, releases |
| [write/](write.md) | 5 | Drafting, abstracts, editing |

**Total: 34 commands**

## Quick Reference

### Research Commands
```
/research/cite          # Citation management
/research/lit-gap       # Literature gap analysis
/research/manuscript    # Write paper sections
/research/revision      # Respond to reviewers
/research/sim-design    # Simulation design
/research/method-scout  # Find methods across disciplines
/research/hypothesis    # Formulate testable hypotheses
/research/analysis-plan # Pre-registration/SAP
```

### Teaching Commands
```
/teach/exam       # Create full exams (examark)
/teach/quiz       # Quick formative assessments
/teach/rubric     # Grading rubrics
/teach/lecture    # Lecture outlines
/teach/homework   # Problem sets
/teach/solution   # Solution keys
/teach/syllabus   # Course syllabus
/teach/feedback   # Student feedback
/teach/canvas     # Canvas LMS operations
```

### Math Commands
```
/math/proof     # Verify mathematical proofs
/math/derive    # Step-by-step derivations
/math/notation  # Standardize notation
/math/example   # Create worked examples
```

### Code Commands
```
/code/rpkg-check       # R package validation
/code/ecosystem-health # Multi-package check
/code/docs-check       # Documentation validation
/code/release          # Release workflow
/code/debug            # Debugging assistance
/code/refactor         # Refactoring guidance
/code/test-gen         # Generate test cases
/code/demo             # Code demonstrations
```

### Write Commands
```
/write/abstract      # Paper abstracts
/write/cover-letter  # Journal cover letters
/write/draft         # Generic drafting
/write/response      # Professional responses
/write/edit          # Editing and proofreading
```

## Installation

Commands are installed via symlinks to `~/.claude/commands/`:

```bash
# Run the install script
./install.sh

# Or manually create symlinks
ln -sf ~/projects/dev-tools/zsh-claude-workflow/claude-commands/research ~/.claude/commands/research
ln -sf ~/projects/dev-tools/zsh-claude-workflow/claude-commands/teach ~/.claude/commands/teach
ln -sf ~/projects/dev-tools/zsh-claude-workflow/claude-commands/math ~/.claude/commands/math
ln -sf ~/projects/dev-tools/zsh-claude-workflow/claude-commands/code ~/.claude/commands/code
ln -sf ~/projects/dev-tools/zsh-claude-workflow/claude-commands/write ~/.claude/commands/write
```

## Usage

In Claude Code, type `/` followed by the command path:

```
/research/lit-gap "mediation analysis in health psychology"
/teach/exam "Create a 20-question midterm on regression"
/math/derive "variance of indirect effect ab"
/code/release "help me release v1.0 of my R package"
/write/abstract "summarize my methods paper"
```

## Integration

### MCP Server Tools

Many commands integrate with MCP server tools:

- `r_execute`, `r_test`, `r_check` for code commands
- `arxiv_search`, `crossref_lookup` for research commands
- `bibtex`, `zotero` for citation management

### examark Integration

Teaching commands integrate with [examark](https://github.com/Data-Wise/examark) for Canvas LMS:

- `/teach/exam` generates examark-formatted exams
- `/teach/canvas` handles QTI export and validation
- `/teach/quiz` creates quick assessments

### Skills Integration

Commands leverage MCP skills:

- `simulation-architect` for `/research/sim-design`
- `methods-paper-writer` for `/research/manuscript`
- `publication-strategist` for `/research/revision`

## Directory Structure

```
~/.claude/commands/
├── research/ -> zsh-claude-workflow/claude-commands/research
├── teach/    -> zsh-claude-workflow/claude-commands/teach
├── math/     -> zsh-claude-workflow/claude-commands/math
├── code/     -> zsh-claude-workflow/claude-commands/code
└── write/    -> zsh-claude-workflow/claude-commands/write
```
