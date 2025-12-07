# CLAUDE.md for zsh-claude-workflow

This file provides guidance to Claude Code when working with this project.

---

## About This Project

**zsh-claude-workflow** is a smart context manager and workflow automation system for Claude Code integration, with optimized zsh plugin management using antidote.

### Core Mission

Provide seamless integration between zsh workflows and Claude Code by:
1. Auto-detecting project types (R packages, Quarto, research, etc.)
2. Gathering and presenting Claude context from CLAUDE.md files
3. Managing zsh plugins efficiently with antidote
4. Creating templates for common project types

### Key Features

| Feature | Description | Status |
|---------|-------------|--------|
| **Project Detection** | Auto-detect R pkg, Quarto, research projects | ✅ Complete |
| **Context Gathering** | Find and display CLAUDE.md files | ✅ Complete |
| **Template System** | Generate project-specific CLAUDE.md | ✅ Complete |
| **Plugin Management** | Antidote integration + optimization | ✅ Complete |
| **Storage Awareness** | Detect local/cloud storage tiers | ✅ Complete |

---

## Common Development Commands

```bash
# Test commands
cd ~/code/zsh-claude-workflow
./commands/proj-type .                # Test project detection
./commands/claude-ctx .               # Test context gathering

# Install/update
./install.sh                          # Install or update

# Test in actual use
cd ~/R-packages/active/rmediation
proj-type                             # Should detect as R package
claude-ctx                            # Should find CLAUDE.md
```

---

## Code Architecture

### Project Structure

```
zsh-claude-workflow/
├── lib/                    # Core libraries (sourced by commands)
│   ├── core.sh            # Shared utilities, color functions
│   ├── project-detector.sh # Project type detection logic
│   └── claude-context.sh   # Context gathering functions
│
├── commands/               # User-facing executable scripts
│   ├── proj-type          # Detect and display project type
│   ├── proj-info          # Full project context report
│   ├── claude-ctx         # Show Claude instruction files
│   ├── claude-init        # Create CLAUDE.md from template
│   ├── claude-show        # Display CLAUDE.md content
│   └── proj-claude        # Open Claude Code with context
│
├── templates/              # Templates for CLAUDE.md and configs
│   ├── CLAUDE-rpkg.md
│   ├── CLAUDE-quarto.md
│   ├── CLAUDE-research.md
│   └── zsh_plugins.txt.recommended
│
├── config/
│   └── defaults.conf      # Default configuration
│
└── docs/                   # Documentation
    ├── README.md          # Documentation index
    ├── COMMANDS.md        # Command reference
    ├── migration/         # Antidote migration guides
    └── optimization/      # Plugin optimization guides
```

### Core Components

#### 1. Libraries (`lib/`)

**core.sh**:
- Print functions (success, error, info, warning, header)
- Git utilities (is_git_repo, get_git_root)
- File utilities (file_exists, dir_exists, find_up)
- Path utilities (get_relative_path)

**project-detector.sh**:
- Project type detection (is_r_package, is_quarto_project, etc.)
- Project metadata (get_project_name, get_project_description)
- Storage detection (get_storage_location, get_storage_tier)
- Icon/label functions for display

**claude-context.sh**:
- Find CLAUDE.md files (find_claude_files)
- Find Claude settings (find_claude_settings)
- Context summary generation (get_claude_context_summary)
- Display functions (show_claude_md, get_project_structure)
- Git context (get_git_context)
- Type-specific context (get_rpkg_context)

#### 2. Commands (`commands/`)

All commands follow this pattern:
```bash
#!/usr/bin/env zsh
# Get script directory
SCRIPT_DIR="${0:A:h}"
LIB_DIR="${SCRIPT_DIR}/../lib"

# Source libraries
source "$LIB_DIR/core.sh"
source "$LIB_DIR/project-detector.sh"
# ... other libs as needed

# Main function
main() {
    # Command implementation
}

# Run main
main "$@"
```

---

## Coding Standards

### Shell Scripting (Zsh)

- **Shebang**: `#!/usr/bin/env zsh` (not bash)
- **Error handling**: Use `set -e` cautiously; prefer explicit checks
- **Style**: Follow Oh My Zsh conventions
- **Variables**: `local` for function scope, `UPPERCASE` for constants
- **Functions**: lowercase_with_underscores

