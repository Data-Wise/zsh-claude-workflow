# zsh-claude Workflow System

A smart context manager and workflow automation system for Claude Code integration with optimized plugin management.

<div class="grid cards" markdown>

-   :material-robot-happy:{ .lg .middle } __Smart Context Management__

    ---

    Auto-detect project types and gather Claude context from CLAUDE.md files and project structure

    [:octicons-arrow-right-24: Getting Started](getting-started/installation.md)

-   :material-lightning-bolt:{ .lg .middle } __Optimized Plugin System__

    ---

    Antidote integration with 20+ plugins and 20-40% faster shell startup through lazy loading

    [:octicons-arrow-right-24: Plugin Optimization](optimization/plugins.md)

-   :material-file-tree:{ .lg .middle } __Project Intelligence__

    ---

    Smart detection for R packages, Quarto, research projects with storage tier awareness

    [:octicons-arrow-right-24: Project Types](guide/project-types.md)

-   :material-cog:{ .lg .middle } __Template System__

    ---

    Create project-specific CLAUDE.md files from customizable templates

    [:octicons-arrow-right-24: Templates](guide/templates.md)

-   :material-console:{ .lg .middle } __CLI Aliases (55+ shortcuts)__

    ---

    Comprehensive aliases for Claude Code CLI and Gemini CLI integrated with R workflows

    [:octicons-arrow-right-24: CLI Aliases](guide/cli-aliases.md)

</div>

## Features

### ✨ Context Manager (Phase 1 - Complete)

- **Auto-detect project types** - Automatically identify R packages, Quarto projects, research repos, and dev tools
- **Gather Claude context** - Intelligently collect CLAUDE.md files and project structure information
- **Template system** - Generate project-specific CLAUDE.md files from templates
- **Smart project info** - Display project details with type-specific intelligence
- **Storage awareness** - Detect and display storage location (local, Google Drive, OneDrive, Dropbox)

### ⚡ Plugin Management (Bonus)

- **Antidote integration** - Modern, fast plugin manager built on antibody
- **Optimized configuration** - 20-40% faster shell startup times
- **20+ plugins** - Git tools, FZF, autosuggestions, syntax highlighting, and more
- **Lazy loading** - Heavy plugins load only when needed
- **Easy management** - Simple text file configuration

### 🚀 Future Phases

- Multi-storage navigation (local + Google Drive + OneDrive)
- Ecosystem manager for package suites
- Session management and restoration

## Quick Example

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

## Project Philosophy

This project follows a **progressive enhancement** approach:

1. **Core functionality first** - Context management and project detection
2. **Enhance existing workflows** - Work with your current setup
3. **Future expansion** - Multi-storage navigation, ecosystem management

## Integration

Works seamlessly with:

- R package development workflows (`rpkg`, `rdev`, etc.)
- Quarto project workflows (`qp`, `qr`, `qc`)
- Git workflows (`gst`, `ga`, `gcmsg`)
- Modern CLI tools (`bat`, `eza`, `fd`, `rg`)
- **Claude Code CLI** - 34 aliases for R development and code review
- **Gemini CLI** - 15 aliases for web research and general assistance
- Existing CLAUDE.md files in your projects

## License

MIT License - See [LICENSE](https://github.com/Data-Wise/zsh-claude-workflow/blob/main/LICENSE) for details
