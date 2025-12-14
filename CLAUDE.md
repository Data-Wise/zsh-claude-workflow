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
| **Workflow System** 🆕 | YAML-based workflows with command dispatcher | ✅ v1.3 |
| **Skill Management** 🆕 | Activate/manage Claude skills per project | ✅ v1.3 |
| **R Package Setup** 🆕 | One-command R package initialization | ✅ v1.3 |
| **claude-r-dev Bridge** 🆕 | Integration with claude-r-dev profiles | ✅ v1.3 |
| **CLI Tool Aliases** 🆕 | 55+ aliases for Claude Code & Gemini CLI | ✅ v1.3 |
| **Documentation Site** | MkDocs with Material theme + GitHub Pages | ✅ Complete |
| **GitHub Integration** | Issue/PR templates, workflows, metadata | ✅ Complete |
| **Project Tracking** 🆕 | Roadmap progress with `plan-status` command | ✅ v1.4.1 |
| **Workspace Audit** 🆕 | git-audit, file-audit, activity-heat, morning-audit | ✅ v1.5.0 |

---

## Common Development Commands

```bash
# Test commands
cd ~/projects/dev-tools/zsh-claude-workflow
./commands/proj-type .                # Test project detection
./commands/claude-ctx .               # Test context gathering

# NEW v1.3: Workflow and skill commands
./commands/workflow-run list          # List available workflows
./commands/workflow-run dev           # Run development workflow
./commands/skill-activate available   # List available skills
./commands/rpkg-setup test-pkg --type standard  # Test R package setup

# Install/update
./install.sh                          # Install or update

# NEW v1.4.1: Project tracking
./commands/plan-status                # Overall roadmap
./commands/plan-status v1.5           # v1.5 progress
./commands/plan-status --gantt        # Visual timeline
./commands/plan-status --update v1.5 pj-index in_progress  # Update status

# NEW v1.5.0: Workspace audit commands
./commands/git-audit                  # Find dirty/unpushed repos
./commands/git-audit -q               # Quick summary only
./commands/file-audit                 # Find large files (>50MB)
./commands/activity-heat -n 5         # Top 5 active projects
./commands/morning-audit              # Full daily health check
./commands/morning-audit -o           # Generate and open report

# Documentation
mkdocs serve                          # Preview docs locally (http://127.0.0.1:8000)
mkdocs build                          # Build static site
mkdocs gh-deploy                      # Manual deploy to GitHub Pages

# Test in actual use
cd ~/R-packages/active/rmediation
proj-type                             # Should detect as R package
claude-ctx                            # Should find CLAUDE.md
workflow-run list                     # 🆕 List available workflows
skill-activate list                   # 🆕 Show active skills
proj-claude                           # 🆕 Enhanced with auto-activation
```

---

## Code Architecture

### Project Structure

