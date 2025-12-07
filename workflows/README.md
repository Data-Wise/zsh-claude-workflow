# Workflows

This directory contains YAML-based workflow definitions for different project types.

## Structure

```
workflows/
├── rpkg/              # R package workflows
│   ├── dev.yml       # Development cycle (doc → test → check)
│   ├── test.yml      # Testing workflow
│   └── pre-commit.yml # Pre-commit checks
│
├── quarto/            # Quarto project workflows
│   ├── preview.yml   # Preview workflow
│   └── render.yml    # Render workflow
│
└── research/          # Research project workflows
    └── ...
```

## Workflow YAML Format

Each workflow is defined in YAML with the following structure:

```yaml
name: Workflow Name
type: project-type
description: Brief description of what this workflow does

steps:
  - name: Step Name
    command: shell-command-or-function
    type: shell|r-script|function
    description: What this step does

shortcuts:
  - name: alias-name
    description: Description of shortcut
```

## Using Workflows

Run a workflow with:

```bash
workflow-run <workflow-name>
```

List available workflows:

```bash
workflow-run list
```

Show workflow details:

```bash
workflow-run info <workflow-name>
```

## Custom Workflows

You can create project-specific workflows in your project's `.claude/workflows/` directory. They will take precedence over the default workflows.

Example:

```bash
mkdir -p .claude/workflows
cp ~/code/zsh-claude-workflow/workflows/rpkg/dev.yml .claude/workflows/custom-dev.yml
# Edit .claude/workflows/custom-dev.yml to customize
```

## Workflow Integration

Workflows integrate with your existing .zshrc functions:
- `rdoc`, `rtest`, `rcheck` (R package development)
- `qp`, `qr`, `qc` (Quarto)
- Any custom functions you've defined

Workflows are executed in order. If a step fails, the workflow stops (unless you use `--continue` flag).
