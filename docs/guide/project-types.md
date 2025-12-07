# Project Types

zsh-claude-workflow automatically detects different types of projects and provides type-specific intelligence.

## Supported Project Types

### 📦 R Package

**Detection Criteria:**
- Has `DESCRIPTION` file with `Package:` field

**Displayed Information:**
- Package name from DESCRIPTION
- Package version
- Number of R files
- Number of tests
- Dependencies count

**Example:**
```bash
cd ~/R-packages/active/rmediation
proj-type
```

Output:
```
📦 R Package
Name: rmediation
Version: 1.2.1
Location: local / active
```

---

### 📄 Quarto Project

**Detection Criteria:**
- Has `_quarto.yml` file
- Has `.qmd` files

**Displayed Information:**
- Project title from _quarto.yml
- Project type (book, website, etc.)
- Number of .qmd files

**Example:**
```bash
cd ~/quarto-projects/book
proj-type
```

---

### 🧩 Quarto Extension

**Detection Criteria:**
- Has `_extension.yml` file

**Displayed Information:**
- Extension name
- Extension type (format, filter, shortcode)
- Version

**Example:**
```bash
cd ~/quarto-projects/extensions/unm-revealjs
proj-type
```

---

### 🔬 Research Project

**Detection Criteria:**
- Has `.tex` files
- Has `literature/` directory
- Has bibliography files (`.bib`)

**Displayed Information:**
- Project name (directory name)
- Number of LaTeX files
- Number of bibliography entries

**Example:**
```bash
cd ~/research/paper-2024
proj-type
```

---

### 🛠️ Development Tool

**Detection Criteria:**
- Has executable scripts
- Has `Makefile` or build configuration
- Doesn't match other types

**Displayed Information:**
- Project name
- Main executables
- Build system

---

### 📁 Git Project

**Detection Criteria:**
- Has `.git` directory
- Doesn't match more specific types

**Displayed Information:**
- Repository name
- Current branch
- Git status

---

### ❓ Unknown

**Detection Criteria:**
- Doesn't match any known pattern

**Displayed Information:**
- Directory name
- General file counts

## Storage Awareness

### Storage Locations

The system detects where your project is stored:

| Location | Path Pattern |
|----------|-------------|
| `local` | `~/code/`, `~/projects/` |
| `google-drive` | `~/Library/CloudStorage/GoogleDrive-*` |
| `onedrive` | `~/Library/CloudStorage/OneDrive-*` |
| `dropbox` | `~/Dropbox/` |

### Storage Tiers

Projects are categorized by tier:

| Tier | Path Pattern | Purpose |
|------|-------------|---------|
| `active` | `*/active/*` | Currently developed |
| `stable` | `*/stable/*` | Stable releases |
| `archive` | `*/archive/*` | Archived projects |
| `scratch` | `*/scratch/*` | Experimental work |

**Example Output:**
```
📦 R Package
Name: rmediation
Location: local / active
```

## Customizing Detection

### Adding a New Project Type

To add support for a new project type:

1. Edit `lib/project-detector.sh`
2. Add detection function:

```bash
is_python_project() {
    local dir="${1:-$PWD}"
    [[ -f "$dir/setup.py" ]] || [[ -f "$dir/pyproject.toml" ]]
}
```

3. Update `get_project_type()`:

```bash
get_project_type() {
    # ...
    elif is_python_project "$dir"; then
        echo "python"
    # ...
}
```

4. Add icon and label:

```bash
get_project_icon() {
    case "$1" in
        python) echo "🐍" ;;
        # ...
    esac
}
```

See [Architecture](../development/architecture.md) for more details.

## Detection Priority

When multiple patterns match, detection follows this priority:

1. R Package (most specific)
2. Quarto Extension
3. Quarto Project
4. Research Project
5. Development Tool
6. Git Project (least specific)

This ensures the most accurate type is selected.

## Next Steps

- [Templates](templates.md) - Learn about project-specific templates
- [Context Management](context-management.md) - Understand context gathering
- [Architecture](../development/architecture.md) - Deep dive into detection logic
