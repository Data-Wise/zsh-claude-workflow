# Claude Aliases & Commands Reference

!!! warning "Historical Reference"
    This is a historical document moved from the project root for reference purposes.
    Some links may be broken or point to old file locations.
    For current documentation, see the main navigation sections.

**Last Updated**: 2025-12-07

This document lists all Claude-related aliases and commands configured in your `.zshrc`.

---

## Overview

Your `.zshrc` contains **8 Claude-related aliases** organized into two sections:
1. Direct Claude Code CLI shortcuts (2 aliases)
2. zsh-claude-workflow context management (6 aliases)

---

## Section 1: Claude Code CLI Shortcuts

**Location**: `~/.zshrc` lines 236-241

### Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `cc` | `claude` | Launch Claude Code in current directory |
| `ccc` | `claude chat` | Launch Claude Code in chat mode |

### Usage Examples

```bash
# Start Claude Code in current project
cd ~/R-packages/active/rmediation
cc

# Start Claude Code chat
ccc
```

---

## Section 2: zsh-claude-workflow

**Location**: `~/.zshrc` lines 609-621

### PATH Configuration

```bash
export PATH="$HOME/code/zsh-claude-workflow/commands:$PATH"
```

This adds 6 commands to your PATH:
- `proj-type` - Detect project type
- `proj-info` - Show detailed project information
- `claude-ctx` - Gather and display Claude context files
- `claude-init` - Create CLAUDE.md from template
- `claude-show` - Display CLAUDE.md content
- `proj-claude` - Open Claude Code with auto-gathered context

### Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ptype` | `proj-type` | Detect and display project type |
| `pinfo` | `proj-info` | Show detailed project information |
| `cctx` | `claude-ctx` | Show Claude context files |
| `cinit` | `claude-init` | Create CLAUDE.md from template |
| `cshow` | `claude-show` | Display CLAUDE.md content |
| `pclaude` | `proj-claude` | Launch Claude Code with context |

### Usage Examples

```bash
# Detect project type
cd ~/R-packages/active/rmediation
ptype
# Output: 📦 RMediation - Type: R Package

# Show Claude context
cctx
# Output: Lists all CLAUDE.md files in project

# Create CLAUDE.md for new project
cd ~/R-packages/scratch/newpackage
cinit
# Output: Creates CLAUDE.md from R package template

# Open Claude Code with auto-gathered context
pclaude
# Output: Launches Claude Code with project context
```

---

## Complete Command List

### Claude Code CLI

| Command | Shortcut | Type | Description |
|---------|----------|------|-------------|
| `claude` | `cc` | Alias | Launch Claude Code |
| `claude chat` | `ccc` | Alias | Launch Claude Code chat |

### Project Detection

| Command | Shortcut | Type | Description |
|---------|----------|------|-------------|
| `proj-type` | `ptype` | Command + Alias | Detect project type (rpkg, quarto, research) |
| `proj-info` | `pinfo` | Command + Alias | Show project metadata and context |

### Claude Context Management

| Command | Shortcut | Type | Description |
|---------|----------|------|-------------|
| `claude-ctx` | `cctx` | Command + Alias | Find and display CLAUDE.md files |
| `claude-init` | `cinit` | Command + Alias | Create CLAUDE.md from template |
| `claude-show` | `cshow` | Command + Alias | Display CLAUDE.md content with syntax highlighting |
| `proj-claude` | `pclaude` | Command + Alias | Open Claude Code with context |

---

## Workflow Examples

### New R Package Development

```bash
# Navigate to new package
cd ~/R-packages/scratch/mynewpkg

# Check project type
ptype
# Output: R Package detected

# Create CLAUDE.md instructions
cinit
# Output: Created CLAUDE.md from R package template

# Verify context
cctx
# Output: Shows CLAUDE.md in current directory

# Open Claude Code with context
pclaude
# Launches Claude Code with R package context
```

### Working on Quarto Project

```bash
# Navigate to Quarto project
cd ~/quarto-projects/my-book

# Check what Claude sees
cctx
# Shows CLAUDE.md files

# Display current instructions
cshow
# Shows formatted CLAUDE.md content

# Launch Claude Code
cc
# Opens Claude Code in current directory
```

### Research Project

```bash
# Navigate to research project
cd ~/research/my-study

# Check project type
ptype
# Output: Research Project detected

# Create instructions for Claude
cinit
# Creates CLAUDE.md from research template

# Launch Claude Code with context
pclaude
```

---

## Integration with Existing Workflow

### R Package Development

Your zsh-claude-workflow integrates seamlessly with existing R package aliases:

```bash
# Existing R package workflow
rdev                    # R development session
rpkg                    # R package commands

# NEW: Claude integration
ptype                   # Detect R package
cinit                   # Create CLAUDE.md
pclaude                 # Launch Claude with R pkg context
```

### Git Workflow

```bash
# Standard git workflow
gst                     # git status
ga .                    # git add
gcmsg "message"         # git commit

# NEW: Add Claude context
cctx                    # Check Claude instructions
cinit                   # Create CLAUDE.md if missing
```

---

## File Locations

### Commands Directory
```
~/code/zsh-claude-workflow/commands/
├── proj-type          # Project type detection
├── proj-info          # Project information
├── claude-ctx         # Context gathering
├── claude-init        # CLAUDE.md creation
├── claude-show        # Display CLAUDE.md
└── proj-claude        # Launch Claude Code
```

### Configuration
```
~/.zshrc               # Shell configuration (aliases defined here)
```

### Templates
```
Project templates directory
├── CLAUDE-rpkg.md     # R package template
├── CLAUDE-quarto.md   # Quarto template
└── CLAUDE-research.md # Research template
```

---

## Quick Reference Card

### Most Used Commands

| Task | Command | Quick Alias |
|------|---------|-------------|
| Launch Claude Code | `claude` | `cc` |
| Launch Claude chat | `claude chat` | `ccc` |
| Check project type | `proj-type` | `ptype` |
| Show Claude context | `claude-ctx` | `cctx` |
| Create CLAUDE.md | `claude-init` | `cinit` |
| Launch with context | `proj-claude` | `pclaude` |

### Common Workflows

**Create new project with Claude:**
```bash
cinit → cshow → pclaude
```

**Check existing project:**
```bash
ptype → cctx → cc
```

**Quick launch:**
```bash
cc   # or ccc for chat
```

---

## Verification

To verify all aliases and commands are working:

```bash
# Check aliases are defined
alias | grep -E '(cc|ccc|ptype|pinfo|cctx|cinit|cshow|pclaude)'

# Check commands are in PATH
which proj-type claude-ctx

# Test a command
cd ~/R-packages/active/rmediation
ptype
```

---

## Status

| Component | Status |
|-----------|--------|
| Claude Code CLI shortcuts | ✅ Configured |
| zsh-claude-workflow commands | ✅ Installed |
| PATH export | ✅ Configured |
| Aliases | ✅ All 8 defined |
| Command files | ✅ All 6 exist |
| Templates | ✅ 3 templates available |

**Everything is configured and ready to use!** ✅

---

## Related Documentation

For current documentation, see the main navigation:
- Command Reference - Detailed command documentation
- Getting Started - Quick start guide
- User Guide - Templates and project types

---

**Note**: All commands work in interactive zsh sessions. Some may not work in subshells or when called from scripts due to PATH and environment differences.
