# Zsh File & Project Management Optimization

**Status**: Planning Phase
**Created**: 2025-12-07
**Target Version**: v1.4-v1.6
**Priority**: High Impact

---

## Overview

Comprehensive brainstorm for optimizing file and project management using zsh, building on the v1.3 workflow integration foundation. This plan addresses the full lifecycle of project management: discovery, navigation, organization, operations, and maintenance.

---

## 1. Smart Project Switching & Context Loading 🔄

### Current State
- `z` plugin for jumping to directories
- Manual `cd` to projects
- No automatic context loading

### Proposed Solution: Unified Project Launcher (`pj` command)

**Core Functionality:**
```bash
pj rmediation        # Jump + load context + activate environment
  → cd to project
  → Auto-load renv if exists
  → Activate project-specific skills
  → Set project-specific env vars
  → Show project status dashboard
```

**Implementation Components:**

#### A. Project Index System
Auto-maintained database of all projects:

```bash
~/.cache/zsh-projects.db format:
  project_name → full_path → project_type → storage_tier → metadata
```

**Commands:**
```bash
pj-index rebuild         # Rebuild project index
pj-index add <path>      # Add custom project
pj-index remove <name>   # Remove project
pj-index search <term>   # Search for projects
pj list <type>           # List projects by type
pj list --tier <tier>    # List by storage tier
```

**Index Builder:**
- Scans known project directories (~/R-packages, ~/quarto-projects, etc.)
- Detects project type automatically
- Stores metadata (last modified, git status, tier, etc.)
- Updates on demand or scheduled (cron)

#### B. Context Loading System

**On Project Entry:**
```bash
_load_project_context() {
    local project_dir="$PWD"

    # 1. Load project environment (.envrc, .project-env)
    _load_project_env

    # 2. Activate renv if exists
    [[ -f "renv.lock" ]] && _activate_renv

    # 3. Load project-specific skills
    [[ -d ".claude/skills" ]] && _load_skills

    # 4. Set project-specific aliases/functions
    _load_project_aliases

    # 5. Show dashboard
    _show_project_dashboard
}
```

**Dashboard Display:**
```
┌─────────────────────────────────────────┐
│ 📦 rmediation (R Package - Active)      │
├─────────────────────────────────────────┤
│ Version: 0.3.1                          │
│ Branch:  main ✓                         │
│ Status:  Clean, 3 commits ahead         │
│ Skills:  r-package-dev, zsh-env         │
│ renv:    Active (120 packages)          │
└─────────────────────────────────────────┘
```

**Priority**: High
**Complexity**: Medium
**Dependencies**: project-detector (existing), skill-manager (existing)
**Estimated Effort**: 2-3 days

---

## 2. Intelligent File Navigation 📁

### Current State
- `eza` for better ls
- `z` for jumping
- Manual navigation with cd
- No context awareness

### Proposed Solutions

#### A. Context-Aware File Finder (`f` command)

**Smart Search Based on Project Type:**
```bash
# In R package:
f test          → Searches tests/testthat/test-*.R
f function      → Searches R/*.R
f data          → Searches data/ and data-raw/
f vignette      → Searches vignettes/

# In Quarto:
f post          → Searches posts/*.qmd
f doc           → Searches docs/*.md
f asset         → Searches assets/
```

**With FZF Integration:**
```bash
f test
  → Opens fzf with test files
  → Preview pane shows file content (bat)
  → Select to open in $EDITOR
  → Multi-select for batch operations
```

**Implementation:**
```bash
f() {
    local query="$1"
    local project_type=$(get_project_type)

    # Get search paths based on project type
    local search_paths=$(get_search_paths "$project_type" "$query")

    # Find files
    fd . $search_paths --type f | \
        fzf --preview 'bat --color=always {}' \
            --preview-window=right:60% \
            --bind 'enter:become($EDITOR {})' \
            --multi
}
```

#### B. Smart Directory Bookmarks

**Auto-bookmarks per project type:**
```bash
# In R package:
@r       → R/
@test    → tests/testthat/
@man     → man/
@vig     → vignettes/
@data    → data-raw/

# In Quarto:
@docs    → docs/
@posts   → posts/
@assets  → assets/
@output  → _site/

# Usage:
cd @r           # Jump to R/ directory
ls @test        # List test files
peek @data/process.R
```

