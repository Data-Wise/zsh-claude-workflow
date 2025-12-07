#!/usr/bin/env zsh
# claude-context.sh - Gather Claude context from projects

# Source dependencies
source "${0:A:h}/core.sh"
source "${0:A:h}/project-detector.sh"

# Find all CLAUDE-related files in current directory
find_claude_files() {
    local dir="${1:-$PWD}"
    local files=()

    # Look for various Claude instruction files
    local patterns=(
        "CLAUDE.md"
        "CLAUDE_*.md"
        ".claude/CLAUDE.md"
        ".claude/*.md"
    )

    for pattern in "${patterns[@]}"; do
        local found=(${(f)"$(find "$dir" -maxdepth 2 -name "$pattern" -type f 2>/dev/null)"})
        files+=($found)
    done

    # Print unique files
    printf '%s\n' "${files[@]}" | sort -u
}

# Find .claude settings
find_claude_settings() {
    local dir="${1:-$PWD}"

    if [[ -f "$dir/.claude/settings.local.json" ]]; then
        echo "$dir/.claude/settings.local.json"
    elif [[ -f "$dir/.claude/settings.json" ]]; then
        echo "$dir/.claude/settings.json"
    fi
}

# Get Claude context summary
get_claude_context_summary() {
    local dir="${1:-$PWD}"
    local claude_files=(${(f)"$(find_claude_files "$dir")"})
    local settings_file=$(find_claude_settings "$dir")

    if [[ ${#claude_files[@]} -eq 0 ]] && [[ -z "$settings_file" ]]; then
        return 1
    fi

    # Print summary
    if [[ ${#claude_files[@]} -gt 0 ]]; then
        print_info "Found ${#claude_files[@]} Claude instruction file(s):"
        for file in "${claude_files[@]}"; do
            local rel_path=$(get_relative_path "$file" "$dir")
            echo "  • $rel_path"
        done
    fi

    if [[ -n "$settings_file" ]]; then
        local rel_path=$(get_relative_path "$settings_file" "$dir")
        print_info "Claude settings: $rel_path"
    fi

    return 0
}

# Display primary CLAUDE.md content
show_claude_md() {
    local dir="${1:-$PWD}"
    local claude_md=""

    # Priority: root CLAUDE.md > .claude/CLAUDE.md > first found
    if [[ -f "$dir/CLAUDE.md" ]]; then
        claude_md="$dir/CLAUDE.md"
    elif [[ -f "$dir/.claude/CLAUDE.md" ]]; then
        claude_md="$dir/.claude/CLAUDE.md"
    else
        local files=(${(f)"$(find_claude_files "$dir")"})
        if [[ ${#files[@]} -gt 0 ]]; then
            claude_md="${files[1]}"
        fi
    fi

    if [[ -n "$claude_md" ]] && [[ -f "$claude_md" ]]; then
        print_header "📋 CLAUDE.md"
        echo "File: $(get_relative_path "$claude_md" "$dir")"
        echo ""

        # Use bat if available, otherwise cat
        if command -v bat >/dev/null 2>&1; then
            bat --style=plain --color=always "$claude_md"
        else
            cat "$claude_md"
        fi
        return 0
    else
        print_warning "No CLAUDE.md found in this project"
        return 1
    fi
}

# Get project structure for context
get_project_structure() {
    local dir="${1:-$PWD}"
    local project_type=$(get_project_type "$dir")
    local max_depth="${2:-2}"

    print_header "📁 Project Structure"

    # Use tree if available, otherwise use find
    if command -v tree >/dev/null 2>&1; then
        # Exclude common directories
        tree -L "$max_depth" -I 'node_modules|.git|.Rproj.user|renv|*.Rcheck|docs|_site|*_cache|*_files' "$dir"
    else
        find "$dir" -maxdepth "$max_depth" -type f -o -type d | head -50
    fi
}

# Get git status for context
get_git_context() {
    local dir="${1:-$PWD}"

    if ! is_git_repo; then
        return 1
    fi

    print_header "🔀 Git Status"

    # Current branch
    local branch=$(git branch --show-current 2>/dev/null)
    echo "Branch: $branch"

    # Remote status
    local ahead_behind=$(git rev-list --left-right --count @{u}...HEAD 2>/dev/null)
    if [[ -n "$ahead_behind" ]]; then
        local behind=$(echo "$ahead_behind" | awk '{print $1}')
        local ahead=$(echo "$ahead_behind" | awk '{print $2}')
        echo "Remote: ↓$behind ↑$ahead"
    fi

    echo ""

    # Short status
    git status --short --branch
}

# Get R package specific context
get_rpkg_context() {
    local dir="${1:-$PWD}"

    if ! is_r_package "$dir"; then
        return 1
    fi

    print_header "📦 R Package Info"

    # Package name and version
    local pkg_name=$(grep "^Package:" "$dir/DESCRIPTION" 2>/dev/null | cut -d' ' -f2 | tr -d '\r')
    local version=$(grep "^Version:" "$dir/DESCRIPTION" 2>/dev/null | cut -d' ' -f2 | tr -d '\r')
    echo "Package: $pkg_name"
    echo "Version: $version"

    # Count files
    local r_files=$(ls -1 "$dir/R"/*.R 2>/dev/null | wc -l | xargs)
    local test_files=$(ls -1 "$dir/tests/testthat"/test-*.R 2>/dev/null | wc -l | xargs)
    local rd_files=$(ls -1 "$dir/man"/*.Rd 2>/dev/null | wc -l | xargs)

    echo "R files: $r_files"
    echo "Tests: $test_files"
    echo "Rd files: $rd_files"

    # Check for renv
    if [[ -f "$dir/renv.lock" ]]; then
        echo "renv: ✓ Active"
    fi
}

# Generate full context report
generate_context_report() {
    local dir="${1:-$PWD}"
    local project_type=$(get_project_type "$dir")
    local project_name=$(get_project_name "$dir")
    local storage_location=$(get_storage_location "$dir")
    local storage_tier=$(get_storage_tier "$dir")

    # Header
    local icon=$(get_project_icon "$project_type")
    local type_label=$(get_project_type_label "$project_type")

    print_header "$icon $project_name"
    echo "Type: $type_label"
    echo "Location: $storage_location / $storage_tier"
    echo "Path: $dir"
    echo ""

    # Claude context
    get_claude_context_summary "$dir"
    echo ""

    # Git context
    if is_git_repo; then
        get_git_context "$dir"
        echo ""
    fi

    # Type-specific context
    case "$project_type" in
        rpkg)
            get_rpkg_context "$dir"
            echo ""
            ;;
    esac
}

# Functions are available when this file is sourced
# No need to export in zsh
