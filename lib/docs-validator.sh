#!/usr/bin/env zsh
# docs-validator.sh - Documentation validation library for zsh-claude-workflow
#
# Provides functions for:
# - Documentation type detection
# - Version sync checking
# - Badge validation
# - Link validation
# - Build testing
# - GitHub Actions monitoring

# ============================================
# DOCUMENTATION TYPE DETECTION
# ============================================

# Detect documentation type for a project
detect_docs_type() {
    local dir="${1:-$PWD}"

    if [[ -f "$dir/mkdocs.yml" ]]; then
        echo "mkdocs"
    elif [[ -f "$dir/_pkgdown.yml" ]] || [[ -f "$dir/_pkgdown.yaml" ]]; then
        echo "pkgdown"
    elif [[ -f "$dir/_quarto.yml" ]] || [[ -f "$dir/_quarto.yaml" ]]; then
        echo "quarto"
    elif [[ -f "$dir/package.json" ]] && [[ -d "$dir/docs" ]]; then
        echo "npm"
    elif [[ -f "$dir/DESCRIPTION" ]]; then
        echo "rpkg"
    else
        echo "generic"
    fi
}

# Get docs directory for project type
get_docs_dir() {
    local type="${1:-$(detect_docs_type)}"
    local dir="${2:-$PWD}"

    case "$type" in
        mkdocs)
            echo "$dir/docs"
            ;;
        pkgdown)
            echo "$dir/docs"
            ;;
        quarto)
            echo "$dir"
            ;;
        npm)
            echo "$dir/docs"
            ;;
        rpkg)
            echo "$dir/man"
            ;;
        *)
            echo "$dir/docs"
            ;;
    esac
}

# ============================================
# VERSION EXTRACTION
# ============================================

# Extract version from various file types
get_version_from_file() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        return 1
    fi

    local basename="${file:t}"

    case "$basename" in
        package.json)
            if command -v jq >/dev/null 2>&1; then
                jq -r '.version // empty' "$file" 2>/dev/null
            else
                grep '"version"' "$file" | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/'
            fi
            ;;
        DESCRIPTION)
            grep "^Version:" "$file" | sed 's/Version:[[:space:]]*//'
            ;;
        mkdocs.yml|mkdocs.yaml)
            local ver=$(grep "^[[:space:]]*version:" "$file" | head -1 | sed 's/.*version:[[:space:]]*//' | tr -d "\"' " | tr -d '\n')
            # Return nothing if version field is empty
            [[ -n "$ver" ]] && echo "$ver"
            ;;
        *.yml|*.yaml)
            grep "version:" "$file" | head -1 | sed 's/.*version:[[:space:]]*//' | tr -d "\"'"
            ;;
        CLAUDE.md)
            # Look for version in various formats
            # Try "Current Version: v1.3" format first
            local ver=$(grep -E "Current Version.*v?[0-9]" "$file" | head -1 | sed 's/.*[Vv]ersion[^:]*:[[:space:]]*//' | sed 's/^v//' | awk '{print $1}')
            if [[ -z "$ver" ]]; then
                # Try "Version: 1.3" format
                ver=$(grep -E "^[[:space:]]*[Vv]ersion:[[:space:]]*v?[0-9]" "$file" | head -1 | sed 's/.*[Vv]ersion:[[:space:]]*//' | sed 's/^v//')
            fi
            echo "$ver"
            ;;
        NEWS.md|CHANGELOG.md)
            # Extract first version header
            grep -E "^#+[[:space:]]*v?[0-9]+\.[0-9]+" "$file" | head -1 | sed 's/^#*[[:space:]]*//' | sed 's/^v//' | awk '{print $1}'
            ;;
        *.ts|*.js)
            grep -E "version[[:space:]]*[:=][[:space:]]*['\"]" "$file" | head -1 | sed "s/.*version[[:space:]]*[:=][[:space:]]*['\"]\\([^'\"]*\\).*/\\1/"
            ;;
        *)
            return 1
            ;;
    esac
}