**Auto-setup on project entry:**
```bash
_set_project_bookmarks() {
    local type=$(get_project_type)

    case "$type" in
        rpkg)
            hash -d @r="$PWD/R"
            hash -d @test="$PWD/tests/testthat"
            hash -d @man="$PWD/man"
            hash -d @vig="$PWD/vignettes"
            hash -d @data="$PWD/data-raw"
            ;;
        quarto-manuscript)
            hash -d @docs="$PWD/docs"
            hash -d @sections="$PWD/sections"
            hash -d @assets="$PWD/assets"
            hash -d @refs="$PWD/references"
            ;;
        quarto-website)
            hash -d @posts="$PWD/posts"
            hash -d @docs="$PWD/docs"
            hash -d @assets="$PWD/assets"
            ;;
    esac
}

chpwd_functions+=(_set_project_bookmarks)
```

**Priority**: High
**Complexity**: Low-Medium
**Dependencies**: project-detector (existing), fzf
**Estimated Effort**: 1-2 days

---

## 3. File Organization Automation 🗂️

### Proposed Solutions

#### A. Intelligent File Sorting (`organize` command)

**Auto-organize by context:**
```bash
# In ~/Downloads:
organize
  → PDFs → ~/Documents/pdfs/
  → Images → ~/Pictures/downloads/
  → Code/scripts → ~/Downloads/code/
  → R scripts → ~/R-packages/scratch/snippets/
  → Data files → ~/Downloads/data/

# In project directory:
organize temp      # Remove temp files (.Rhistory, .RData, *.Rcheck)
organize builds    # Move builds to builds/ directory
organize old       # Archive old files (>6 months, not modified)
```

**Smart rules engine:**
```yaml
# ~/.config/zsh-organize/rules.yml
rules:
  - pattern: "*.pdf"
    destination: "~/Documents/pdfs"
    condition: "in_downloads"

  - pattern: "*.{R,Rmd}"
    destination: "~/R-packages/scratch/snippets"
    condition: "in_downloads && !in_project"

  - pattern: "*.tar.gz"
    destination: "builds/"
    condition: "in_rpkg && matches('*.tar.gz')"
```

#### B. Smart Archival System

**Tier migration with validation:**
```bash
archive <project> <target-tier>

archive rmediation stable
  → Pre-flight checks:
    - No uncommitted changes
    - Tests passing
    - Documentation up to date
  → Creates final build (.tar.gz for R packages)
  → Moves to target tier
  → Updates project index
  → Optionally creates symlink at original location
  → Logs migration in ~/.archive-log
```

**Tier Management:**
```bash
tier show <project>      # Show current tier
tier move <project> <from> <to>
tier list <tier>         # List all projects in tier
tier stats               # Show tier statistics
```

**Priority**: Medium
**Complexity**: Medium
**Dependencies**: project-detector, tier management
**Estimated Effort**: 3-4 days

---

## 4. Multi-Project Operations 🔀

### Proposed Solutions

#### A. Project Iterator (`pj-run` command)

**Bulk operations across projects:**
```bash
# Run command in all R packages:
pj-run rpkg git status
pj-run rpkg 'git pull && rdev'

# Run in specific tier:
pj-run rpkg:active git fetch
pj-run quarto:manuscripts quarto render

# With filtering:
pj-run rpkg --dirty git status        # Only dirty repos
pj-run rpkg --behind git pull         # Only repos behind remote
pj-run rpkg --test-failing rtest      # Only failing tests

# Interactive mode:
pj-run rpkg:active --interactive rdev
  → Shows list with checkboxes (fzf multi-select)
  → Select which projects
  → Runs with progress bar
  → Shows summary at end
```

**Implementation:**
```bash
pj-run() {
    local selector="$1"    # e.g., rpkg:active
    shift
    local command="$@"

    # Parse selector
    local type="${selector%%:*}"
    local tier="${selector##*:}"

    # Get projects
    local projects=$(pj-index list --type "$type" --tier "$tier")

    # Apply filters if specified
    [[ "$1" == "--dirty" ]] && projects=$(filter_dirty $projects)

    # Run command on each
    for project in ${=projects}; do
        echo "Running in $project..."
        (cd "$project" && eval "$command")
    done
}
```

#### B. Project Status Dashboard (`pj-status`)

**Comprehensive overview:**
```bash
pj-status          # All projects
pj-status rpkg     # Only R packages
pj-status --dirty  # Only dirty repos
pj-status --json   # JSON output for scripting
```