```
zsh-claude-workflow/
├── lib/                    # Core libraries (sourced by commands)
│   ├── core.sh            # Shared utilities, color functions
│   ├── project-detector.sh # Project type detection logic
│   ├── claude-context.sh   # Context gathering functions
│   ├── workflow-dispatcher.sh 🆕  # Universal workflow dispatcher
│   ├── rpkg-integration.sh 🆕     # R package workflow integration
│   ├── skill-manager.sh 🆕        # Claude skill management
│   └── claude-r-dev-bridge.sh 🆕  # claude-r-dev integration
│
├── commands/               # User-facing executable scripts
│   ├── proj-type          # Detect and display project type
│   ├── proj-info          # Full project context report
│   ├── claude-ctx         # Show Claude instruction files
│   ├── claude-init        # Create CLAUDE.md from template
│   ├── claude-show        # Display CLAUDE.md content
│   ├── proj-claude        # 🆕 Enhanced: Open Claude Code with context
│   ├── workflow-run 🆕    # Universal workflow dispatcher
│   ├── rpkg-setup 🆕      # Smart R package initialization
│   ├── skill-activate 🆕  # Manage Claude skills
│   ├── git-audit 🆕       # Find dirty/unpushed repos
│   ├── file-audit 🆕      # Find large files needing cleanup
│   ├── activity-heat 🆕   # Activity heatmap (last 7 days)
│   └── morning-audit 🆕   # Daily workspace health check
│
├── workflows/ 🆕          # YAML workflow definitions
│   ├── rpkg/              # R package workflows
│   │   ├── dev.yml       # Development cycle
│   │   ├── test.yml      # Testing workflow
│   │   └── pre-commit.yml # Pre-commit checks
│   └── quarto/            # Quarto workflows
│       ├── preview.yml   # Preview workflow
│       └── render.yml    # Render workflow
│
├── skills/ 🆕             # Claude skill templates
│   └── templates/
│       ├── r-package-skill.md
│       └── quarto-skill.md
│
├── plans/ 🆕              # Future feature brainstorms
│   └── file-project-management-optimization.md
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
├── docs/                   # MkDocs documentation site
│   ├── index.md           # Landing page
│   ├── getting-started/   # Installation and quick start
│   │   ├── installation.md
│   │   └── quickstart.md
│   ├── commands/          # Command documentation
│   │   ├── overview.md
│   │   └── reference.md
│   ├── guide/             # User guides
│   │   ├── project-types.md
│   │   ├── templates.md
│   │   └── context-management.md
│   ├── migration/         # Migration guides
│   │   └── antidote.md
│   ├── optimization/      # Optimization guides
│   │   └── plugins.md
│   └── development/       # Developer documentation
│       ├── contributing.md
│       ├── architecture.md
│       └── testing.md
│
├── .github/               # GitHub configuration
│   ├── workflows/
│   │   └── docs.yml       # Auto-deploy docs to GitHub Pages
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── FUNDING.yml
│
├── mkdocs.yml             # MkDocs configuration
├── requirements.txt       # Python dependencies (MkDocs)
├── .gitignore            # Git ignore rules
├── LICENSE               # MIT license
├── CONTRIBUTING.md       # Contributing guide
├── README.md             # Project readme with badges
└── install.sh            # Installation script
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

### Branch Strategy

We use a two-branch workflow to maintain stability:

**Branches**:
- `main` - Production branch (protected)
  - Always stable and deployable
  - Auto-deploys to GitHub Pages
  - Only accepts PRs from `dev` branch

- `dev` - Development branch (default)
  - Active development happens here
  - Feature branches merge here first
  - Gets merged to `main` when stable

- `feature/*` - Feature branches (optional)
  - For larger features: `feature/new-command`
  - Branch from `dev`, merge back to `dev`

**Workflow**:
```bash
# Start new work
git checkout dev
git pull origin dev
git checkout -b feature/my-feature

# Make changes, test, commit
# ...

# Push and create PR to dev
git push origin feature/my-feature
# Create PR targeting 'dev' branch

# After PR is merged to dev and tested
# Maintainer merges dev -> main for release
```

**Important**:
- Always create PRs targeting `dev` (not `main`)
- `main` branch is protected and only for releases
- GitHub Pages deployment happens from `main`

### Adding a New Command

1. **Create command script**:
```bash
vim ~/projects/dev-tools/zsh-claude-workflow/commands/new-command
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
chmod +x ~/projects/dev-tools/zsh-claude-workflow/commands/new-command
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
vim ~/projects/dev-tools/zsh-claude-workflow/templates/CLAUDE-python.md
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
2. Update `docs/commands/reference.md` (command reference)
3. Update `docs/getting-started/quickstart.md` (if major feature)
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

### With CLI Tool Aliases 🆕

**Location**: `~/.config/zsh/.zshrc`

Comprehensive aliases for AI-powered CLI tools:

**Claude Code CLI (34 shortcuts)**:
```bash
# Basic: cc, ccp, ccc, ccr, ccl
# Models: ccs (sonnet), cco (opus), cch (haiku)
# Permissions: ccplan, ccauto, ccyolo
# R-specific: ccrdoc, ccrtest, ccrfix, ccrstyle, etc.
# Functions: ccask, ccfile, ccrdiff, ccrpkg
```

**Gemini CLI (15 shortcuts)**:
```bash
# Basic: gm, gmi, gmpi
# Power: gmy (yolo), gms (sandbox), gmd (debug), gmr (resume)
# Web search: gmw, gmws (functions)
# Management: gmm (mcp), gme (extensions)
```

**Integration Examples**:
```bash
# R package development with Claude
rload && ccrtest            # Load package, generate tests
rcheck && ccrfix            # Check package, fix issues
ccrdiff                     # Review changes before commit

# Web research with Gemini
gmw "latest R best practices 2025"
gmws "CRAN submission checklist"
```

**Reference Guides**:
- `~/claude-cli-aliases-reference.md` - Complete Claude CLI reference
- `~/gemini-aliases-reference.md` - Complete Gemini CLI reference
- `docs/guide/cli-aliases.md` - Documentation site guide

**Total**: 55+ productivity shortcuts for AI-powered development

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
- `~/projects/dev-tools/zsh-claude-workflow/config/defaults.conf` - Project config

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

### v1.4.2 (2025-12-11) - Current Development
- ✅ **R Package Recovery**
  - ALL 6 packages located in Google Drive Trash
  - Packages: medfit, probmed, rmediation, medrobust, medsim, mediationverse
  - Recovery in progress (handed off to Claude Desktop)
  - See: plans/R_PACKAGE_RECOVERY_PLAN.md
- ✅ **File System Audit Complete**
  - Comprehensive audit of research, teaching, R packages, Obsidian
  - Research scattered across 4 locations (925 MB)
  - Teaching duplicated across 3 clouds (6.2 GB)
  - Home directory clean (excellent!)
  - See: plans/FILE_SYSTEM_AUDIT_2025-12-11.md
- ✅ **Research Management Command** (uncommitted)
  - New command: `research` with dashboard, status, list, work, migrate
  - New library: lib/research-manager.sh (510 lines)
  - Multi-location project detection (Dropbox, Google Drive, OneDrive, local)
  - ADHD-optimized with "top 3 active" focus
  - Ready to commit after recovery complete
- ✅ **Claude Desktop Delegation Strategy**
  - Comprehensive strategy for delegating file operations to Desktop
  - Full handoff plan with templates
  - See: plans/CLAUDE_DESKTOP_DELEGATION_STRATEGY.md
- 📦 Shell Commands: 11 total (1 new: research - uncommitted)
- 📦 Libraries: 8 total (1 new: research-manager.sh - uncommitted)
- 📦 Planning Docs: 27 total (4 new)

### v1.4.1 (2025-12-09)
- ✅ **Comprehensive Documentation Examples**
  - Added complete examples to all 5 command categories
  - research/: sim-design, analysis-plan examples
  - teach/: exam example with examark format
  - math/: proof, derive, notation, example demonstrations
  - code/: rpkg-check, debug, test-gen examples
  - write/: abstract, cover-letter, edit examples
  - Total: +1,045 lines of documentation
- ✅ **Project Tracking System**
  - New `commands/plan-status` - view/update roadmap progress
  - New `plans/ROADMAP.md` - comprehensive project roadmap
  - New `plans/tracking/*.yml` - YAML-based progress tracking
  - Features: progress bars, Gantt chart, milestone tracking
  - Use: `plan-status`, `plan-status v1.5`, `plan-status --gantt`
- ✅ **Lean Scope Planning**
  - v1.5 reduced: 10→6 high-value features
  - v1.6 reduced: 7→4 high-value features
  - v1.7 marked as optional/deferred
- 📦 Shell Commands: 11 total (1 new: plan-status)
- 📦 Release: https://github.com/Data-Wise/zsh-claude-workflow/releases/tag/v1.4.1

### v1.4 (2025-12-09)
- ✅ **Claude Commands Redesign Complete**
  - 5-category hybrid structure: research/, teach/, math/, code/, write/
  - 17 commands implemented (9 migrated + 8 new)
  - Directory `claude-commands/` created as source of truth
  - Integration bridges in `integrations/`
- ✅ **docs-check Shell Command**
  - New `commands/docs-check` - comprehensive documentation validator
  - New `lib/docs-validator.sh` - validation library
  - New `config/docs-check.conf` - configuration
  - New `scripts/extract-links.awk` - link extraction helper
  - Features: version sync, badge validation, link checking, build testing
  - Supports: MkDocs, pkgdown, Quarto, npm projects
- 📦 Shell Commands: 10 total (1 new), Libraries: 8 total (1 new)
- 📦 Claude Slash Commands: 34 total in `claude-commands/` directory (ALL COMPLETE)

### v1.3 (2025-12-07)
- ✅ **Phase 1 Foundation: Workflow Integration System**
- ✅ Created 4 new libraries:
  - `workflow-dispatcher.sh` - Universal workflow dispatch with YAML support
  - `rpkg-integration.sh` - R package workflow integration
  - `skill-manager.sh` - Claude skill management (symlink-based)
  - `claude-r-dev-bridge.sh` - Integration with claude-r-dev project
- ✅ Created 3 new commands:
  - `workflow-run` - Universal workflow dispatcher
  - `rpkg-setup` - Smart R package initialization with claude-r-dev
  - `skill-activate` - Manage Claude skills for projects
- ✅ Enhanced `proj-claude` command:
  - Auto-activation of recommended skills
  - Integration with claude-r-dev
  - Workflow suggestions
  - Better context detection
- ✅ Created workflow system:
  - YAML-based workflow definitions
  - R package workflows (dev, test, pre-commit)
  - Quarto workflows (preview, render)
  - Project-level workflow overrides supported
- ✅ Created skill templates:
  - R package skill template
  - Quarto project skill template
  - Symlink-based activation for easy management
- ✅ Full integration with existing .zshrc functions (rdev, rpkg, qwork, etc.)
- ✅ **CLI Tool Aliases (2025-12-08)**:
  - 34 Claude Code CLI aliases and functions (cc, ccp, ccrpkg, ccrdiff, etc.)
  - 15 Gemini CLI aliases and functions (gm, gmw, gmws, gmy, etc.)
  - R-specific workflows (ccrdoc, ccrtest, ccrfix, ccrstyle)
  - Smart functions with context awareness (ccrpkg, ccrdiff)
  - Complete reference guides (~/claude-cli-aliases-reference.md, ~/gemini-aliases-reference.md)
  - Documentation guide (docs/guide/cli-aliases.md)
  - Total: 55+ productivity shortcuts for AI-powered development
- 🎯 **New Capabilities:**
  - `workflow-run dev` - Run development workflow for any project type
  - `rpkg-setup mypackage --type statistical` - One-command R package setup
  - `skill-activate auto` - Auto-activate recommended skills
  - Enhanced `proj-claude` with guided setup
- 📦 Commands: 9 total (3 new), Libraries: 7 total (4 new)
- 📋 **Future Roadmap:** Created comprehensive brainstorm for v1.4-v1.6 features
  - See `plans/file-project-management-optimization.md` for detailed planning
  - 21 new command ideas spanning smart navigation, multi-project ops, and productivity
  - 11 new library modules, 3-phase implementation plan

### v1.2 (2025-12-07)
- ✅ Established dev branch workflow for development
- ✅ Documentation cleanup: removed 5 duplicate files (-1,661 lines)
- ✅ Fixed all broken links in documentation
- ✅ Added historical reference section with disclaimers
- ✅ Branch protection guide for GitHub settings
- ✅ Enhanced CONTRIBUTING.md with branch strategy
- ✅ Updated PR template with dev branch reminders
- ✅ Clean documentation build (0.67s, only 1 expected warning)
- ✅ Project file organization optimized
- ✅ GitHub Release created with comprehensive release notes
- 📦 Release URL: https://github.com/Data-Wise/zsh-claude-workflow/releases/tag/v1.2

### v1.1 (2025-12-07)
- ✅ MkDocs documentation site with Material theme
- ✅ GitHub Pages auto-deployment via GitHub Actions
- ✅ Enhanced README with badges and documentation links
- ✅ GitHub repository templates (issues, PRs)
- ✅ MIT License and .gitignore
- ✅ Contributing guide and funding configuration
- ✅ Fixed proj-claude command to detect Claude CLI correctly

### v1.0 (2025-12-07)
- ✅ Project detection system
- ✅ Claude context gathering
- ✅ Template system (R pkg, Quarto, Research)
- ✅ Antidote migration and optimization
- ✅ Comprehensive documentation
- ✅ 6 commands, 3 libraries, 4 templates

### Planned Features

📋 **Comprehensive Roadmap:** See planning documents in `plans/`

**v1.4 - Claude Commands Redesign (COMPLETED 2025-12-09)**

✅ **Claude Commands Coordination** - DONE:
- See `plans/claude-commands-redesign.md` for full specification
- 5-category hybrid structure: research/, teach/, math/, code/, write/
- 17 commands implemented (see `claude-commands/` directory)
- Multi-project coordination with MCP server and examark
- zsh-claude-workflow is now source of truth for commands
- New directories: `claude-commands/`, `integrations/`, `scripts/`

**Implemented Commands (34 total - ALL COMPLETE):**
| Category | Count | Commands |
|----------|-------|----------|
| research/ | 8 | cite, lit-gap, manuscript, revision, sim-design, method-scout, hypothesis, analysis-plan |
| teach/ | 9 | exam, rubric, lecture, homework, solution, quiz, syllabus, feedback, canvas |
| math/ | 4 | proof, derive, notation, example |
| code/ | 8 | docs-check, ecosystem-health, rpkg-check, release, debug, refactor, test-gen, demo |
| write/ | 5 | abstract, cover-letter, draft, response, edit |

**v1.5 - Multi-Project Operations (Lean Scope - 6 features)**
Target: 2026-01 | Effort: ~6 days
- `pj-index` - Project indexing system
- `pj-status` - Dashboard showing all projects at once
- `pj-run` - Bulk operations across projects
- `pj-search` - Global code search
- `branch-sync` - Sync dev↔main branches
- `pj` - Quick jump to project

**v1.6 - Workflow Automation (Lean Scope - 4 features)**
Target: 2026-02 | Effort: ~5.5 days
- `session` - Save/restore session state for Claude continuity
- `pr-cycle` - PR creation to merge automation
- `release-create` - Full release workflow
- `plan-status` - ✅ Done (progress tracking)

**v1.7 - Advanced Features (Optional/Deferred)**
- Review after v1.6, implement only if clear need
- Most features duplicate existing tools

**Tracking:** Use `plan-status` command or see `plans/ROADMAP.md`

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
- **claude-statistical-research-mcp** (v0.7.0) - MCP server with 16 tools + 17 skills
  - R tools: r_execute, r_session, r_inspect, r_test, r_check, r_plot, r_preview, r_document, r_coverage
  - Literature: arxiv_search, crossref_lookup, bibtex, zotero, lit_note_create
  - Skills: 17 A-grade skills in mathematical/, implementation/, writing/, research/
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
commands/proj-claude       # Open Claude Code

# Templates
templates/CLAUDE-rpkg.md   # R package template
templates/zsh_plugins.txt.recommended  # Plugin template

# Documentation (MkDocs)
mkdocs.yml                 # MkDocs configuration
docs/index.md              # Documentation landing page
docs/getting-started/      # Installation and quick start
docs/commands/reference.md # Command reference
docs/guide/                # User guides (types, templates, context)
docs/development/          # Contributing and architecture

# GitHub Configuration
.github/workflows/docs.yml # Auto-deploy documentation
README.md                  # Project readme with badges
```

### Quick Commands

```bash
# Development
./install.sh                           # Install/update
./commands/proj-type .                 # Test detection
bat lib/project-detector.sh            # View detection logic

# Documentation
mkdocs serve                           # Preview docs locally
mkdocs build                           # Build documentation site
bat docs/index.md                      # View landing page
tree ~/projects/dev-tools/zsh-claude-workflow        # View structure

# Testing
cd ~/R-packages/active/rmediation && proj-type
cd ~/quarto-projects/*/  && claude-ctx
```

---

## Documentation Site

### MkDocs Configuration

The project uses **Material for MkDocs** for documentation:

**Configuration File:** `mkdocs.yml`
- Material theme with dark/light mode
- Navigation with tabs and sections
- Search functionality
- Code highlighting with copy buttons
- Responsive design

**Local Development:**
```bash
# Install dependencies
pip install -r requirements.txt