# Get list of version files for project type
get_version_files() {
    local type="${1:-$(detect_docs_type)}"
    local dir="${2:-$PWD}"
    local -a files=()

    case "$type" in
        npm)
            [[ -f "$dir/package.json" ]] && files+=("$dir/package.json")
            [[ -f "$dir/src/index.ts" ]] && files+=("$dir/src/index.ts")
            [[ -f "$dir/CLAUDE.md" ]] && files+=("$dir/CLAUDE.md")
            ;;
        rpkg|pkgdown)
            [[ -f "$dir/DESCRIPTION" ]] && files+=("$dir/DESCRIPTION")
            [[ -f "$dir/NEWS.md" ]] && files+=("$dir/NEWS.md")
            [[ -f "$dir/CLAUDE.md" ]] && files+=("$dir/CLAUDE.md")
            ;;
        mkdocs)
            [[ -f "$dir/mkdocs.yml" ]] && files+=("$dir/mkdocs.yml")
            [[ -f "$dir/CLAUDE.md" ]] && files+=("$dir/CLAUDE.md")
            ;;
        quarto)
            [[ -f "$dir/_quarto.yml" ]] && files+=("$dir/_quarto.yml")
            [[ -f "$dir/CLAUDE.md" ]] && files+=("$dir/CLAUDE.md")
            ;;
        *)
            [[ -f "$dir/CLAUDE.md" ]] && files+=("$dir/CLAUDE.md")
            ;;
    esac

    echo "${files[@]}"
}