**Output:**
```
┌─────────────────────────────────────────────────┐
│ Project Status Dashboard                         │
├─────────────────────────────────────────────────┤
│ R Packages (Active - 6 projects)                │
├─────────────────────────────────────────────────┤
│ rmediation      ✓ clean    v0.3.1   main        │
│ mediationverse  ! dirty    v0.1.0   dev  ⚠ 3    │
│ medrobust       ✓ clean    v0.2.0   main        │
│ medsim          ✓ clean    v0.1.5   main        │
│ probmed         ! dirty    v0.2.1   dev  ⚠ 1    │
│ medfit          ✓ clean    v0.1.0   main        │
├─────────────────────────────────────────────────┤
│ R Packages (Stable - 1 project)                 │
├─────────────────────────────────────────────────┤
│ missingmed      ✓ clean    v1.2.0   main        │
├─────────────────────────────────────────────────┤
│ Quarto Projects (3 projects)                     │
├─────────────────────────────────────────────────┤
│ my-paper        ! dirty    draft    main  ⚠ 2   │
│ website         ✓ clean    v1.0     main        │
│ presentation    ✓ clean    latest   main        │
└─────────────────────────────────────────────────┘

Summary:
  Total: 10 projects
  Clean: 7
  Dirty: 3
  Uncommitted: 6 files

Actions:
  pj-run --dirty git status     # Check dirty repos
  pj-run rpkg:active rdev       # Run dev cycle
```

**Priority**: High
**Complexity**: Medium
**Dependencies**: project-index, git integration
**Estimated Effort**: 2-3 days

---

## 5. Smart File Templates & Scaffolding 📝

### Proposed Solutions

#### A. Enhanced File Creation (`new` command)

**Context-aware templates:**
```bash
# In R package:
new function calculate_mediation
  → Creates R/calculate_mediation.R with roxygen skeleton
  → Creates tests/testthat/test-calculate_mediation.R
  → Opens both in editor (split view if possible)
  → Optionally runs rdoc

new vignette tutorial
  → Creates vignettes/tutorial.Rmd
  → Includes standard frontmatter
  → Adds package dependencies
  → Opens in editor

new data survey_results
  → Creates data-raw/survey_results.R
  → Includes data processing template
  → Documents with roxygen
  → Opens in editor

# In Quarto manuscript:
new section introduction
  → Creates sections/01-introduction.qmd
  → Includes heading and basic structure
  → Updates main document to include it
  → Opens in editor

new figure analysis-plot
  → Creates figures/analysis-plot.qmd
  → Includes figure template with caption
  → Opens in editor

# In Quarto website:
new post "My New Blog Post"
  → Creates posts/2025-12-07-my-new-blog-post/index.qmd
  → Includes frontmatter with title, date, categories
  → Creates associated folder structure
  → Opens in editor + starts preview
```

**Template System:**
```bash
# Templates stored in:
~/.config/zsh-templates/
  rpkg/
    function.R.template
    test.R.template
    vignette.Rmd.template
    data.R.template
  quarto/
    manuscript/
      section.qmd.template
      figure.qmd.template
    website/
      post.qmd.template
      page.qmd.template
```

**Smart substitutions:**
```
{{FUNCTION_NAME}}     → calculate_mediation
{{DATE}}              → 2025-12-07
{{PACKAGE_NAME}}      → rmediation
{{AUTHOR}}            → David Tofighi
{{YEAR}}              → 2025
```

#### B. Project Templates (`pj-new` enhanced)

**Extended rpkg-setup:**
```bash
pj-new rpkg statistical mediation-bootstrap \
    --author "David Tofighi" \
    --license MIT \
    --github dtofighi/mediation-bootstrap \
    --description "Bootstrap methods for mediation analysis"

  → Creates package with statistical-methods profile
  → Initializes git with initial commit
  → Sets up GitHub repo (if --github specified)
  → Installs claude-r-dev profiles
  → Activates skills
  → Creates standard directory structure
  → Adds simulation study templates
  → Sets up pkgdown with custom theme
  → Opens in editor with README
```

