# Command Reference

Complete reference for all zsh-claude-workflow commands.

---

## Project Detection

### `proj-type`

Detect and display the current project type.

**Usage:**
```bash
proj-type [directory]
```

**Output:**
- Project name
- Project type (R Package, Quarto, Research, etc.)
- Storage location (local, google-drive, etc.)
- Storage tier (active, stable, archive, etc.)
- Claude instruction status
- Git status

**Examples:**
```bash
# Check current directory
proj-type

# Check specific directory
proj-type ~/R-packages/active/rmediation
```

---

### `proj-info`

Display comprehensive project information with context.

**Usage:**
```bash
proj-info [directory]
```

**Output:**
- Full project context
- Claude instruction files
- Git status and branch info
- Type-specific information (R package stats, etc.)
- Project structure tree

**Examples:**
```bash
# Show info for current project
proj-info

# Show info for specific project
proj-info ~/quarto-projects/extensions/unm-revealjs
```

---

## Claude Context Management

### `claude-ctx`

Gather and display all Claude context files in the current project.

**Usage:**
```bash
claude-ctx [directory]
```

**Output:**
- List of CLAUDE.md files
- Claude settings files
- Content of primary CLAUDE.md

**Examples:**
```bash
# Show Claude context for current project
claude-ctx

# Show for specific project
claude-ctx ~/R-packages/active/medfit
```

---

### `claude-init`

Create a new CLAUDE.md file from template based on project type.

**Usage:**
```bash
claude-init [directory]
```

**Behavior:**
- Auto-detects project type
- Selects appropriate template
- Fills in project name and description
- Creates CLAUDE.md in project root

**Supported project types:**
- R Package → Uses `CLAUDE-rpkg.md` template
- Quarto Project → Uses `CLAUDE-quarto.md` template
- Research Project → Uses `CLAUDE-research.md` template

**Examples:**
```bash
# Create CLAUDE.md in current directory
claude-init

# Create for specific project
claude-init ~/R-packages/active/probmed
```

---

### `claude-show`

Display the content of CLAUDE.md for the current project.

**Usage:**
```bash
claude-show [directory]
```

**Behavior:**
- Finds primary CLAUDE.md file
- Uses bat for syntax highlighting (if available)
- Falls back to cat if bat not installed

**Priority:**
1. `CLAUDE.md` in project root
2. `.claude/CLAUDE.md`
3. First CLAUDE*.md file found

**Examples:**
```bash
# Show CLAUDE.md
claude-show

# Show for specific project
claude-show ~/R-packages/active/rmediation
```

---

### `proj-claude`

Open Claude Code with automatic project context.

**Usage:**
```bash
proj-claude [directory]
```

**Behavior:**
- Checks for CLAUDE.md (warns if missing)
- Shows context summary
- Opens Claude Code in chat mode

**Examples:**
```bash
# Open Claude Code for current project
proj-claude

# Open for specific project
cd ~/R-packages/active/mediationverse
proj-claude
```

---

## Workflow & Skills Management (v1.3)

### `workflow-run`

Universal workflow dispatcher for running automated workflows.

**Usage:**
```bash
workflow-run [workflow-name] [options]
```

**Workflow Names:**
- `dev` - Run development workflow for current project type
- `test` - Run testing workflow
- `deploy` - Run deployment workflow
- `list` - List available workflows for current project
- `info <name>` - Show workflow details

