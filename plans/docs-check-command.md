# Plan: `docs-check` Command

**Status**: Planned for v1.4+
**Priority**: Medium
**Complexity**: High
**Related**: `~/.claude/commands/docs-check.md` (Claude Code slash command)

---

## Overview

A comprehensive documentation and website validation command that works across all project types in `~/projects/`. This command automates pre-flight checks before deploying documentation to GitHub Pages.

## Motivation

Currently, documentation deployment is manual and error-prone:
- Version mismatches between files go unnoticed
- Broken links aren't caught until after deployment
- Static badges with hardcoded versions become stale
- No unified workflow across npm, R, and Python projects

## Design Goals

1. **Universal**: Works with MkDocs, pkgdown, Quarto, and plain documentation
2. **Integrated**: Bridges shell workflow with Claude Code slash command
3. **Non-destructive**: Validates before any changes
4. **Interactive**: Requires user confirmation before deployment
5. **Observable**: Background monitoring of GitHub Actions

---

## Architecture

### New Files

```
zsh-claude-workflow/
├── lib/
│   └── docs-validator.sh       # Core validation library
├── commands/
│   └── docs-check              # Main command
└── config/
    └── docs-check.conf         # Default configuration
```

### Dependencies

**Required:**
- `git` - Version control
- `gh` - GitHub CLI for Actions monitoring
- `jq` - JSON parsing (for package.json, etc.)

**Optional (by project type):**
- `mkdocs` - MkDocs projects
- `R` + `pkgdown` - R packages
- `quarto` - Quarto projects
- `node` - npm projects

---

## Implementation Plan

### Phase 1: Core Library (`lib/docs-validator.sh`)

```bash
# Project type detection (extend existing)
detect_docs_type() {
    local dir="${1:-$PWD}"
    if [[ -f "$dir/mkdocs.yml" ]]; then
        echo "mkdocs"
    elif [[ -f "$dir/_pkgdown.yml" ]]; then
        echo "pkgdown"
    elif [[ -f "$dir/_quarto.yml" ]]; then
        echo "quarto"
    elif [[ -f "$dir/package.json" ]]; then
        echo "npm"
    else
        echo "generic"
    fi
}

# Version extraction
get_version_from_file() {
    local file="$1"
    case "$file" in
        package.json)
            jq -r '.version' "$file"
            ;;
        DESCRIPTION)
            grep "^Version:" "$file" | sed 's/Version: //'
            ;;
        *.yml|*.yaml)
            grep "version:" "$file" | head -1 | sed 's/.*version: //'
            ;;
    esac
}

# Badge validation
check_badges() {
    local readme="$1"
    local -a static_badges=()
    local -a dynamic_badges=()

    # Parse badge URLs from README
    while IFS= read -r line; do
        if [[ "$line" =~ img\.shields\.io/badge/version ]]; then
            static_badges+=("$line")
        elif [[ "$line" =~ img\.shields\.io ]]; then
            dynamic_badges+=("$line")
        fi
    done < "$readme"

    # Report findings
    # ...
}

# Link validation
validate_links() {
    local docs_dir="${1:-docs}"
    local -a broken_links=()

    # Find all markdown files
    for file in "$docs_dir"/**/*.md; do
        # Extract links and validate
        # ...
    done

    echo "${broken_links[@]}"
}

# Build test
run_docs_build() {
    local type="$1"
    case "$type" in
        mkdocs)
            mkdocs build --strict 2>&1
            ;;
        pkgdown)
            Rscript -e "pkgdown::build_site()" 2>&1
            ;;
        quarto)
            quarto render 2>&1
            ;;
    esac
}

# GitHub Actions monitoring
monitor_gh_actions() {
    local repo="$1"
    local workflow="$2"
    local timeout="${3:-300}"  # 5 minutes default

    local start_time=$(date +%s)
    while true; do
        local status=$(gh run list --workflow="$workflow" -L 1 --json status -q '.[0].status')

        if [[ "$status" == "completed" ]]; then
            local conclusion=$(gh run list --workflow="$workflow" -L 1 --json conclusion -q '.[0].conclusion')
            echo "$conclusion"
            return
        fi

        local current_time=$(date +%s)
        if (( current_time - start_time > timeout )); then
            echo "timeout"
            return
        fi

        sleep 10
    done
}
```

