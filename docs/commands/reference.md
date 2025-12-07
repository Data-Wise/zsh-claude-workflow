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