### Naming Conventions

| Type | Convention | Examples |
|------|------------|----------|
| Commands | kebab-case | `proj-type`, `claude-init` |
| Functions | snake_case | `get_project_type()`, `find_claude_files()` |
| Variables (local) | snake_case | `project_type`, `dir` |
| Variables (env) | UPPER_SNAKE_CASE | `SCRIPT_DIR`, `LIB_DIR` |
| Files (lib) | kebab-case.sh | `project-detector.sh` |

### Code Organization

```bash
# Good - organized sections
# ============================================
# SECTION NAME
# ============================================

# Function with clear purpose
function_name() {
    local param="$1"

    # Implementation
    # ...

    return 0
}

# Bad - unclear, no organization
func() { local x=$1; echo $x; }
```

### Error Handling

```bash
# Good - check return codes
if ! is_git_repo; then
    print_error "Not a git repository"
    return 1
fi

# Good - check file existence
if [[ ! -f "$file" ]]; then
    print_warning "File not found: $file"
    return 1
fi

# Good - provide helpful messages
if [[ ${#claude_files[@]} -eq 0 ]]; then
    print_warning "No CLAUDE.md found"
    print_info "Run ${fg[yellow]}claude-init${reset_color} to create one"
    return 1
fi
```

---

## Testing Strategy

### Manual Testing Workflow

Since this is a zsh scripting project, testing is primarily manual:

```bash
# 1. Test on different project types
cd ~/R-packages/active/rmediation
proj-type                    # Should detect R Package

cd ~/quarto-projects/extensions/unm-revealjs
proj-type                    # Should detect Quarto Extension

# 2. Test context gathering
claude-ctx                   # Should find CLAUDE.md files

# 3. Test template generation
cd ~/R-packages/scratch
claude-init                  # Should create CLAUDE.md

# 4. Test edge cases
cd ~/                        # Not a project
proj-type                    # Should show "unknown"

# 5. Test storage detection
cd ~/R-packages/active/rmediation
proj-type                    # Should show "local / active"

cd "/Users/dt/Library/CloudStorage/GoogleDrive-*/My Drive/R-packages-stable/missingmed"
proj-type                    # Should show "google-drive / stable"
```

### Test Coverage Areas

- ✅ Project type detection (rpkg, quarto, research, unknown)
- ✅ CLAUDE.md finding (root, .claude/, multiple files)
- ✅ Template substitution ({{PACKAGE_NAME}}, {{DATE}}, etc.)
- ✅ Storage location detection (local, google-drive, onedrive)
- ✅ Storage tier detection (active, stable, archive, scratch)
- ✅ Git integration (branch, status)
- ✅ Error handling (missing files, not in project)

### Testing Checklist

Before committing changes:
```bash
# Test all commands
proj-type ~/R-packages/active/rmediation
proj-info ~/R-packages/active/rmediation
claude-ctx ~/R-packages/active/rmediation
claude-show ~/R-packages/active/rmediation

# Test template creation
cd /tmp && mkdir test-pkg && cd test-pkg
echo "Package: testpkg" > DESCRIPTION
claude-init
cat CLAUDE.md                # Verify substitution

# Test error conditions
cd /tmp
proj-type                    # Should handle gracefully
claude-ctx                   # Should show no files found

# Clean up
rm -rf /tmp/test-pkg
```

---

## Development Workflow

### Adding a New Command

1. **Create command script**:
```bash
vim ~/code/zsh-claude-workflow/commands/new-command
```

2. **Template**:
```bash
#!/usr/bin/env zsh
# new-command - Description

SCRIPT_DIR="${0:A:h}"
LIB_DIR="${SCRIPT_DIR}/../lib"

source "$LIB_DIR/core.sh"
source "$LIB_DIR/project-detector.sh"

main() {
    local dir="${1:-$PWD}"

    # Implementation
    print_header "New Command"
    # ...
}

main "$@"
```

3. **Make executable**:
```bash
chmod +x ~/code/zsh-claude-workflow/commands/new-command
```

4. **Test**:
```bash
./commands/new-command
```

5. **Document**:
- Add to `docs/COMMANDS.md`
- Update `README.md` if user-facing

