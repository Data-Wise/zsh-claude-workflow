# Context Management

Learn how zsh-claude-workflow gathers and manages context for Claude Code integration.

## What is Context?

Context includes all information Claude Code needs to understand your project:

- **CLAUDE.md files** - Project-specific instructions
- **Project structure** - Directory organization
- **Git information** - Branch, status, recent commits
- **Type-specific data** - R package stats, Quarto config, etc.
- **Storage information** - Location and tier

## Context Files

### CLAUDE.md

Primary instruction file for Claude Code:

**Location Priority:**
1. `./CLAUDE.md` (project root)
2. `./.claude/CLAUDE.md` (hidden directory)
3. `../CLAUDE.md` (parent directory)

**Multiple Files:**
- System finds all CLAUDE.md files in hierarchy
- All files are presented to Claude Code
- More specific files take precedence

---

### Claude Settings

Claude Code configuration files:

**Files:**
- `./.claude/settings.json` - Project settings
- `./.claude/settings.local.json` - Local overrides

---

## Context Gathering

### Automatic Context

The `claude-ctx` command automatically gathers:

```bash
claude-ctx
```

**Output:**
- List of all CLAUDE.md files found
- Content of primary CLAUDE.md
- Claude settings files
- Project metadata

---

### Context Summary

The `proj-info` command provides full context:

```bash
proj-info
```

**Includes:**
- Project type and name
- Storage location and tier
- Git status and branch
- CLAUDE.md files
- Type-specific information
- Project structure

---

## Context for Different Project Types

### R Package Context

**Additional Information:**
- Package name and version
- R/ directory file count
- tests/ directory status
- Dependencies from DESCRIPTION
- NAMESPACE exports

**Example:**
```bash
cd ~/R-packages/active/rmediation
proj-info
```

---

### Quarto Project Context

**Additional Information:**
- Project title and type
- Number of .qmd files
- _quarto.yml configuration
- Output formats

---

### Research Project Context

**Additional Information:**
- LaTeX files count
- Bibliography files
- Literature directory status

---

## Managing Context Files

### Creating CLAUDE.md

Use `claude-init` to create from template:

```bash
cd ~/R-packages/active/newpkg
claude-init
```

This creates a project-specific CLAUDE.md based on detected project type.

---

### Viewing Context

Use `claude-show` to display CLAUDE.md:

```bash
claude-show
```

Uses `bat` for syntax highlighting if available, otherwise uses `cat`.

---

### Editing CLAUDE.md

Edit directly:

```bash
vim CLAUDE.md
# or
code CLAUDE.md
```

---

## Context Hierarchy

### Multiple CLAUDE.md Files

When multiple files exist:

```
~/R-packages/active/rmediation/
├── CLAUDE.md              # Project-specific (highest priority)
└── .claude/
    └── CLAUDE.md          # Alternative location
```

The system shows all files and their locations.

---

### Global vs Project Context

**Global Context:**
- `~/.claude/CLAUDE.md` - User-wide preferences
- Applied to all Claude Code sessions

**Project Context:**
- `./CLAUDE.md` - Project-specific instructions
- Overrides or extends global context

---

## Advanced Context Features

### Git Context

Automatically included context:

- Current branch
- Uncommitted changes
- Recent commits (last 5)
- Remote repository URL

**Access:**
```bash
proj-info  # Includes git context
```

---

### Storage Context

Location and tier information:

**Helps Claude understand:**
- Project stability (active vs archive)
- Collaboration needs (local vs cloud)
- Backup status

---

### Project Structure

Automatically generated file tree:

```bash
proj-info  # Includes structure
```

Limited to relevant directories and files for Claude.

---

## Context Best Practices

### What to Include in CLAUDE.md

✅ **Project-specific conventions** - Naming patterns unique to your project
✅ **Common tasks** - Frequent operations Claude should know
✅ **Architecture decisions** - Important design choices
✅ **Dependencies** - Key libraries and their purposes
✅ **Testing approach** - How tests are organized and run

### What to Avoid

❌ **Generic programming advice** - Claude knows general patterns
❌ **Obvious information** - Directory structure Claude can see
❌ **Outdated instructions** - Keep it current or remove it
❌ **Too much detail** - Focus on what's non-obvious

---

## Context Integration with Claude Code

### Using proj-claude

The `proj-claude` command:

1. Gathers all context
2. Displays context summary
3. Launches Claude Code
4. Claude Code reads CLAUDE.md automatically

**Usage:**
```bash
cd ~/R-packages/active/rmediation
proj-claude
```

---

### Manual Integration

You can also:

1. Use `claude-ctx` to see context
2. Launch Claude Code manually
3. Claude Code finds CLAUDE.md automatically

---

## Context Examples

### Example: R Package

```bash
cd ~/R-packages/active/rmediation
claude-ctx
```

Shows:
- CLAUDE.md with R package guidelines
- Package structure
- Testing approach
- Dependencies

---

### Example: Quarto Book

```bash
cd ~/quarto-projects/book
claude-ctx
```

Shows:
- CLAUDE.md with Quarto conventions
- Chapter organization
- Build configuration
- Publishing workflow

---

## Troubleshooting

### No CLAUDE.md Found

```bash
claude-ctx
# ⚠ No CLAUDE.md found
# ℹ Run claude-init to create one
```

**Solution:**
```bash
claude-init
```

---

### Multiple CLAUDE.md Files

The system shows all found files:

```
ℹ Found 2 Claude instruction file(s):
  • ./CLAUDE.md
  • ./.claude/CLAUDE.md
```

This is normal. Claude Code reads both files.

---

### Wrong Template Used

If `claude-init` selected wrong template:

1. Check project type: `proj-type`
2. Manually specify template:
   ```bash
   cp ~/code/zsh-claude-workflow/templates/CLAUDE-rpkg.md ./CLAUDE.md
   ```
3. Edit as needed

---

## Next Steps

- [Templates](templates.md) - Learn about template customization
- [Project Types](project-types.md) - Understand project detection
- [Command Reference](../commands/reference.md) - Detailed command docs