# Preview locally
mkdocs serve
# Opens at http://127.0.0.1:8000

# Build static site
mkdocs build
# Outputs to site/ directory
```

### GitHub Pages Deployment

**Automatic Deployment:**
- Workflow: `.github/workflows/docs.yml`
- Triggers on push to `main` branch
- Builds and deploys to GitHub Pages automatically
- Live site: https://data-wise.github.io/zsh-claude-workflow/

**Manual Deployment:**
```bash
mkdocs gh-deploy
```

### GitHub Releases

**Creating Releases:**
```bash
# Create a new release
env -u GITHUB_TOKEN gh release create v1.x \
  --title "v1.x - Release Title" \
  --notes "Release notes here" \
  --target main
```

**When to Release:**
- Major feature additions
- Breaking changes
- Version milestones (v1.0, v2.0, etc.)

**Release History:**
- v1.2 (2025-12-07) - Dev Workflow & Documentation Cleanup
- v1.1 (2025-12-07) - Documentation Site & GitHub Integration
- v1.0 (2025-12-07) - Initial Release

**View Releases:** https://github.com/Data-Wise/zsh-claude-workflow/releases

### Documentation Structure

The documentation is organized into:
- **Getting Started** - Installation and quick start
- **Commands** - Command overview and reference
- **User Guide** - Project types, templates, context management
- **Migration** - Antidote migration guide
- **Optimization** - Plugin optimization
- **Development** - Contributing, architecture, testing, branch protection
- **Reference** - Historical documentation (with disclaimers)

---

**Last Updated**: 2025-12-14
**Current Version**: v1.5.0 (ADHD Ecosystem Proposal)
**Project Status**: Production Ready + Restructure Proposed
**Documentation**: Complete (Web + MkDocs)
**Live Docs**: https://data-wise.github.io/zsh-claude-workflow/
**Branch Workflow**: dev (development) → main (production)
**Releases**: https://github.com/Data-Wise/zsh-claude-workflow/releases

---

This CLAUDE.md is maintained as part of the zsh-claude-workflow project and should be updated when making significant changes to the codebase or architecture.


---

## ZDOTDIR Setup (2025 Optimization)

**IMPORTANT:** As of v1.3+, this project recommends using ZDOTDIR for optimal zsh configuration.

### What Changed

**Traditional Setup:**
```
~/
├── .zshrc
├── .zsh_plugins.txt
├── .p10k.zsh
└── [10+ other zsh dotfiles]
```

**ZDOTDIR Setup (Recommended):**
```
~/
├── .zshenv                 # ONLY zsh file in home
└── .config/zsh/            # ALL zsh configuration (ZDOTDIR)
    ├── .zshrc
    ├── .zsh_plugins.txt
    ├── .p10k.zsh
    ├── conf.d/             # Modular configs
    ├── functions/          # Lazy-loaded functions
    └── completions/        # Custom completions