# Check version sync across files
check_version_sync() {
    local dir="${1:-$PWD}"
    local type="${2:-$(detect_docs_type "$dir")}"
    local -a files=($(get_version_files "$type" "$dir"))
    local -A versions=()
    local primary_version=""
    local all_match=true

    if [[ ${#files[@]} -eq 0 ]]; then
        print_warning "No version files found"
        return 1
    fi

    for file in "${files[@]}"; do
        local version=$(get_version_from_file "$file")
        if [[ -n "$version" ]]; then
            versions[${file:t}]="$version"
            if [[ -z "$primary_version" ]]; then
                primary_version="$version"
            elif [[ "$version" != "$primary_version" ]]; then
                all_match=false
            fi
        fi
    done

    # Output results
    for file version in ${(kv)versions}; do
        if [[ "$version" == "$primary_version" ]]; then
            print_success "$file: $version"
        else
            print_error "$file: $version (expected $primary_version)"
        fi
    done

    if $all_match; then
        return 0
    else
        return 1
    fi
}

# ============================================
# BADGE VALIDATION
# ============================================

# Check badges in README
check_badges() {
    local readme="${1:-README.md}"

    if [[ ! -f "$readme" ]]; then
        print_warning "No README.md found"
        return 1
    fi

    local -a static_badges=()
    local -a dynamic_badges=()
    local -a broken_badges=()

    # Parse badge URLs from README
    while IFS= read -r line; do
        # Match img.shields.io badges
        if [[ "$line" =~ img\.shields\.io ]]; then
            if [[ "$line" =~ badge/v[0-9] ]] || [[ "$line" =~ badge/version-[0-9] ]]; then
                # Static version badge (hardcoded version)
                static_badges+=("$(echo "$line" | grep -oE 'https://img\.shields\.io[^)\"]*')")
            else
                # Dynamic badge
                dynamic_badges+=("$(echo "$line" | grep -oE 'https://img\.shields\.io[^)\"]*')")
            fi
        fi
    done < "$readme"

    # Report findings
    local badge_count=$((${#static_badges[@]} + ${#dynamic_badges[@]}))

    if [[ $badge_count -eq 0 ]]; then
        print_info "No shields.io badges found"
        return 0
    fi

    for badge in "${dynamic_badges[@]}"; do
        print_success "Dynamic badge: ${badge:0:60}..."
    done

    for badge in "${static_badges[@]}"; do
        print_warning "Static version badge: ${badge:0:60}..."
    done

    if [[ ${#static_badges[@]} -gt 0 ]]; then
        print_warning "Consider using dynamic badges for version info"
        return 1
    fi

    return 0
}

# ============================================
# LINK VALIDATION
# ============================================

# Validate internal links in markdown files
validate_links() {
    local docs_dir="${1:-docs}"
    local base_dir="${2:-$PWD}"
    local -a broken_links=()
    local -a valid_links=()
    local check_external="${3:-false}"

    if [[ ! -d "$docs_dir" ]]; then
        print_warning "Docs directory not found: $docs_dir"
        return 1
    fi

    # Find all markdown files
    local -a md_files=()
    while IFS= read -r -d $'\0' file; do
        md_files+=("$file")
    done < <(find "$docs_dir" -name "*.md" -print0 2>/dev/null)

    # Also check README.md
    [[ -f "$base_dir/README.md" ]] && md_files+=("$base_dir/README.md")

    for file in "${md_files[@]}"; do
        local file_dir="${file:h}"

        # Extract markdown links using external script
        local links_raw=""
        local awk_script="$LIB_DIR/../scripts/extract-links.awk"
        if [[ -f "$file" ]]; then
            if [[ -f "$awk_script" ]]; then
                links_raw=$(awk -f "$awk_script" "$file" 2>/dev/null || true)
            else
                # Fallback: simple grep-based extraction (less accurate)
                links_raw=$(grep -Eo 'https?://[^"[:space:]>]+' "$file" 2>/dev/null || true)
            fi
        fi

        while IFS= read -r link; do
            # Skip empty links
            [[ -z "$link" ]] && continue

            # Skip external links unless checking
            if [[ "$link" == http://* ]] || [[ "$link" == https://* ]]; then
                if [[ "$check_external" == "true" ]]; then
                    # Check external link (with timeout)
                    if ! curl -sfL --head --max-time 5 "$link" >/dev/null 2>&1; then
                        broken_links+=("$file -> $link")
                    else
                        valid_links+=("$link")
                    fi
                fi
                continue
            fi

            # Skip anchor-only links
            [[ "$link" == \#* ]] && continue

            # Skip mailto: and tel: links
            [[ "$link" == mailto:* ]] || [[ "$link" == tel:* ]] && continue

            # Resolve relative path
            local target
            if [[ "$link" == /* ]]; then
                target="$base_dir$link"
            else
                target="$file_dir/$link"
            fi

            # Remove anchor from target
            target="${target%%#*}"

            # Check if target exists
            if [[ ! -f "$target" ]] && [[ ! -d "$target" ]]; then
                # Try with .md extension
                if [[ ! -f "${target}.md" ]]; then
                    local line_num=$(grep -n "$link" "$file" 2>/dev/null | head -1 | cut -d: -f1)
                    broken_links+=("${file:t}:${line_num:-?} -> $link")
                else
                    valid_links+=("$link")
                fi
            else
                valid_links+=("$link")
            fi
        done <<< "$links_raw"
    done

    # Report findings
    print_success "${#valid_links[@]} valid links"

    if [[ ${#broken_links[@]} -gt 0 ]]; then
        print_error "${#broken_links[@]} broken links:"
        for link in "${broken_links[@]}"; do
            echo "    • $link"
        done
        return 1
    fi

    return 0
}

# ============================================
# BUILD TESTING
# ============================================

# Run documentation build
run_docs_build() {
    local type="${1:-$(detect_docs_type)}"
    local strict="${2:-false}"

    case "$type" in
        mkdocs)
            if [[ "$strict" == "true" ]]; then
                mkdocs build --strict 2>&1
            else
                mkdocs build 2>&1
            fi
            ;;
        pkgdown)
            Rscript -e 'pkgdown::build_site()' 2>&1
            ;;
        quarto)
            quarto render 2>&1
            ;;
        npm)
            if [[ -f "package.json" ]]; then
                if grep -q '"docs"' package.json; then
                    npm run docs 2>&1
                else
                    print_info "No docs script in package.json"
                    return 0
                fi
            fi
            ;;
        rpkg)
            Rscript -e 'devtools::document()' 2>&1
            ;;
        *)
            print_warning "Unknown docs type: $type"
            return 1
            ;;
    esac
}

# Start preview server
start_preview() {
    local type="${1:-$(detect_docs_type)}"
    local port="${2:-8000}"

    case "$type" in
        mkdocs)
            mkdocs serve -a "localhost:$port" &
            echo $!
            ;;
        pkgdown)
            Rscript -e "servr::httd\('docs', port=$port\)" &
            echo $!
            ;;
        quarto)
            quarto preview --port "$port" &
            echo $!
            ;;
        *)
            if command -v python3 >/dev/null 2>&1; then
                python3 -m http.server "$port" -d docs &
                echo $!
            else
                print_warning "No preview method for type: $type"
                return 1
            fi
            ;;
    esac
}

# Stop preview server
stop_preview() {
    local pid="$1"
    if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
        kill "$pid" 2>/dev/null
        print_info "Preview server stopped"
    fi
}

# ============================================
# GITHUB ACTIONS MONITORING
# ============================================

# Monitor GitHub Actions workflow
monitor_gh_actions() {
    local workflow="${1:-docs.yml}"
    local timeout="${2:-300}"
    local poll_interval="${3:-10}"

    if ! command -v gh >/dev/null 2>&1; then
        print_warning "GitHub CLI (gh) not found"
        return 1
    fi

    local start_time=$(date +%s)

    while true; do
        local jq_status='.[0].status'
        local jq_conclusion='.[0].conclusion'
        local status=$(gh run list --workflow="$workflow" -L 1 --json status -q "$jq_status" 2>/dev/null)

        if [[ "$status" == "completed" ]]; then
            local conclusion=$(gh run list --workflow="$workflow" -L 1 --json conclusion -q "$jq_conclusion" 2>/dev/null)

            if [[ "$conclusion" == "success" ]]; then
                print_success "Workflow completed successfully"
                return 0
            else
                print_error "Workflow failed: $conclusion"
                return 1
            fi
        elif [[ "$status" == "in_progress" || "$status" == "queued" ]]; then
            print_info "Workflow status: $status - waiting..."
        fi

        local current_time=$(date +%s)
        if (( current_time - start_time > timeout )); then
            print_warning "Timeout waiting for workflow"
            return 2
        fi

        sleep "$poll_interval"
    done
}

# ============================================
# DEPLOYMENT
# ============================================

# Deploy documentation
deploy_docs() {
    local type="${1:-$(detect_docs_type)}"

    case "$type" in
        mkdocs)
            mkdocs gh-deploy --force
            ;;
        pkgdown)
            Rscript -e 'pkgdown::deploy_to_branch()' 2>&1
            ;;
        quarto)
            quarto publish gh-pages --no-browser
            ;;
        *)
            print_warning "No deployment method for type: $type"
            return 1
            ;;
    esac
}

# ============================================
# REPORT GENERATION
# ============================================

# Generate validation report
generate_report() {
    local project_name="${1:-$(basename "$PWD")}"
    local type="${2:-$(detect_docs_type)}"
    local output="${3:-docs-check-report.md}"

    cat > "$output" << EOF
## Documentation Check Report

**Project**: $project_name
**Type**: $type
**Date**: $(date '+%Y-%m-%d %H:%M:%S')

### Summary

Run \`docs-check\` for detailed validation results.

---
*Generated by docs-check*
EOF

    print_success "Report saved to $output"
}