### Phase 2: Main Command (`commands/docs-check`)

```bash
#!/usr/bin/env zsh
# docs-check - Comprehensive documentation validation and deployment

SCRIPT_DIR="${0:A:h}"
LIB_DIR="${SCRIPT_DIR}/../lib"

source "$LIB_DIR/core.sh"
source "$LIB_DIR/project-detector.sh"
source "$LIB_DIR/docs-validator.sh"

# Configuration
QUICK_MODE=false
SKIP_DEPLOY=false
VERBOSE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --quick|-q)
            QUICK_MODE=true
            shift
            ;;
        --skip-deploy|-s)
            SKIP_DEPLOY=true
            shift
            ;;
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            DIR="$1"
            shift
            ;;
    esac
done

main() {
    local dir="${DIR:-$PWD}"
    cd "$dir" || exit 1

    print_header "Documentation Check"

    # Phase 1: Detect project type
    local docs_type=$(detect_docs_type)
    print_info "Project type: $docs_type"

    # Phase 2: Version sync check
    print_header "Version Sync"
    check_version_sync

    # Phase 3: Badge validation
    print_header "Badge Validation"
    check_badges "README.md"

    # Phase 4: Link validation (skip if --quick)
    if [[ "$QUICK_MODE" != "true" ]]; then
        print_header "Link Validation"
        validate_links
    fi

    # Phase 5: Build test
    print_header "Build Test"
    run_docs_build "$docs_type"

    # Phase 6: Preview (skip if --quick)
    if [[ "$QUICK_MODE" != "true" ]]; then
        print_header "Local Preview"
        start_preview "$docs_type"

        # Wait for user
        print_info "Preview running. Press Enter when ready to continue..."
        read
        stop_preview
    fi

    # Phase 7: User confirmation
    if [[ "$SKIP_DEPLOY" != "true" ]]; then
        print_header "Deployment"

        echo "Ready to deploy?"
        select choice in "Yes, deploy now" "No, cancel" "Show report only"; do
            case "$choice" in
                "Yes, deploy now")
                    deploy_docs
                    break
                    ;;
                "No, cancel")
                    print_info "Deployment cancelled"
                    break
                    ;;
                "Show report only")
                    show_report
                    break
                    ;;
            esac
        done
    fi

    # Phase 8: Generate report
    generate_report
}

main "$@"
```

### Phase 3: Configuration (`config/docs-check.conf`)

```bash
# docs-check configuration

# Version files to check by project type
VERSION_FILES_NPM="package.json src/index.ts CLAUDE.md"
VERSION_FILES_RPKG="DESCRIPTION NEWS.md CLAUDE.md"
VERSION_FILES_MKDOCS="mkdocs.yml CLAUDE.md"

# Badge patterns to flag as static
STATIC_BADGE_PATTERNS="badge/version badge/v[0-9]"

# Link validation settings
VALIDATE_EXTERNAL_LINKS=true
EXTERNAL_LINK_TIMEOUT=5

# Build settings
BUILD_TIMEOUT=120
PREVIEW_PORT=8000

# GitHub Actions
GH_ACTIONS_TIMEOUT=300
GH_ACTIONS_POLL_INTERVAL=10
```

---

## Integration Points

### With Claude Code Slash Command

The shell command can be invoked from Claude Code:
```bash
# In Claude Code session
!docs-check --quick
```

Or the slash command can invoke the shell command if available:
```markdown
# In ~/.claude/commands/docs-check.md
If `docs-check` command is available in PATH, use it for validation.
Otherwise, perform validation using Claude Code tools.
```

### With Existing Commands

```bash
# After code changes
rdev                    # R development cycle
docs-check --quick      # Quick validation

# Before release
docs-check              # Full check with deployment
```

