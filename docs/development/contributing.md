# Contributing

Thank you for your interest in contributing to zsh-claude-workflow!

## Getting Started

### 1. Fork and Clone

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/zsh-claude-workflow.git
cd zsh-claude-workflow
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Changes

Follow the [coding standards](#coding-standards) below.

### 4. Test Your Changes

```bash
# Test commands
./commands/proj-type
./commands/claude-ctx

# Test on different project types
cd ~/R-packages/active/rmediation && proj-type
cd ~/quarto-projects/book && proj-type
```

### 5. Commit and Push

```bash
git add .
git commit -m "Add feature: description"
git push origin feature/your-feature-name
```

### 6. Create Pull Request

Open a PR on GitHub with a clear description of your changes.

---

## Coding Standards

### Shell Scripting (Zsh)

**Shebang:**
```bash
#!/usr/bin/env zsh
```

**Style:**
- Follow Oh My Zsh conventions
- Use `local` for function-scoped variables
- Use `UPPERCASE` for constants
- Use lowercase_with_underscores for functions

**Error Handling:**
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
```

---

### Naming Conventions

| Type | Convention | Examples |
|------|------------|----------|
| Commands | kebab-case | `proj-type`, `claude-init` |
| Functions | snake_case | `get_project_type()`, `find_claude_files()` |
| Variables (local) | snake_case | `project_type`, `dir` |
| Variables (env) | UPPER_SNAKE_CASE | `SCRIPT_DIR`, `LIB_DIR` |
| Files (lib) | kebab-case.sh | `project-detector.sh` |

---

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

---

### Error Messages

Provide helpful, actionable error messages:

```bash
# Good
if [[ ${#claude_files[@]} -eq 0 ]]; then
    print_warning "No CLAUDE.md found"
    print_info "Run ${fg[yellow]}claude-init${reset_color} to create one"
    return 1
fi

# Bad
echo "Error: no file"
```

---

## Testing

### Manual Testing

Since this is a zsh scripting project, testing is primarily manual:

```bash
# Test on different project types
cd ~/R-packages/active/rmediation
proj-type                    # Should detect R Package

cd ~/quarto-projects/book
proj-type                    # Should detect Quarto Project

# Test context gathering
claude-ctx                   # Should find CLAUDE.md files

# Test template generation
cd /tmp && mkdir test-pkg && cd test-pkg
echo "Package: testpkg" > DESCRIPTION
claude-init                  # Should create CLAUDE.md
cat CLAUDE.md               # Verify content

# Clean up
cd /tmp && rm -rf test-pkg
```

### Test Coverage Areas

- ✅ Project type detection (rpkg, quarto, research, unknown)
- ✅ CLAUDE.md finding (root, .claude/, multiple files)
- ✅ Template substitution ({{PACKAGE_NAME}}, {{DATE}}, etc.)
- ✅ Storage location detection (local, google-drive, onedrive)
- ✅ Storage tier detection (active, stable, archive, scratch)
- ✅ Git integration (branch, status)
- ✅ Error handling (missing files, not in project)

---

## Adding Features

### Adding a New Command

1. **Create command script:**
```bash
vim commands/new-command
```

2. **Use template:**
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

3. **Make executable:**
```bash
chmod +x commands/new-command
```

4. **Test:**
```bash
./commands/new-command
```

5. **Document:**
- Add to `docs/commands/reference.md`
- Update `docs/index.md` if user-facing

---

### Adding a Library Function

1. **Choose appropriate library:**
- `core.sh` - Utilities, printing, file operations
- `project-detector.sh` - Project type detection
- `claude-context.sh` - Context gathering

2. **Add function:**
```bash
# In lib/project-detector.sh

# Detect if current directory is a Python project
is_python_project() {
    local dir="${1:-$PWD}"
    [[ -f "$dir/setup.py" ]] || [[ -f "$dir/pyproject.toml" ]]
}
```

3. **Update dependent code**

4. **Test thoroughly**

---

### Adding a Template

1. **Create template file:**
```bash
vim templates/CLAUDE-python.md
```

2. **Use placeholders:**
```markdown
# CLAUDE.md for {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

**Created:** {{DATE}}
```

3. **Update `claude-init` command:**
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

---

## Documentation

### Update Documentation When:

1. Adding new features
2. Changing command behavior
3. Modifying project detection
4. Adding templates

### Documentation Files to Update:

- `docs/index.md` - Main overview
- `docs/getting-started/quickstart.md` - Quick start guide
- `docs/commands/reference.md` - Command reference
- `docs/guide/*.md` - Relevant guides
- `README.md` - Top-level readme (keep in sync)

---

## Pull Request Guidelines

### PR Title

Use conventional commits format:

```
feat: Add Python project detection
fix: Correct template substitution for dates
docs: Update command reference
refactor: Simplify project detection logic
```

### PR Description

Include:

1. **What** - What does this PR do?
2. **Why** - Why is this change needed?
3. **How** - How does it work?
4. **Testing** - How did you test it?

**Example:**
```markdown
## What
Adds support for Python project detection

## Why
Many users work with Python projects and want the same
context management features

## How
- Added is_python_project() detection function
- Created CLAUDE-python.md template
- Updated proj-type to show Python icon

## Testing
- Tested on multiple Python projects
- Verified template substitution
- Checked edge cases (no setup.py)
```

---

## Code Review Process

1. **Automated checks** - Code must pass linting (if applicable)
2. **Manual testing** - Reviewer tests changes
3. **Documentation** - Reviewer checks docs are updated
4. **Approval** - At least one approval required
5. **Merge** - Squash and merge to main

---

## Questions?

- **Issues:** https://github.com/Data-Wise/zsh-claude-workflow/issues
- **Discussions:** GitHub Discussions tab
- **Email:** Open an issue for contact info

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
