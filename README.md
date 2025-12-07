# zsh-claude Workflow System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Documentation](https://img.shields.io/badge/docs-mkdocs-blue.svg)](https://data-wise.github.io/zsh-claude-workflow/)
[![Shell: Zsh](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![Platform: macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos/)

A smart context manager and workflow automation system for Claude Code integration with optimized plugin management.

📚 **[Read the full documentation →](https://data-wise.github.io/zsh-claude-workflow/)**

## Features

### ✨ Context Manager (Phase 1 - Complete)
- **Auto-detect project types** (R package, Quarto, research, dev-tool)
- **Gather Claude context** from CLAUDE.md files and project structure
- **Template system** for creating new CLAUDE.md files
- **Smart project info** with project-specific intelligence
- **Storage awareness** (local, Google Drive, OneDrive, Dropbox)

### ⚡ Plugin Management (Bonus)
- **Antidote integration** - Modern, fast plugin manager
- **Optimized configuration** - 20-40% faster shell startup
- **20+ plugins** - Git, FZF, autosuggestions, syntax highlighting
- **Lazy loading** - Heavy plugins load only when needed
- **Easy management** - Simple text file configuration

### 🚀 Future Phases
- Multi-storage navigation (local + Google Drive + OneDrive)
- Ecosystem manager for mediationverse packages
- Session management and restoration

## Installation

```bash
# Clone or navigate to project
cd ~/code/zsh-claude-workflow

# Run installation
./install.sh

# Reload shell
source ~/.zshrc
```

## Quick Start

```bash
# Detect current project type
proj-type

# Show project info with Claude context
proj-info

# Gather context for Claude
claude-ctx

# Create CLAUDE.md for current project
claude-init

# Open Claude Code with auto-gathered context
proj-claude
```

## Commands

### Project Detection
- `proj-type` - Detect project type (R package, Quarto, research, etc.)
- `proj-info` - Smart project info with type-specific details

### Claude Context
- `claude-ctx` - Gather and display Claude context files
- `claude-init` - Create CLAUDE.md from template
- `claude-show` - Display current CLAUDE.md
- `proj-claude` - Open Claude Code with project context

## Project Structure

```
~/code/zsh-claude-workflow/
├── lib/                           # Core libraries
│   ├── project-detector.sh       # Detect project types
│   ├── claude-context.sh         # Claude context gathering
│   └── core.sh                   # Shared utilities
├── commands/                      # Command implementations
│   ├── proj-type, proj-info     # Project detection
│   ├── claude-ctx, claude-init   # Claude context
│   ├── claude-show, proj-claude  # Claude integration
├── templates/                     # Templates
│   ├── CLAUDE-rpkg.md            # R package template
│   ├── CLAUDE-quarto.md          # Quarto template
│   ├── CLAUDE-research.md        # Research project template
│   └── zsh_plugins.txt.recommended # Optimized plugin config
├── config/
│   └── defaults.conf             # Configuration
├── docs/                          # Documentation
│   ├── README.md                 # Documentation index
│   ├── COMMANDS.md               # Command reference
│   ├── migration/                # Migration guides
│   │   └── ANTIDOTE_MIGRATION.md
│   ├── optimization/             # Optimization guides
│   │   ├── PLUGIN_OPTIMIZATION.md
│   │   └── PLUGIN_COMPARISON.md
│   └── reference/                # Historical/reference docs
├── README.md                      # This file
└── install.sh                     # Installation script
```

## Integration with Existing Workflow

This system enhances your existing zsh setup:
- Works with your R package development aliases (rpkg, rdev, etc.)
- Integrates with existing CLAUDE.md files
- Respects your hybrid local/cloud storage structure
- Compatible with Oh My Zsh and modern CLI tools

## Documentation

Full documentation is available at: **https://data-wise.github.io/zsh-claude-workflow/**

Topics covered:
- [Installation Guide](https://data-wise.github.io/zsh-claude-workflow/getting-started/installation/)
- [Quick Start](https://data-wise.github.io/zsh-claude-workflow/getting-started/quickstart/)
- [Command Reference](https://data-wise.github.io/zsh-claude-workflow/commands/reference/)
- [Project Types](https://data-wise.github.io/zsh-claude-workflow/guide/project-types/)
- [Templates](https://data-wise.github.io/zsh-claude-workflow/guide/templates/)
- [Context Management](https://data-wise.github.io/zsh-claude-workflow/guide/context-management/)

## Contributing

Contributions are welcome! Please see our [Contributing Guide](https://data-wise.github.io/zsh-claude-workflow/development/contributing/).

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Links

- **Documentation**: https://data-wise.github.io/zsh-claude-workflow/
- **Repository**: https://github.com/Data-Wise/zsh-claude-workflow
- **Issues**: https://github.com/Data-Wise/zsh-claude-workflow/issues
