# Documentation Management Skill - zsh-claude-workflow

Project-specific documentation management for the zsh-claude-workflow system.

## Project Context

This is a **zsh shell scripting project** with:
- MkDocs documentation site with Material theme
- GitHub Pages auto-deployment
- 6 commands, 3 libraries, 4 templates
- User and developer documentation

## When to Use This Skill

Automatically invoke when:

1. **MkDocs files are modified** - Changes to `mkdocs.yml`, `docs/**/*.md`
2. **Commands are updated** - Changes to `commands/*` that need documentation
3. **Libraries are modified** - Changes to `lib/*.sh` requiring architecture updates
4. **Templates are added/modified** - New or updated CLAUDE.md templates
5. **User requests** - "update docs", "sync docs", "update knowledge"

## Project-Specific Workflow

### 1. Detect Changes

Check for modified files:
```bash
git status --short | grep -E '(mkdocs.yml|docs/|README.md|CLAUDE.md|commands/|lib/|templates/)'
```

### 2. Update CLAUDE.md

Always update the project knowledge base:

**Version History:**
- Add new entry under appropriate version
- Use semantic versioning (major.minor.patch)
- Include all significant changes

**Update Sections:**
- `Key Features` - If new features added
- `Common Development Commands` - If new commands added
- `Project Structure` - If structure changed
- `Most Used Files` - If new important files added
- `Last Updated` - Always update timestamp

**Version Bumping Rules:**
- **Major (x.0.0)** - New phase, breaking changes
- **Minor (1.x.0)** - New commands, features, significant additions
- **Patch (1.0.x)** - Bug fixes, documentation updates, minor improvements

### 3. Update MkDocs Documentation

If commands or features changed, update:

**Files to Check:**
- `docs/commands/reference.md` - Command documentation
- `docs/commands/overview.md` - Command overview
- `docs/guide/*.md` - User guides
- `docs/development/architecture.md` - Architecture changes
- `docs/index.md` - Landing page features

**Build and Verify:**
```bash
mkdocs build
# Check for warnings or errors
```

### 4. Update README.md

If major features added:
- Update features list
- Update quick start examples
- Verify badges are current
- Check documentation links

### 5. Create Structured Commit

**Commit Message Format:**
```
[type]: [brief description]

[Detailed changes for CLAUDE.md, docs, etc.]

## Changes
- Updated CLAUDE.md version history (v1.x.x)
- Updated docs/[file] with [changes]
- Added/Fixed [specific items]

## Documentation
- MkDocs build: ✓ Success
- Version bumped: v1.x.x → v1.y.z

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Commit Types:**
- `docs:` - Documentation-only updates
- `feat:` - New commands or features (+ docs)
- `fix:` - Bug fixes (+ docs)
- `chore:` - Maintenance (templates, config)

### 6. Push and Deploy

```bash
git push origin main
```

GitHub Actions will automatically:
- Build MkDocs site
- Deploy to GitHub Pages
- Make live at https://data-wise.github.io/zsh-claude-workflow/

### 7. Verify Deployment

Check GitHub Actions:
```bash
gh run list --limit 1
# Or visit: https://github.com/Data-Wise/zsh-claude-workflow/actions
```

## Specific Files to Update

### Always Update

✅ **CLAUDE.md** - Project knowledge base
- Version history
- Last updated timestamp
- Feature status if changed

### Update When Changed

📝 **docs/commands/reference.md** - Command changes
📝 **docs/commands/overview.md** - New commands
📝 **docs/guide/project-types.md** - New project types
📝 **docs/guide/templates.md** - New templates
📝 **docs/development/architecture.md** - Structural changes
📝 **README.md** - Major feature updates

### Build Files

🔨 **mkdocs.yml** - Navigation changes
🔨 **requirements.txt** - Dependency updates

## Version Management

### Current Version Pattern

Track in CLAUDE.md under "Version History":
```markdown
### v1.2 (2025-12-07)
- ✅ Feature added
- ✅ Documentation updated
```

### When to Bump

**Patch (1.0.x → 1.0.y):**
- Documentation fixes
- Command bug fixes
- Template updates
- Minor improvements

**Minor (1.x.0 → 1.y.0):**
- New commands
- New project type detection
- New templates
- Significant features

**Major (x.0.0 → y.0.0):**
- Breaking changes
- Complete restructure
- New project phases

## Pre-Commit Validation

Before committing, verify:

- [ ] **MkDocs builds successfully** - `mkdocs build` exits 0
- [ ] **CLAUDE.md updated** - Version history and timestamp
- [ ] **Commands documented** - All new/changed commands in docs
- [ ] **Links work** - No broken internal links
- [ ] **Code examples tested** - All examples actually work
- [ ] **File structure accurate** - Structure diagram matches reality

## Commit Message Examples

### Example 1: Add New Command

```
feat: Add claude-sync command for documentation workflow