### Adding a New Library Function

1. **Choose appropriate library**:
- `core.sh` - Utilities, printing, file operations
- `project-detector.sh` - Project type detection
- `claude-context.sh` - Context gathering

2. **Add function**:
```bash
# In lib/project-detector.sh

# Detect if current directory is a Python project
is_python_project() {
    local dir="${1:-$PWD}"
    [[ -f "$dir/setup.py" ]] || [[ -f "$dir/pyproject.toml" ]]
}
```

3. **Update dependent code**:
```bash
# In get_project_type()
if is_python_project "$dir"; then
    echo "python"
elif is_r_package "$dir"; then
    # ...
```

4. **Test thoroughly**

### Adding a New Template

1. **Create template file**:
```bash
vim ~/code/zsh-claude-workflow/templates/CLAUDE-python.md
```

2. **Use placeholders**:
- `{{PROJECT_NAME}}` - Project name
- `{{PROJECT_DESCRIPTION}}` - Description
- `{{DATE}}` - Current date

3. **Update `claude-init` command**:
```bash
# In commands/claude-init
case "$project_type" in
    rpkg)
        template="$TEMPLATE_DIR/CLAUDE-rpkg.md"
        ;;
    python)
        template="$TEMPLATE_DIR/CLAUDE-python.md"
        ;;
    # ...
esac
```

### Documentation Updates

When adding features:
1. Update `README.md` (if user-facing)
2. Update `docs/COMMANDS.md` (command reference)
3. Update `QUICKSTART.md` (if major feature)
4. Keep this `CLAUDE.md` current

---

## Integration Points

### With User's .zshrc

The installation adds to `~/.zshrc`:
```bash
# Add commands to PATH
export PATH="$HOME/code/zsh-claude-workflow/commands:$PATH"

# Aliases
alias ptype='proj-type'
alias pinfo='proj-info'
alias cctx='claude-ctx'
alias cinit='claude-init'
alias cshow='claude-show'
alias pclaude='proj-claude'
```

### With Antidote Plugin Manager

The project includes:
- Template: `templates/zsh_plugins.txt.recommended`
- Docs: `docs/migration/ANTIDOTE_MIGRATION.md`
- User's active config: `~/.zsh_plugins.txt`

### With User's Existing Workflow

Integrates with:
- R package development (rpkg, rdev, rpkgcommit)
- Quarto projects (qp, qr, qc)
- Git workflows (gst, ga, gcmsg)
- Modern CLI tools (bat, eza, fd, rg)

---

## File Organization

### Generated Files

