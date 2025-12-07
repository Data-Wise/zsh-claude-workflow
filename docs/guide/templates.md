# Templates

zsh-claude-workflow uses templates to create project-specific CLAUDE.md files.

## Available Templates

### 📦 R Package Template

**File:** `templates/CLAUDE-rpkg.md`

**Used for:** R packages (projects with DESCRIPTION file)

**Includes:**
- Package structure and conventions
- R development best practices
- Testing guidelines
- Documentation standards
- Common R package tasks

**Placeholders:**
- `{{PACKAGE_NAME}}` - Package name from DESCRIPTION
- `{{PACKAGE_DESCRIPTION}}` - Package description
- `{{DATE}}` - Current date

**Example:**
```bash
cd ~/R-packages/active/newpackage
claude-init  # Creates CLAUDE.md from R package template
```

---

### 📄 Quarto Template

**File:** `templates/CLAUDE-quarto.md`

**Used for:** Quarto projects and extensions

**Includes:**
- Quarto project structure
- Markdown and code chunk conventions
- Build and preview commands
- Publishing guidelines

**Placeholders:**
- `{{PROJECT_NAME}}` - Project name from _quarto.yml
- `{{PROJECT_DESCRIPTION}}` - Project description
- `{{DATE}}` - Current date

---

### 🔬 Research Template

**File:** `templates/CLAUDE-research.md`

**Used for:** Research projects with LaTeX

**Includes:**
- Research project organization
- LaTeX conventions
- Bibliography management
- Writing guidelines
- Statistical analysis patterns

**Placeholders:**
- `{{PROJECT_NAME}}` - Directory name
- `{{PROJECT_DESCRIPTION}}` - "Research project"
- `{{DATE}}` - Current date

---

## Template Placeholders

All templates support these placeholders:

| Placeholder | Description | Source |
|-------------|-------------|--------|
| `{{PACKAGE_NAME}}` | Project/package name | DESCRIPTION, _quarto.yml, or directory name |
| `{{PROJECT_NAME}}` | Project name | Same as above |
| `{{PROJECT_DESCRIPTION}}` | Project description | DESCRIPTION or default text |
| `{{DATE}}` | Current date | System date (YYYY-MM-DD) |

## Creating Custom Templates

### 1. Create Template File

Create a new template in the `templates/` directory:

```bash
cd ~/code/zsh-claude-workflow/templates
vim CLAUDE-python.md
```

### 2. Use Placeholders

Include placeholders in your template:

```markdown
# CLAUDE.md for {{PROJECT_NAME}}

## About This Project

{{PROJECT_DESCRIPTION}}

**Created:** {{DATE}}

## Project-Specific Guidelines

[Your custom content here]
```

### 3. Update claude-init

Edit `commands/claude-init` to use your template:

```bash
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

## Template Best Practices

### What to Include

✅ **Project structure** - Explain directory organization
✅ **Code conventions** - Naming, style, patterns
✅ **Common tasks** - Frequent operations and commands
✅ **Testing guidelines** - How to run and write tests
✅ **Domain-specific knowledge** - Project-specific context

### What to Avoid

❌ **Overly generic advice** - Keep it project-specific
❌ **Outdated information** - Keep templates current
❌ **Too much detail** - Claude can infer basic patterns
❌ **Redundant information** - Don't duplicate obvious things

### Template Structure

A good template typically includes:

```markdown
# CLAUDE.md for {{PROJECT_NAME}}

## About This Project
[Brief description and purpose]

## Project Structure
[Directory organization]

## Development Workflow
[Common commands and tasks]

## Code Conventions
[Naming, style, patterns]

## Testing
[How to run and write tests]

## Common Tasks
[Frequent operations]

## Important Notes
[Project-specific gotchas]
```

## Template Management

### Recommended Plugin Template

**File:** `templates/zsh_plugins.txt.recommended`

This template provides an optimized plugin configuration for zsh:

- Fast startup (lazy loading)
- Modern tools (eza, bat, fzf)
- Git integration (better diff, status)
- Syntax highlighting
- Autosuggestions

### Using the Plugin Template

```bash
# During installation
./install.sh  # Prompts to copy template

# Manual copy
cp ~/code/zsh-claude-workflow/templates/zsh_plugins.txt.recommended ~/.zsh_plugins.txt
```

## Editing Templates

### Edit Existing Template

```bash
cd ~/code/zsh-claude-workflow/templates
vim CLAUDE-rpkg.md
```

### Test Template

```bash
# Create test project
cd /tmp
mkdir test-pkg
cd test-pkg
echo "Package: testpkg" > DESCRIPTION

# Test template
~/code/zsh-claude-workflow/commands/claude-init

# Check result
cat CLAUDE.md
```

### Share Templates

Templates are part of the repository. To share:

1. Edit template files
2. Commit changes
3. Push to repository
4. Others get updated templates on pull

## Template Substitution

### How It Works

The `claude-init` command:

1. Detects project type
2. Selects appropriate template
3. Reads template file
4. Replaces placeholders with actual values
5. Writes CLAUDE.md to project directory

### Substitution Code

From `commands/claude-init`:

```bash
# Read template
content=$(<"$template")

# Substitute placeholders
content="${content//\{\{PACKAGE_NAME\}\}/$project_name}"
content="${content//\{\{PROJECT_NAME\}\}/$project_name}"
content="${content//\{\{PROJECT_DESCRIPTION\}\}/$description}"
content="${content//\{\{DATE\}\}/$(date +%Y-%m-%d)}"

# Write CLAUDE.md
echo "$content" > "$dir/CLAUDE.md"
```

## Next Steps

- [Context Management](context-management.md) - Learn about context gathering
- [Command Reference](../commands/reference.md) - Detailed claude-init documentation
- [Architecture](../development/architecture.md) - Template system internals