### With Workflow System

Add to `workflows/common/pre-release.yml`:
```yaml
name: pre-release
description: Pre-release checklist
steps:
  - name: Documentation check
    command: docs-check --skip-deploy
  - name: Version bump
    command: npm version patch  # or equivalent
  - name: Full docs check
    command: docs-check
```

---

## User Interface

### Interactive Mode

```
$ docs-check

╭──────────────────────────────────────────────────────────╮
│                  Documentation Check                      │
│                   examark (npm/mkdocs)                    │
╰──────────────────────────────────────────────────────────╯

📋 Version Sync
   ✓ package.json      0.6.6
   ✓ src/index.ts      0.6.6
   ✓ CLAUDE.md         0.6.6
   ✓ _extension.yml    0.6.6

🏷️  Badges
   ✓ npm version       (dynamic)
   ✓ CI status         (dynamic)
   ✓ Docs status       (dynamic)
   ✓ License           (static - OK)

🔗 Links
   ✓ 127 internal links valid
   ✗ 2 broken links:
     • docs/starter/index.md:34 → examples/old-name.md
     • README.md:156 → https://old-docs.example.com

🔨 Build
   ✓ mkdocs build successful (0.67s)
   ⚠ 1 warning: Page not in nav: docs/archive/old.md

🌐 Preview
   Server running at http://localhost:8000
   Press Enter when ready to continue...

📦 Deploy?
   1) Yes, deploy now
   2) No, cancel
   3) Show report only
   #?
```

### Report Output

```markdown
## Documentation Check Report

**Project**: examark
**Type**: npm + mkdocs
**Date**: 2025-12-09 14:45:00

### Summary
- ✓ Version sync: All files match (0.6.6)
- ✓ Badges: 4 valid (3 dynamic, 1 static)
- ✗ Links: 2 broken (127 valid)
- ⚠ Build: Success with 1 warning

### Issues to Fix
1. **Broken link** - docs/starter/index.md:34
   Target: examples/old-name.md (not found)
   Suggested: examples/new-name.md

2. **Broken link** - README.md:156
   Target: https://old-docs.example.com
   Status: 404 Not Found

### Deployment Status
- [x] Validation complete
- [ ] Ready for deployment (fix issues first)
```

---

## Testing Plan

### Unit Tests

```bash
# Test version extraction
test_version_extraction() {
    echo '{"version": "1.2.3"}' > /tmp/package.json
    result=$(get_version_from_file /tmp/package.json)
    assert_equals "1.2.3" "$result"
}

# Test badge detection
test_badge_detection() {
    # Create test README with badges
    # Verify static vs dynamic detection
}

# Test link validation
test_link_validation() {
    # Create test docs with known broken links
    # Verify all are detected
}
```

### Integration Tests

```bash
# Test on examark project
cd ~/projects/apps/examify
docs-check --quick --skip-deploy

# Test on R package
cd ~/R-packages/active/medfit
docs-check --quick --skip-deploy

# Test on zsh-claude-workflow itself
cd ~/projects/dev-tools/zsh-claude-workflow
docs-check --quick --skip-deploy
```

---

## Future Enhancements

### v1.5+
- **Diff preview**: Show what changed since last deployment
- **Rollback**: Ability to rollback to previous deployment
- **Scheduled checks**: Run validation on schedule (cron)
- **Slack/Discord notifications**: Alert on deployment status

### v1.6+
- **Multi-project**: Check all projects in ecosystem
- **Dependency docs**: Check if dependency docs are current
- **SEO validation**: Check meta tags, sitemap, robots.txt
- **Accessibility**: Check documentation accessibility

---

## Related Documents

- `~/.claude/commands/docs-check.md` - Claude Code slash command (implemented)
- `~/.claude/skills/doc-management.md` - Documentation management skill
- `~/.claude/skills/data-wise-documentation.md` - Data-Wise standards
- `plans/file-project-management-optimization.md` - Related feature planning

---

**Created**: 2025-12-09
**Author**: Claude Code
**Version**: Draft 1.0