**Quarto templates:**
```bash
pj-new quarto manuscript jasa-submission \
    --template jasa \
    --title "Product of Three Normal Distributions" \
    --authors "David Tofighi, et al."

  → Creates Quarto manuscript structure
  → Uses JASA template (from templates repo)
  → Includes bibliography setup
  → Adds manuscript-writing-guide skill
  → Sets up sections structure
  → Configures PDF output for JASA
```

**Priority**: High
**Complexity**: Medium
**Dependencies**: rpkg-setup (existing), template system
**Estimated Effort**: 3-4 days

---

## 6. File Watching & Auto-Actions 👁️

### Proposed Solutions

#### A. Smart File Watcher (`watch` command)

**Auto-run on file changes:**
```bash
# In R package:
watch rdev              # Watch R/ and tests/, auto-run rdev on change
watch rdoc              # Watch R/, auto-run rdoc only
watch 'R/**/*.R' rdoc   # Custom watch pattern

# In Quarto:
watch render            # Watch *.qmd, auto-render
watch preview           # Watch and update preview

# Custom patterns:
watch '*.R' 'rdoc && rtest'
watch 'data-raw/*.R' 'Rscript -e "source(\"{}\")"'
```

**Implementation using `entr` or `fswatch`:**
```bash
watch() {
    local pattern="${1:-**/*}"
    local command="${2:-echo 'File changed: {}'}"

    print_info "Watching for changes: $pattern"
    print_info "Running command: $command"
    echo ""

    # Use fd + entr for watching
    while true; do
        fd "$pattern" | entr -cd zsh -c "$command"
    done
}
```

#### B. Smart Auto-commit System

**Configurable auto-commit:**
```bash
auto-commit enable
  → Enables file watching
  → Auto-commits after N minutes of inactivity
  → Runs pre-commit checks (tests, lint)
  → Only commits if checks pass
  → Generates smart commit messages

auto-commit config
  → Set inactivity threshold (default: 5 min)
  → Set pre-commit checks (default: rdoc, rtest)
  → Enable/disable AI commit messages
  → Set auto-push option

auto-commit status
  → Show watcher status
  → Show last auto-commit
  → Show pending changes

auto-commit disable
  → Stops file watching
```

**Smart commit message generation:**
```bash
# Analyzes git diff and generates message
_generate_commit_message() {
    local diff=$(git diff --stat)

    # Simple heuristic-based generation
    # Could be enhanced with AI (Claude API)

    # Examples:
    # "Update calculate_mediation function"
    # "Add tests for bootstrap methods"
    # "Fix typo in documentation"
}
```

**Priority**: Medium
**Complexity**: High
**Dependencies**: git, entr/fswatch
**Estimated Effort**: 4-5 days

---

## 7. Cloud/Local Sync Optimization ☁️

### Proposed Solutions

#### A. Sync Status Monitoring (`sync-status` command)

**Monitor cloud sync status:**
```bash
sync-status
  → Checks Google Drive sync status
  → Checks OneDrive sync status
  → Shows pending uploads/downloads
  → Warns about conflicts
  → Estimates time to sync completion
```

**Output:**
```
┌─────────────────────────────────────────┐
│ Cloud Sync Status                       │
├─────────────────────────────────────────┤
│ Google Drive                            │
│  missingmed       ✓ Synced (2 min ago)  │
│  old-project      ↑ Uploading (45%)     │
│  archive-pkg      ✓ Synced (1 day ago)  │
│                                         │
│ OneDrive                                │
│  shared-analysis  ! Conflict            │
│    → Resolve at: [path]                 │
└─────────────────────────────────────────┘

Actions:
  sync-status --resolve    # Show conflict resolution help
  sync-status --pause      # Pause cloud sync temporarily
```

**Implementation:**
```bash
# Check Google Drive sync status
_check_gdrive_sync() {
    # macOS: Use mdls or Google Drive API
    # Query file sync status metadata
}

# Check OneDrive sync status
_check_onedrive_sync() {
    # Use OneDrive sync status indicators
}
```

#### B. Tier Migration with Sync Awareness

**Enhanced tier command:**
```bash
tier move rmediation active → google-stable
  → Pre-flight checks
  → Waits for current sync to complete
  → Moves files
  → Monitors sync progress
  → Verifies sync completion
  → Updates project index
  → Creates local symlink (optional)

tier move --wait-for-sync    # Wait for sync before proceeding
tier move --no-sync          # Move without waiting
tier move --background       # Move and monitor in background
```

