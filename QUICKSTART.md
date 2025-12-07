# Quick Start Guide

## Installation Complete! ✅

The zsh-claude-workflow system has been installed and is ready to use.

---

## Test It Out

Open a **new terminal** or reload your shell:
```bash
source ~/.zshrc
```

Then try these commands:

### 1. Check Project Type
```bash
# Navigate to any R package
cd ~/R-packages/active/rmediation

# Check project type
proj-type
```

### 2. View Project Info
```bash
# Full project information
proj-info
```

### 3. Check Claude Context
```bash
# See if project has CLAUDE.md
claude-ctx
```

### 4. Create CLAUDE.md (if needed)
```bash
# For projects without CLAUDE.md
cd ~/R-packages/active/probmed
claude-init

# Edit the generated file
vim CLAUDE.md
```

### 5. Display CLAUDE.md
```bash
claude-show
```

### 6. Open Claude Code with Context
```bash
# Opens Claude Code with project awareness
proj-claude
```

---

## Quick Command Reference

| Command | Alias | What it does |
|---------|-------|--------------|
| `proj-type` | `ptype` | Show project type and status |
| `proj-info` | `pinfo` | Full project details |
| `claude-ctx` | `cctx` | Show Claude instruction files |
| `claude-init` | `cinit` | Create CLAUDE.md from template |
| `claude-show` | `cshow` | Display CLAUDE.md |
| `proj-claude` | `pclaude` | Open Claude Code |

---

## Common Workflows

### Setting up a new R package

```bash
cd ~/R-packages/active/newpackage
ptype              # Check project type
cinit              # Create CLAUDE.md
vim CLAUDE.md      # Customize it
pclaude            # Start working with Claude
```

### Quick status check

```bash
cd ~/R-packages/active/rmediation
ptype              # Quick overview
```

### View project documentation

```bash
pinfo              # Full project context
cshow              # Claude instructions
```

---

## What Was Created

```
~/code/zsh-claude-workflow/
├── README.md              # Full documentation
├── QUICKSTART.md          # This file
├── install.sh             # Installation script
├── lib/                   # Core libraries
│   ├── core.sh           # Utilities
│   ├── project-detector.sh  # Project type detection
│   └── claude-context.sh    # Context gathering
├── commands/              # Executable commands
│   ├── proj-type
│   ├── proj-info
│   ├── claude-ctx
│   ├── claude-init
│   ├── claude-show
│   └── proj-claude
├── templates/             # CLAUDE.md templates
│   ├── CLAUDE-rpkg.md
│   ├── CLAUDE-quarto.md
│   └── CLAUDE-research.md
├── config/
│   └── defaults.conf      # Configuration
└── docs/
    └── COMMANDS.md        # Detailed command reference
```

---

## What Was Added to .zshrc

The installation added:
- Commands to your PATH
- Convenient aliases (ptype, cctx, etc.)

Check the end of your `~/.zshrc` file to see the additions.

---

## Next Steps

1. **Try it on your packages**: Navigate to each of your R packages and run `ptype`
2. **Create CLAUDE.md files**: For packages without them, run `cinit`
3. **Customize templates**: Edit templates in `~/code/zsh-claude-workflow/templates/`
4. **Read full docs**: See `README.md` and `docs/COMMANDS.md`

---

## Detected Project Types

The system auto-detects:
- ✅ R Packages (has DESCRIPTION with Package: field)
- ✅ Quarto Projects (has _quarto.yml or .qmd files)
- ✅ Quarto Extensions (has _extension.yml)
- ✅ Research Projects (has LaTeX files, literature/)
- ✅ Git Projects (general projects with .git)

---

## Storage Awareness

The system knows where projects are:
- **Location**: local, google-drive, onedrive, dropbox
- **Tier**: active, stable, archive, scratch

This helps you understand project organization at a glance.

---

## Tips

💡 **Use ptype frequently** - Quick way to orient yourself
💡 **Create CLAUDE.md early** - Better Claude integration
💡 **Combine with z** - `z rmediation && pinfo`
💡 **Leverage existing aliases** - Works with rdev, rpkg, etc.

---

## Need Help?

- **Full documentation**: `cat ~/code/zsh-claude-workflow/README.md`
- **Command reference**: `cat ~/code/zsh-claude-workflow/docs/COMMANDS.md`
- **Your workflow skills**: `~/.claude/skills/`

---

## Test Examples

```bash
# Test on active packages
cd ~/R-packages/active/rmediation && ptype
cd ~/R-packages/active/medfit && pinfo
cd ~/R-packages/active/probmed && cctx

# Test on Quarto
cd ~/quarto-projects/extensions/unm-revealjs && ptype

# Test creating CLAUDE.md
cd ~/R-packages/scratch && cinit
```

---

**Created**: 2025-12-07
**System**: zsh-claude-workflow v1.0