Added new command to automate documentation updates and commits.

## Changes
- Created commands/claude-sync
- Updated CLAUDE.md version history (v1.2.0)
- Updated docs/commands/reference.md with claude-sync docs
- Added examples to docs/getting-started/quickstart.md

## Documentation
- MkDocs build: ✓ Success
- Version bumped: v1.1.0 → v1.2.0

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Example 2: Documentation Update

```
docs: Update installation guide and project types documentation

Enhanced documentation with clearer examples and explanations.

## Changes
- Updated CLAUDE.md version history (v1.1.1)
- Improved docs/getting-started/installation.md with troubleshooting
- Added Python project type example to docs/guide/project-types.md
- Fixed typos in docs/commands/reference.md

## Documentation
- MkDocs build: ✓ Success
- Version bumped: v1.1.0 → v1.1.1

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Example 3: Fix and Document

```
fix: Correct project detection for nested Quarto projects

Fixed bug in is_quarto_project() and updated documentation.

## Changes
- Fixed lib/project-detector.sh (is_quarto_project function)
- Updated CLAUDE.md version history (v1.1.2)
- Added edge case documentation to docs/guide/project-types.md
- Updated testing checklist in docs/development/testing.md

## Documentation
- MkDocs build: ✓ Success
- Version bumped: v1.1.1 → v1.1.2

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

## Automation Triggers

### Automatic (No Confirmation)

Auto-commit and push when:
- Documentation-only changes (no code modified)
- Version history updates
- Timestamp updates
- Typo fixes

### Prompt Before Committing

Ask user before committing when:
- New commands added
- Code and docs both changed
- Breaking changes
- Major version bumps

## Error Handling

### MkDocs Build Fails

If `mkdocs build` fails:
1. Show the error output
2. Don't commit changes
3. Offer to help fix the error
4. Common fixes:
   - Missing file in nav
   - Broken internal link
   - Invalid YAML in frontmatter

### Git Conflicts

If push fails due to conflicts:
1. `git pull --rebase origin main`
2. Resolve conflicts (ask user if needed)
3. Continue with push

### Missing Files

If documentation references missing files:
1. Alert user
2. Offer to create stub file
3. Don't commit until resolved

## Integration with Existing Commands

### After Running These Commands

**After `commands/claude-init`:**
- Update docs/guide/templates.md if new template
- Update template list in CLAUDE.md

**After `commands/proj-type`:**
- Update docs/guide/project-types.md if detection changed
- Update examples in documentation

**After library changes (`lib/*.sh`):**
- Update docs/development/architecture.md
- Update relevant user guides

## GitHub Pages Specifics

### Deployment Workflow

File: `.github/workflows/docs.yml`
- Triggers on push to main
- Builds with MkDocs
- Deploys to gh-pages branch
- Usually completes in 1-2 minutes

### Verify Deployment

After pushing:
```bash
# Check workflow status
gh run list --limit 1

# Or visit
open "https://github.com/Data-Wise/zsh-claude-workflow/actions"
```

### Documentation URL

Live site: https://data-wise.github.io/zsh-claude-workflow/

## Quick Reference

```bash
# Build docs locally
mkdocs serve   # Preview at http://127.0.0.1:8000

# Build static site
mkdocs build   # Outputs to site/

# Check git status
git status --short

# View recent commits
git log --oneline -5

# Check GitHub Actions
gh run list --limit 5
```

## Notes

- This skill **extends** the user-level `doc-management` skill
- Project-specific rules take precedence
- Always follow existing commit message conventions
- Maintain the style and structure of existing documentation
- Keep CLAUDE.md as the authoritative project knowledge source

---

**Skill Version**: 1.0.0
**Last Updated**: 2025-12-07
**Project**: zsh-claude-workflow
**Applies To**: This project only