**Priority**: Low-Medium
**Complexity**: High
**Dependencies**: Cloud sync APIs, project index
**Estimated Effort**: 5-7 days

---

## 8. Advanced Search & Filtering 🔍

### Proposed Solutions

#### A. Global Project Search (`pj-search` command)

**Search across all projects:**
```bash
pj-search "mediation formula"
  → Searches all indexed projects
  → Groups results by project
  → Shows context (file, line number, match)
  → Opens in fzf for selection and navigation

pj-search --code "bootstrap"        # Code only
pj-search --docs "tutorial"         # Docs only
pj-search --type rpkg "test"        # R packages only
pj-search --tier active "TODO"      # Active tier only
pj-search --recent "formula"        # Recently modified files only
```

**Output:**
```
Searching across 10 projects for "mediation formula"...

rmediation (R Package)
  R/calculate_mediation.R:45
    mediation_formula <- as.formula(...)

  vignettes/tutorial.Rmd:123
    The mediation formula follows the approach of...

mediationverse (R Package)
  README.md:34
    ...uses the standard mediation formula...

[Press Enter to open, Tab to multi-select]
```

#### B. Intelligent File Finder (`ff` command)

**Enhanced file finding with metadata:**
```bash
ff test_calculate
  → Finds: tests/testthat/test-calculate.R
  → Shows metadata:
    - Last modified: 2 days ago
    - Last commit: "Add edge case tests"
    - Size: 2.3 KB
    - Test coverage: 95%
  → Actions available:
    [e] Edit
    [v] View
    [r] Run tests
    [c] Show coverage
    [h] Git history

ff --recent          # Recently modified files (7 days)
ff --large           # Large files (>1MB)
ff --old             # Old files (>6 months not modified)
ff --orphan          # Files not tracked in git
ff --duplicate       # Duplicate files (by hash)
```

**Priority**: Medium
**Complexity**: Medium
**Dependencies**: ripgrep, fzf, project index
**Estimated Effort**: 3-4 days

---

## 9. Project Environment Management 🌍

### Proposed Solutions

#### A. Project Environment Profiles

**Auto-loaded per-project environments:**

`.project-env` file in project root:
```bash
# Environment variables
export RENV_ACTIVE=TRUE
export R_LIBS_USER=$PWD/renv/library
export PROJECT_TIER=active
export QUARTO_PROFILE=manuscript

# Project-specific aliases
alias build='Rscript -e "pkgdown::build_site()"'
alias deploy='quarto publish gh-pages'

# Project-specific functions
quick_test() {
    rtest1 "$1"
}
```

**Commands:**
```bash
env show          # Show current project environment
env edit          # Edit .project-env in $EDITOR
env reload        # Reload environment
env template      # Create .project-env from template
```

**Auto-load on directory change:**
```bash
_load_project_env() {
    [[ -f ".project-env" ]] && source ".project-env"
}

chpwd_functions+=(_load_project_env)
```

#### B. Tool Version Management

**Per-project tool versions:**

`.tool-versions` file:
```
R 4.3.2
quarto 1.4.550
python 3.11.5
node 20.10.0
```

**Commands:**
```bash
tools check       # Check if correct versions active
tools install     # Install missing versions
tools switch      # Switch to project versions
tools list        # List required versions
```

**Integration with version managers:**
- R: Use `Rswitch` or `rig`
- Python: Use `pyenv`
- Node: Use `nvm`
- Quarto: Use version manager

**Priority**: Low-Medium
**Complexity**: Medium
**Dependencies**: Version managers (pyenv, nvm, etc.)
**Estimated Effort**: 3-4 days

---

## 10. Productivity Enhancements ⚡

### Proposed Solutions

#### A. Quick Open (`o` command)

**Fast file opening with smart matching:**
```bash
o README          # Opens README.md
o DESC            # Opens DESCRIPTION
o test calc       # Opens test file matching 'calc'
o @r utils        # Opens R/utils.R (using bookmark)

# Fuzzy matching:
o test            # If multiple matches, shows fzf
o .               # Opens current directory in file manager
```

**Implementation:**
```bash
o() {
    local query="$1"

    # Smart file resolution
    local file=$(find_file_smart "$query")

    if [[ -n "$file" ]]; then
        $EDITOR "$file"
    else
        # Fuzzy search
        local file=$(fd . --type f | fzf --query="$query" --select-1)
        [[ -n "$file" ]] && $EDITOR "$file"
    fi
}
```