```

### Benefits

- ✅ Clean home directory (92% fewer zsh files)
- ✅ XDG-compliant modern configuration
- ✅ Better organization
- ✅ Easier backups and management
- ✅ 40-50% faster shell startup

### Quick Setup

See **[ZDOTDIR Optimization Guide](docs/optimization/zdotdir-setup.md)** for complete setup instructions.

### Key Points

1. **use-omz + lib** is the recommended OMZ integration:
   ```bash
   getantidote/use-omz              # First!
   ohmyzsh/ohmyzsh path:lib         # Second!
   ```

2. **Homebrew must initialize before antidote** - Add to `~/.zshenv`

3. **Don't manually run compinit** - use-omz handles it

4. **Update command changed**:
   - OLD: `omz update`
   - NEW: `antidote update`

See full documentation in [docs/optimization/](docs/optimization/) for details.

---

## ADHD-Friendly Ecosystem Restructure (v6 Proposal)

**Proposal Date:** 2025-12-14
**Proposal File:** `plans/ADHD-COMMANDS-SKILLS-PROPOSAL-2025-12-14.md`
**Status:** ✅ Implemented (Phases 1-4 Complete)

### The Problem

Two domains exist but three projects create overlap:

| Domain | Current State | Problem |
|--------|---------------|---------|
| ZSH (Shell) | zsh-configuration ✅ | Good |
| ZSH (Shell) | zsh-claude-workflow ⚠️ | Duplicate |
| Claude Code | ~/.claude/ ✅ | Good |
| Claude Code | zsh-claude-workflow ⚠️ | Mixed in |

### Target State: Two Projects

```
ZSH DOMAIN (zsh-configuration)     CLAUDE DOMAIN (~/.claude/)
─────────────────────────────────  ─────────────────────────────
• 144+ shell aliases               • 53 slash commands (8 categories)
• 22-26 workflow functions         • 37 skills (organized)
• ADHD helpers (js, why, win)      • settings.json (MCP, permissions)
• Audit commands                   • statusline-p10k.sh
• .STATUS system                   • Project detection (native)
```

### Proposed Command Inventory (53 total)

| Category | Count | Commands |
|----------|-------|----------|
| 💻 `code/` | 12 | project-check, test-run, test-generate, test-coverage, lint-check, lint-fix, release-prep, deps-check, deps-audit, debug-trace, refactor-clean, demo-create |
| 📖 `site/` | 5 | site-init, site-build, site-preview, site-deploy, site-check |
| 🐙 `github/` | 4 | gh-pages, gh-actions, gh-release, ci-status |
| 🧠 `workflow/` | 6 | recap, next, focus, done, brain-dump, stuck |
| 🧮 `math/` | 4 | derive, example, notation, proof |
| 🔬 `research/` | 8 | analysis-plan, cite, hypothesis, lit-gap, manuscript, method-scout, revision, sim-design |
| 📚 `teach/` | 9 | canvas, exam, feedback, homework, lecture, quiz, rubric, solution, syllabus |
| ✍️ `write/` | 5 | abstract, cover-letter, draft, edit, response |

### Key Features

**1. Context-Aware Commands**
Commands detect project type (DESCRIPTION→R, pyproject.toml→Python, package.json→Node) and adapt behavior.

**2. ADHD Workflow Loop**
```
/recap ──► /next ──► /focus ──► /done
  ↑                               │
  └───────────────────────────────┘
