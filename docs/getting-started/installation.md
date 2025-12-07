# Installation

## Prerequisites

- **zsh** (5.0+) - Shell environment
- **git** - Version control
- **Homebrew** (macOS) - For package management

## Required Packages

Install required dependencies:

```bash
# Install antidote plugin manager
brew install antidote

# Optional but recommended
brew install bat tree fzf  # Enhanced file display and fuzzy finding
brew install eza fd        # Modern replacements for ls and find
```

## Installation Steps

### 1. Clone the Repository

```bash
# Clone to your code directory
cd ~/code
git clone https://github.com/Data-Wise/zsh-claude-workflow.git
cd zsh-claude-workflow
```

### 2. Run Installation Script

```bash
./install.sh
```

The installation script will:

- ✅ Add commands to your `PATH`
- ✅ Create shell aliases for convenience
- ✅ Set up antidote plugin manager
- ✅ Configure recommended plugins (optional)
- ✅ Update your `~/.zshrc`

### 3. Reload Shell

```bash
source ~/.zshrc
```

## Verify Installation

Check that commands are available:

```bash
# Test project detection
proj-type

# Test context gathering
claude-ctx

# Check version
proj-info
```

## What Gets Modified

The installer modifies these files:

- `~/.zshrc` - Adds PATH and aliases
- `~/.zsh_plugins.txt` - Plugin configuration (if you opt-in)

!!! tip "Backup First"
    The installer creates backups of modified files with `.backup` extension.

## Manual Installation

If you prefer manual installation:

### 1. Add to PATH

Add to your `~/.zshrc`:

```bash
# zsh-claude-workflow
export PATH="$HOME/code/zsh-claude-workflow/commands:$PATH"
```

### 2. Create Aliases (Optional)

```bash
# Project commands
alias ptype='proj-type'
alias pinfo='proj-info'

# Claude commands
alias cctx='claude-ctx'
alias cinit='claude-init'
alias cshow='claude-show'
alias pclaude='proj-claude'
```

### 3. Reload Shell

```bash
source ~/.zshrc
```

## Next Steps

- [Quick Start Guide](quickstart.md) - Get started with common tasks
- [Command Reference](../commands/reference.md) - Learn all available commands
- [Project Types](../guide/project-types.md) - Understand project detection