**Options:**
- `-h, --help` - Show help message
- `-c, --continue` - Continue on errors (don't stop at first failure)
- `-i, --info` - Show workflow info without running
- `--dry-run` - Show what would be executed without running

**Examples:**
```bash
# Run development workflow
workflow-run dev

# Run tests
workflow-run test

# List available workflows
workflow-run list

# Show workflow details
workflow-run info dev

# Run with continue-on-error
workflow-run dev --continue

# Dry run (preview)
workflow-run test --dry-run
```

**Available Workflows:**
- R Packages: `dev`, `test`, `pre-commit`, `build`, `check`
- Quarto Projects: `preview`, `render`, `publish`
- Custom: Create `.workflows/` directory in project

---

### `rpkg-setup`

Smart R package initialization with integrated workflows and claude-r-dev support.

**Usage:**
```bash
rpkg-setup <package-name> [options]
```

**Options:**
- `-t, --type TYPE` - Package type: `standard`, `statistical`, `data-analysis`, `shiny` (default: `standard`)
- `--tier TIER` - Storage tier: `active`, `stable`, `scratch` (default: `active`)
- `--claude-r-dev` - Install claude-r-dev configuration
- `--no-claude-r-dev` - Skip claude-r-dev installation (default: auto-detect)
- `--profiles PROFILES` - Comma-separated claude-r-dev profiles (default: auto-selected)
- `--skills` - Activate recommended Claude skills
- `--no-skills` - Don't activate skills (default: activate if available)
- `-h, --help` - Show help message

**Examples:**
```bash
# Create standard R package
rpkg-setup mypackage

# Create statistical methods package
rpkg-setup causalmed --type statistical

# Create in stable tier
rpkg-setup dataviz --type data-analysis --tier stable

# Create with custom profiles
rpkg-setup analysis --profiles base,data-analysis

# Create without claude-r-dev
rpkg-setup simple --no-claude-r-dev
```

**Package Types:**
- `standard` - Standard R package (default)
- `statistical` - Statistical methods and causal inference
- `data-analysis` - Data analysis and visualization
- `shiny` - Shiny web applications

**What It Does:**
1. Creates R package structure in appropriate tier directory
2. Installs claude-r-dev configuration (if available)
3. Activates recommended Claude skills
4. Creates CLAUDE.md from template
5. Initializes git repository
6. Sets up development workflows

---

### `skill-activate`

Manage Claude skills for the current project.

**Usage:**
```bash
skill-activate [command] [options]
```

**Commands:**
- `<skill-name>` - Activate a skill for current project
- `list` - List active skills for current project
- `deactivate <name>` - Deactivate a skill
- `show <name>` - Show skill details
- `auto` - Auto-activate recommended skills for project type
- `available` - List all available user-level skills

**Options:**
- `-f, --force` - Force activation (override existing)
- `-h, --help` - Show help message

**Examples:**
```bash
# Activate R package development skill
skill-activate r-package-development

# Auto-activate recommended skills
skill-activate auto

# List active skills
skill-activate list

# Show available skills
skill-activate available

# Show skill details
skill-activate show r-package-development

# Deactivate a skill
skill-activate deactivate simulation
```

**How Skills Work:**
- Skills are stored in `~/.claude/skills/` (user-level)
- Activated via symlinks to `.claude/skills/` in project
- Allows shared skills across all projects
- Supports project-specific overrides
- Easy activation/deactivation without copying files

**Common Skills:**
- `r-package-development` - R package development best practices
- `statistical-simulation` - Statistical simulation workflows
- `quarto-publishing` - Quarto document publishing
- `manuscript-writing` - Academic manuscript writing

---

## Workspace Audit Commands

### `git-audit`

Find git repositories with uncommitted changes or unpushed commits.

**Usage:**
```bash
git-audit [OPTIONS] [DIRECTORY]
```

**Options:**
- `-a, --all` - Show clean repos too
- `-q, --quiet` - Minimal output (no file lists)
- `-h, --help` - Show help

**Environment:**
- `PROJECTS_DIR` - Base directory (default: ~/projects)
- `GIT_AUDIT_DEPTH` - Max search depth (default: 3)

**Examples:**
```bash
# Audit ~/projects
git-audit

# Quick summary only
git-audit -q

# Audit specific directory
git-audit ~/code
```

---

### `file-audit`

Find large files that may need cleanup or should be in .gitignore.

**Usage:**
```bash
file-audit [OPTIONS] [DIRECTORY]
```

**Options:**
- `-s, --size SIZE` - Size threshold (default: 50M)
- `-h, --help` - Show help

**Excludes:** .git, node_modules, .venv, __pycache__, renv

**Examples:**
```bash
# Find files >50MB
file-audit

# Find files >100MB
file-audit -s 100M

# Audit data folder
file-audit ~/data -s 10M
```

---

### `activity-heat`

Show activity heatmap for recent file modifications across projects.

**Usage:**
```bash
activity-heat [OPTIONS] [DIRECTORY]
```

**Options:**
- `-d, --days N` - Look back N days (default: 7)
- `-n, --top N` - Show top N projects (default: 10)
- `-h, --help` - Show help

**Examples:**
```bash
# Last 7 days, top 10
activity-heat

# Last 30 days
activity-heat -d 30

# Top 5 only
activity-heat -n 5
```

---

### `morning-audit`

Run a comprehensive daily workspace health check.

**Usage:**
```bash
morning-audit [OPTIONS]
```

**Runs:**
1. `git-audit` - Find dirty/unpushed repos
2. `activity-heat` - Show recent activity
3. `file-audit` - Find large files (in report only)
4. `obs audit` - Check Obsidian structure (if available)

**Options:**
- `-s, --save` - Save report to ~/logs/audit/
- `-o, --open` - Save and open report (macOS)
- `-q, --quiet` - Minimal terminal output
- `-h, --help` - Show help

**Examples:**
```bash
# Quick terminal check
morning-audit

# Save markdown report
morning-audit -s

# Save and open report
morning-audit -o
```

---

## Aliases

For convenience, shorter aliases are available:

| Alias | Command | Description |
|-------|---------|-------------|
| `ptype` | `proj-type` | Quick project type check |
| `pinfo` | `proj-info` | Quick project info |
| `cctx` | `claude-ctx` | Quick context view |
| `cinit` | `claude-init` | Quick CLAUDE.md creation |
| `cshow` | `claude-show` | Quick CLAUDE.md display |
| `pclaude` | `proj-claude` | Quick Claude Code launch |
| `ga` | `git-audit` | Quick git status audit |
| `fa` | `file-audit` | Quick large file finder |
| `ah` | `activity-heat` | Quick activity heatmap |
| `ma` | `morning-audit` | Quick morning audit |

---

## Workflows

### Setting up a new R package

```bash
# Navigate to package
cd ~/R-packages/active/newpackage

# Check project type
ptype

# Create CLAUDE.md
cinit

# Edit CLAUDE.md
vim CLAUDE.md

# View context
cctx

# Open Claude Code
pclaude
```

### Working with existing project

```bash
# Navigate to project
cd ~/R-packages/active/rmediation

# Check what we have
ptype

# View full info
pinfo

# Show Claude instructions
cshow

# Start working with Claude
pclaude
```

### Migrating project from local to cloud

```bash
# Before moving
cd ~/R-packages/active/mypackage
pinfo

# Note the CLAUDE.md exists
cshow

# After moving to Google Drive
# CLAUDE.md stays with the project!
```

---

## Integration with Existing Workflow

These commands work seamlessly with your existing R package development workflow:

```bash
# R package development
cd ~/R-packages/active/rmediation
ptype              # Check project status
rdev               # Run R package checks (existing alias)
rpkgcommit "msg"   # Commit with validation (existing alias)
pclaude            # Get Claude's help
```

---

## Tips

1. **Use ptype frequently** - Quick way to orient yourself in any directory
2. **Create CLAUDE.md early** - Better Claude Code integration from the start
3. **Update CLAUDE.md** - Keep instructions current as project evolves
4. **Leverage templates** - Customize the templates in `templates/` directory
5. **Combine with z** - `z rmediation && pinfo` for quick project jumping and info

---

## Troubleshooting

### Command not found

Make sure you've run the installation:
```bash
cd ~/code/zsh-claude-workflow
./install.sh
source ~/.zshrc
```

### Project type not detected

Supported types:
- R Package: requires `DESCRIPTION` with `Package:` field
- Quarto: requires `_quarto.yml` or `.qmd` files
- Research: requires `main.tex` or `literature/` directory

### CLAUDE.md template not found

Check that templates exist:
```bash
ls ~/code/zsh-claude-workflow/templates/
```

Should see: `CLAUDE-rpkg.md`, `CLAUDE-quarto.md`, `CLAUDE-research.md`

---

## Advanced Usage

### Custom project directories

Edit `~/code/zsh-claude-workflow/config/defaults.conf` to add your project locations.

### Custom templates

Create your own templates in `templates/` directory. Use placeholders:
- `{{PROJECT_NAME}}` - Project name
- `{{PACKAGE_NAME}}` - Package name (for R packages)
- `{{PROJECT_DESCRIPTION}}` - Project description
- `{{PACKAGE_DESCRIPTION}}` - Package description
- `{{DATE}}` - Current date

---

## See Also

- Main README: `~/code/zsh-claude-workflow/README.md`
- Your R package workflow: `~/.claude/skills/r-package-development.md`
- Your zsh environment: `~/.claude/skills/zsh-environment.md`