These files are created by the system:
- `~/.zsh_plugins.zsh` - Generated by antidote (don't edit)
- `~/.zcompdump*` - Completion cache (auto-generated)

### User-Modified Files

These files are meant to be edited by users:
- `~/.zshrc` - Shell configuration
- `~/.zsh_plugins.txt` - Plugin list
- `~/.p10k.zsh` - Powerlevel10k theme
- `~/code/zsh-claude-workflow/config/defaults.conf` - Project config

### Project CLAUDE.md Files

Created by `claude-init`:
- `~/R-packages/active/*/CLAUDE.md`
- `~/quarto-projects/*/CLAUDE.md`
- Any project with `claude-init`

---

## Common Tasks

### Update Project Detection

To add a new project type:

1. **Add detection function** (`lib/project-detector.sh`):
```bash
is_new_type() {
    local dir="${1:-$PWD}"
    [[ -f "$dir/marker-file" ]]
}
```

2. **Update get_project_type**:
```bash
get_project_type() {
    # ...
    elif is_new_type "$dir"; then
        echo "newtype"
    # ...
}
```

3. **Add icon and label**:
```bash
get_project_icon() {
    case "$1" in
        newtype) echo "🎯" ;;
        # ...
    esac
}

get_project_type_label() {
    case "$1" in
        newtype) echo "New Type Project" ;;
        # ...
    esac
}
```

### Update Template Substitution

In `commands/claude-init`:
```bash
# Add new substitution
content="${content//\{\{NEW_VAR\}\}/$new_value}"
```

### Add Storage Provider

In `lib/project-detector.sh`:
```bash
get_storage_location() {
    local dir="${1:-$PWD}"
    case "$dir" in
        *"NewCloud"*)
            echo "newcloud"
            ;;
        # ...
    esac
}
```

---

## Troubleshooting

### Common Issues

**Commands not found after install**:
```bash
# Check PATH
echo $PATH | grep zsh-claude-workflow

# Re-source
source ~/.zshrc

# Verify installation
which proj-type
```

**Project type not detected**:
```bash
# Debug mode
cd problematic-project
./commands/proj-type .

# Check detection logic
cat lib/project-detector.sh | grep "is_*"
```

**Template substitution not working**:
```bash
# Check placeholders in template
grep "{{" templates/CLAUDE-rpkg.md

# Check substitution in claude-init
grep "content=" commands/claude-init
```

---

## Dependencies

### Required
- **zsh** (5.0+) - Shell
- **git** - Version control
- **antidote** - Plugin manager (via homebrew)

### Optional (Enhanced Features)
- **bat** - Syntax highlighting for file display
- **tree** - Directory tree display
- **eza** - Modern ls replacement
- **fzf** - Fuzzy finding

### Homebrew Packages
```bash
brew install antidote      # Required
brew install bat tree fzf  # Recommended
brew install eza fd        # Optional
```

---

## Color Scheme

Uses zsh colors for consistent output:

```bash
${fg[green]}  # Success messages
${fg[red]}    # Error messages
${fg[blue]}   # Info messages
${fg[yellow]} # Warnings, highlights
${fg[cyan]}   # Headers, sections
${reset_color} # Reset to default
```

Example:
```bash
print_success "✓ Success message"
print_error "✗ Error message"
print_info "ℹ Info message"
print_warning "⚠ Warning message"
print_header "Section Header"
```

---

## Version History

### v1.0 (2025-12-07)
- ✅ Project detection system
- ✅ Claude context gathering
- ✅ Template system (R pkg, Quarto, Research)
- ✅ Antidote migration and optimization
- ✅ Comprehensive documentation
- ✅ 6 commands, 3 libraries, 4 templates

### Planned Features
- Multi-storage navigator
- Ecosystem manager for package suites
- Session management

---

## Best Practices for Contributors

### Code Style
1. Use zsh-specific features (arrays, parameter expansion)
2. Provide helpful error messages
3. Use color coding consistently
4. Handle edge cases gracefully
5. Comment complex logic

### Documentation
1. Update CLAUDE.md when changing architecture
2. Update docs/COMMANDS.md for command changes
3. Update README.md for user-facing changes
4. Keep examples current

### Testing
1. Test on multiple project types
2. Test edge cases (no git, no CLAUDE.md, etc.)
3. Test storage detection
4. Verify error messages are helpful

---

## Related Projects

This project integrates with:
- **User's R package workflow** (~/R-packages/active/*)
- **Quarto projects** (~/quarto-projects/*)
- **Claude Code** (claude-code CLI)
- **Antidote** (plugin manager)
- **Oh My Zsh** (plugin ecosystem)

---

## Quick Reference

### Most Used Files

```bash
# Core logic
lib/project-detector.sh    # Project type detection
lib/claude-context.sh      # Context gathering

# Main commands
commands/proj-type         # Most used - show project type
commands/claude-ctx        # Show Claude context
commands/claude-init       # Create CLAUDE.md

# Templates
templates/CLAUDE-rpkg.md   # R package template
templates/zsh_plugins.txt.recommended  # Plugin template

# Documentation
docs/README.md             # Documentation index
docs/COMMANDS.md           # Command reference
```

### Quick Commands

```bash
# Development
./install.sh                           # Install/update
./commands/proj-type .                 # Test detection
bat lib/project-detector.sh            # View detection logic

# Documentation
bat docs/README.md                     # Browse docs
tree ~/code/zsh-claude-workflow        # View structure

# Testing
cd ~/R-packages/active/rmediation && proj-type
cd ~/quarto-projects/*/  && claude-ctx
```

---

**Last Updated**: 2025-12-07
**Project Status**: Production Ready
**Documentation**: Complete

---

This CLAUDE.md is maintained as part of the zsh-claude-workflow project and should be updated when making significant changes to the codebase or architecture.