#### B. Recent Files (`recent` command)

**Track and access recently used files:**
```bash
recent                # Show recently edited files
recent --open         # Open in fzf, select to edit
recent --clean        # Clear recent list
recent --export       # Export list
```

**Tracking:**
```bash
# Hook into editor
_track_file_open() {
    echo "$(date +%s)|$PWD/$1" >> ~/.cache/zsh-recent-files
}

# Wrapper for $EDITOR
edit() {
    _track_file_open "$1"
    $EDITOR "$@"
}

alias vim='edit'
alias nvim='edit'
alias code='edit'
```

#### C. Project Session Management (`session` command)

**Save and restore project sessions:**
```bash
session save                # Save current session
session save my-analysis    # Save with name
session restore             # Restore last session
session restore my-analysis # Restore specific session
session list                # List all saved sessions
session delete my-analysis  # Delete session
```

**Session includes:**
- Current directory
- Open files (list)
- Git branch
- Terminal tabs/panes (tmux/iTerm)
- Environment variables

**Implementation:**
```bash
# Session file: ~/.cache/zsh-sessions/rmediation-2025-12-07.json
{
    "name": "rmediation",
    "timestamp": "2025-12-07T15:30:00",
    "directory": "~/R-packages/active/rmediation",
    "branch": "dev",
    "files": [
        "R/calculate_mediation.R",
        "tests/testthat/test-calculate_mediation.R",
        "README.md"
    ],
    "env": {
        "RENV_ACTIVE": "TRUE"
    }
}
```

**Priority**: Medium
**Complexity**: Medium
**Dependencies**: JSON parsing (jq), editor integration
**Estimated Effort**: 3-4 days

---

## Implementation Roadmap

### Phase 1: Quick Wins (v1.4) - 1-2 weeks
**Focus**: High-impact, low-complexity features

1. ✅ Smart Project Bookmarks (`@r`, `@test`, etc.)
2. ✅ Unified Project Launcher (`pj` command)
3. ✅ Project Index System
4. ✅ Context-Aware File Finder (`f` command)
5. ✅ Quick Open (`o` command)
6. ✅ Enhanced File Templates (`new` command)

**Deliverables:**
- New commands: `pj`, `f`, `o`, `new` (enhanced)
- Auto-bookmarks on project entry
- Project index database
- Basic context loading

### Phase 2: High Impact (v1.5) - 2-3 weeks
**Focus**: Multi-project and organization

1. ✅ Project Status Dashboard (`pj-status`)
2. ✅ Multi-Project Operations (`pj-run`)
3. ✅ Tier Migration Helpers (`tier` command)
4. ✅ File Organization (`organize` command)
5. ✅ Project Templates (enhanced `pj-new`)
6. ✅ Global Project Search (`pj-search`)

**Deliverables:**
- New commands: `pj-status`, `pj-run`, `tier`, `organize`, `pj-search`
- Bulk operations framework
- Organization rules engine
- Search across projects

### Phase 3: Advanced (v1.6) - 3-4 weeks
**Focus**: Automation and advanced features

1. ✅ File Watching (`watch` command)
2. ✅ Auto-commit System
3. ✅ Cloud Sync Optimization
4. ✅ Session Management
5. ✅ Recent Files Tracking
6. ✅ Advanced Search & Filtering

**Deliverables:**
- New commands: `watch`, `auto-commit`, `sync-status`, `session`, `recent`, `ff`
- File watching system
- Auto-commit with smart messages
- Session save/restore
- Cloud sync integration

---

## Architecture Overview

### New Components

