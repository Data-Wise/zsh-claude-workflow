# Quick Start Guide

Get started with zsh-claude-workflow in minutes.

## Prerequisites

Make sure you've [installed the system](installation.md) and reloaded your shell:

```bash
source ~/.zshrc
```

## Basic Workflow

### 1. Check Project Type

Navigate to any project and check its type:

```bash
# Navigate to an R package
cd ~/R-packages/active/rmediation

# Check project type
proj-type
```

!!! example "Expected Output"
    ```
    📦 R Package
    Name: rmediation
    Location: local / active
    ```

### 2. View Full Project Info

Get comprehensive project information:

```bash
proj-info
```

### 3. Check Claude Context

See if your project has Claude instruction files:

```bash
claude-ctx
```

### 4. Create CLAUDE.md

For projects without CLAUDE.md, create one from a template:

```bash
# Creates project-specific CLAUDE.md
claude-init

# Edit the generated file
vim CLAUDE.md
```

### 5. Display CLAUDE.md

View the contents of your CLAUDE.md:

```bash
claude-show
```

### 6. Open Claude Code

Launch Claude Code with project context:

```bash
proj-claude
```

## Quick Command Reference

| Command | Alias | Description |
|---------|-------|-------------|
| `proj-type` | `ptype` | Show project type and status |
| `proj-info` | `pinfo` | Full project details |
| `claude-ctx` | `cctx` | Show Claude instruction files |
| `claude-init` | `cinit` | Create CLAUDE.md from template |
| `claude-show` | `cshow` | Display CLAUDE.md |
| `proj-claude` | `pclaude` | Open Claude Code with context |

## Common Workflows

### Setting Up a New R Package

```bash
cd ~/R-packages/active/newpackage
ptype              # Check project type
cinit              # Create CLAUDE.md
vim CLAUDE.md      # Customize it
pclaude            # Start working with Claude
```

### Quick Status Check

```bash
cd ~/R-packages/active/rmediation
ptype              # Quick overview
```

### View Project Documentation

```bash
pinfo              # Full project context
cshow              # Claude instructions
```

## Tips & Tricks

!!! tip "Use Commands Frequently"
    - **ptype** - Quick way to orient yourself in any project
    - **Combine with z** - `z rmediation && pinfo`
    - **Leverage existing aliases** - Works with rdev, rpkg, etc.

!!! tip "Create CLAUDE.md Early"
    Creating CLAUDE.md files early in development ensures better Claude Code integration.

!!! tip "Customize Templates"
    Edit templates in `~/code/zsh-claude-workflow/templates/` to match your preferences.

## Detected Project Types

The system automatically detects:

- ✅ **R Packages** - Has DESCRIPTION with Package: field
- ✅ **Quarto Projects** - Has _quarto.yml or .qmd files
- ✅ **Quarto Extensions** - Has _extension.yml
- ✅ **Research Projects** - Has LaTeX files, literature/
- ✅ **Git Projects** - General projects with .git

## Storage Awareness

The system understands project organization:

- **Location**: local, google-drive, onedrive, dropbox
- **Tier**: active, stable, archive, scratch

This helps you understand project status at a glance.

## Test Examples

Try these commands to test the system:

```bash
# Test on active packages
cd ~/R-packages/active/rmediation && ptype
cd ~/R-packages/active/medfit && pinfo
cd ~/R-packages/active/probmed && cctx

# Test on Quarto projects
cd ~/quarto-projects/extensions/unm-revealjs && ptype

# Test creating CLAUDE.md
cd /tmp && mkdir test-project && cd test-project
echo "Package: testpkg" > DESCRIPTION
cinit
cat CLAUDE.md
```

## Next Steps

- [Command Reference](../commands/reference.md) - Detailed command documentation
- [Project Types](../guide/project-types.md) - Learn about project detection
- [Templates](../guide/templates.md) - Customize CLAUDE.md templates
- [Context Management](../guide/context-management.md) - Advanced context features
