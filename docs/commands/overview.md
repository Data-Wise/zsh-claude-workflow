# Commands Overview

zsh-claude-workflow provides nine main commands for project detection, Claude Code integration, and workflow automation.

## Command Categories

### 🔍 Project Detection

Commands for understanding your project structure:

| Command | Alias | Purpose |
|---------|-------|---------|
| `proj-type` | `ptype` | Quick project type detection |
| `proj-info` | `pinfo` | Comprehensive project information |

### 🤖 Claude Integration

Commands for managing Claude Code context:

| Command | Alias | Purpose |
|---------|-------|---------|
| `claude-ctx` | `cctx` | Show Claude instruction files |
| `claude-init` | `cinit` | Create CLAUDE.md from template |
| `claude-show` | `cshow` | Display CLAUDE.md content |
| `proj-claude` | `pclaude` | Open Claude Code with context |

### 🚀 Workflow & Skills Management (v1.3)

Commands for automation and skill management:

| Command | Alias | Purpose |
|---------|-------|---------|
| `workflow-run` | - | Run automated workflows (dev, test, deploy) |
| `rpkg-setup` | - | Smart R package initialization |
| `skill-activate` | - | Manage Claude skills for projects |

## Quick Examples

### Project Detection

```bash
# Quick type check
proj-type

# Full project info
proj-info
```

### Claude Context

```bash
# Check for CLAUDE.md
claude-ctx

# Create CLAUDE.md
claude-init

# View CLAUDE.md
claude-show

# Launch Claude Code
proj-claude
```

### Workflow & Skills (v1.3)

```bash
# Run development workflow
workflow-run dev

# Create R package with workflows
rpkg-setup mypackage --type statistical

# Activate Claude skills
skill-activate auto
```

## Command Design Philosophy

All commands follow these principles:

1. **Sensible defaults** - Work without arguments in most cases
2. **Current directory** - Operate on current directory by default
3. **Optional path** - Accept directory path as optional argument
4. **Colorful output** - Use colors for better readability
5. **Helpful errors** - Provide actionable error messages

## Common Patterns

### Working with Current Directory

All commands work in the current directory by default:

```bash
cd ~/R-packages/active/rmediation
proj-type          # Works on current directory
claude-ctx         # Works on current directory
```

### Working with Specific Directory

Pass a directory path as the first argument:

```bash
proj-type ~/R-packages/active/medfit
claude-ctx ~/quarto-projects/book
```

### Combining Commands

Commands are designed to be used together:

```bash
# New project workflow
cd ~/R-packages/active/newpkg
proj-type          # Verify detection
claude-init        # Create CLAUDE.md
claude-show        # Review it
proj-claude        # Start coding
```

## Aliases

Short aliases are available for faster typing:

```bash
ptype              # Instead of proj-type
pinfo              # Instead of proj-info
cctx               # Instead of claude-ctx
cinit              # Instead of claude-init
cshow              # Instead of claude-show
pclaude            # Instead of proj-claude
```

## Next Steps

- [Command Reference](reference.md) - Detailed documentation for each command
- [Quick Start](../getting-started/quickstart.md) - Get started quickly
- [Project Types](../guide/project-types.md) - Learn about project detection