```
zsh-claude-workflow/
├── lib/
│   ├── project-index.sh           # 🆕 Project indexing system
│   ├── project-launcher.sh        # 🆕 Project switching & context
│   ├── file-navigation.sh         # 🆕 Smart file navigation
│   ├── file-organization.sh       # 🆕 File organization & archival
│   ├── multi-project.sh           # 🆕 Multi-project operations
│   ├── file-templates.sh          # 🆕 Template system
│   ├── file-watcher.sh            # 🆕 File watching system
│   ├── sync-manager.sh            # 🆕 Cloud sync management
│   ├── search-engine.sh           # 🆕 Global search
│   ├── session-manager.sh         # 🆕 Session management
│   └── environment-manager.sh     # 🆕 Project environments
│
├── commands/
│   ├── pj                         # 🆕 Project launcher
│   ├── pj-index                   # 🆕 Project index management
│   ├── pj-run                     # 🆕 Multi-project operations
│   ├── pj-status                  # 🆕 Project status dashboard
│   ├── pj-search                  # 🆕 Global project search
│   ├── f                          # 🆕 Context-aware file finder
│   ├── o                          # 🆕 Quick open
│   ├── ff                         # 🆕 Intelligent file finder
│   ├── new                        # 🆕 Smart file creation
│   ├── organize                   # 🆕 File organization
│   ├── tier                       # 🆕 Tier management
│   ├── watch                      # 🆕 File watcher
│   ├── auto-commit                # 🆕 Auto-commit system
│   ├── sync-status                # 🆕 Cloud sync status
│   ├── session                    # 🆕 Session management
│   ├── recent                     # 🆕 Recent files
│   └── env                        # 🆕 Environment management
│
├── templates/
│   ├── rpkg/
│   │   ├── function.R.template
│   │   ├── test.R.template
│   │   ├── vignette.Rmd.template
│   │   └── data.R.template
│   └── quarto/
│       ├── section.qmd.template
│       ├── post.qmd.template
│       └── figure.qmd.template
│
├── cache/
│   ├── .project-index.db          # Project index
│   ├── .recent-files               # Recent file history
│   └── .sessions/                  # Saved sessions
│
└── config/
    ├── organize-rules.yml          # File organization rules
    ├── project-types.yml           # Project type definitions
    └── templates-config.yml        # Template configurations
```

### Integration with Existing v1.3 Features

**Builds on:**
- `project-detector.sh` - Project type detection
- `skill-manager.sh` - Skill activation
- `workflow-dispatcher.sh` - Workflow execution
- `claude-r-dev-bridge.sh` - R package integration

**Extends:**
- Project detection → Project indexing & launcher
- Skill management → Auto-activation on project entry
- Workflow dispatch → Multi-project bulk operations

---

## Technical Considerations

### Performance
- Project index: Keep in-memory cache, rebuild on demand
- File watching: Use efficient tools (entr, fswatch)
- Search: Index project files for faster search
- Lazy loading: Only load libraries when needed

### Compatibility
- macOS primary target (your environment)
- Linux compatibility as secondary
- Use portable zsh features
- Graceful degradation when tools unavailable

### Dependencies
**Required:**
- zsh (already installed)
- fd (already installed)
- ripgrep (already installed)
- fzf (already installed)

**Optional:**
- entr/fswatch (for file watching)
- jq (for JSON parsing in sessions)
- bat (already installed - for previews)
- eza (already installed - for listings)

### Data Storage
- Project index: SQLite or simple text DB
- Recent files: Time-sorted text file
- Sessions: JSON files
- Cache location: `~/.cache/zsh-claude-workflow/`

---

## Success Metrics

### Efficiency Gains
- **Project switching time**: 50% reduction (from ~10s to ~5s)
- **File finding time**: 70% reduction (from ~30s to ~10s)
- **Multi-project operations**: 90% reduction in time
- **Context loading**: Automatic (from manual)

### User Experience
- **Commands learned**: Minimal (intuitive names)
- **Muscle memory**: Leverage existing zsh habits
- **Error recovery**: Graceful failures with helpful messages
- **Documentation**: Inline help for all commands

### Adoption
- **Daily usage**: Track command usage
- **Feature usage**: Most-used vs least-used
- **Pain points**: Identify friction areas
- **Feedback loop**: Continuous improvement

---

## Next Steps

### Immediate Actions
1. **Review & Prioritize**: Which phase to start with?
2. **Prototype**: Build proof-of-concept for 1-2 features
3. **Validate**: Test with real workflows
4. **Iterate**: Refine based on feedback

### Decision Points
1. **Which Phase first?** (A, B, or C)
2. **Storage backend?** (SQLite, text files, or hybrid)
3. **File watching tool?** (entr vs fswatch)
4. **Session format?** (JSON, YAML, or custom)

### Questions for User
1. Most painful parts of current workflow?
2. Most frequent file operations?
3. How often move projects between tiers?
4. Multi-project operations frequency?
5. Preferred keyboard shortcuts?

---

**Status**: Ready for implementation
**Next Review**: After Phase 1 implementation
**Last Updated**: 2025-12-07