```

**3. .STATUS Coordination**
Claude commands enhance existing shell functions:
- `here()` → `/recap` (adds git history, PR status)
- `next()` → `/next` (adds AI prioritization)
- `endwork()` → `/done` (adds guided prompts)

**4. Skill Categories (Proposed)**
```
~/.claude/skills/
├── documents/     # pdf, docx, xlsx, pptx (Anthropic official)
├── statistical/   # mathematical/, implementation/, research/, writing/
├── teaching/      # exam generators, workflows
├── development/   # r-package, emacs, zsh
└── meta/          # workflows, documentation
```

### Implementation Phases

| Phase | Description | Effort | Priority |
|-------|-------------|--------|----------|
| 1 | Cleanup (delete backup, create archive) | 30 min | ✅ REQUIRED |
| 2 | Add Anthropic document skills | 15 min | ✅ REQUIRED |
| 3 | Migrate Google Drive skills | 15 min | ✅ REQUIRED |
| 4 | Create /hub discovery command | 1-2 hours | ⭐ RECOMMENDED |
| 5 | Retire zsh-claude-workflow | ~1 hour | OPTIONAL |
| 6 | Migrate to zsh-configuration | ~1 hour | OPTIONAL |

### Key Insight

The main improvements needed are:
1. **Discoverability** via `/hub` command
2. **Organization** via skill categories
3. **Context-awareness** via project detection

See full proposal: `plans/ADHD-COMMANDS-SKILLS-PROPOSAL-2025-12-14.md`


