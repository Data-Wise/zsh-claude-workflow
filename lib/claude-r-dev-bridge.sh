#!/usr/bin/env zsh
# claude-r-dev-bridge.sh - Bridge to claude-r-dev project for R package configuration

# ============================================
# CLAUDE-R-DEV DETECTION
# ============================================

# Get claude-r-dev installation directory
get_claude_r_dev_dir() {
    # Check common locations
    local locations=(
        "$HOME/dev-tools/claude-r-dev"
        "$HOME/code/claude-r-dev"
        "$HOME/.local/claude-r-dev"
    )

    for dir in "${locations[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "$dir"
            return 0
        fi
    done

    return 1
}

# Check if claude-r-dev is installed
has_claude_r_dev() {
    local claude_r_dev_dir=$(get_claude_r_dev_dir)
    [[ -n "$claude_r_dev_dir" ]]
}

# Get claude-r-dev installer script
get_claude_r_dev_installer() {
    local claude_r_dev_dir=$(get_claude_r_dev_dir)

    if [[ -z "$claude_r_dev_dir" ]]; then
        return 1
    fi

    local installer="$claude_r_dev_dir/scripts/install.sh"

    if [[ -f "$installer" ]]; then
        echo "$installer"
        return 0
    fi

    return 1
}

# ============================================
# PROFILE MANAGEMENT
# ============================================

# Get available claude-r-dev profiles
list_claude_r_dev_profiles() {
    local claude_r_dev_dir=$(get_claude_r_dev_dir)

    if [[ -z "$claude_r_dev_dir" ]]; then
        return 1
    fi

    local profiles_dir="$claude_r_dev_dir/profiles"

    if [[ ! -d "$profiles_dir" ]]; then
        return 1
    fi

    local profiles=()
    for profile_dir in "$profiles_dir"/*(N/); do
        local profile_name=$(basename "$profile_dir")
        profiles+=("$profile_name")
    done

    if [[ ${#profiles[@]} -eq 0 ]]; then
        return 1
    fi

    echo "${profiles[@]}"
    return 0
}

# Get profile description
get_profile_description() {
    local profile_name="$1"
    local claude_r_dev_dir=$(get_claude_r_dev_dir)

    if [[ -z "$claude_r_dev_dir" ]]; then
        return 1
    fi

    local profile_claude="$claude_r_dev_dir/profiles/$profile_name/CLAUDE.md"

    if [[ ! -f "$profile_claude" ]]; then
        return 1
    fi

    # Extract first line after "# " header
    grep -m 1 "^>" "$profile_claude" | sed 's/^> //'
}

# Get recommended profile for R package type
get_recommended_profile() {
    local pkg_type="$1"

    case "$pkg_type" in
        statistical)
            echo "base statistical-methods"
            ;;
        data-analysis)
            echo "base data-analysis"
            ;;
        shiny)
            echo "base shiny"
            ;;
        *)
            echo "base"
            ;;
    esac
}

# ============================================
# INSTALLATION
# ============================================

# Install claude-r-dev to R package
install_claude_r_dev_to_package() {
    local package_dir="$1"
    local profiles="$2"
    local force="${3:-false}"

    if [[ ! -d "$package_dir" ]]; then
        print_error "Package directory not found: $package_dir"
        return 1
    fi

    if [[ ! -f "$package_dir/DESCRIPTION" ]]; then
        print_error "Not an R package directory (no DESCRIPTION file)"
        return 1
    fi

    # Check if claude-r-dev is installed
    if ! has_claude_r_dev; then
        print_error "claude-r-dev not found"
        print_info "Install from: https://github.com/Data-Wise/claude-r-dev"
        print_info "Or clone to: ~/dev-tools/claude-r-dev"
        return 1
    fi

    local installer=$(get_claude_r_dev_installer)

    if [[ -z "$installer" ]]; then
        print_error "claude-r-dev installer not found"
        return 1
    fi

    print_header "Installing claude-r-dev"
    echo ""

    print_info "Package: $(basename "$package_dir")"
    print_info "Profiles: $profiles"
    echo ""

    # Check if already installed
    if [[ -d "$package_dir/.claude" ]]; then
        if [[ "$force" != "true" ]]; then
            print_warning "claude-r-dev already installed in package"
            print_info "Use --force to reinstall"
            return 1
        else
            print_info "Forcing reinstallation..."
        fi
    fi

    # Run installer
    local install_cmd="$installer --profiles $profiles --target $package_dir"

    if [[ "$force" == "true" ]]; then
        install_cmd="$install_cmd --force"
    fi

    print_info "Running: $install_cmd"
    echo ""

    eval "$install_cmd"

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        echo ""
        print_success "✓ claude-r-dev installed successfully"
        return 0
    else
        echo ""
        print_error "Installation failed (exit code: $exit_code)"
        return 1
    fi
}

# ============================================
# CONFIGURATION CHECK
# ============================================

# Check if package has claude-r-dev installed
has_claude_r_dev_config() {
    local dir="${1:-$PWD}"

    [[ -d "$dir/.claude" ]] && \
    [[ -f "$dir/.claude/CLAUDE.md" ]] && \
    [[ -f "$dir/.claude/settings.json" ]]
}

# Get installed claude-r-dev profiles
get_installed_profiles() {
    local dir="${1:-$PWD}"

    if ! has_claude_r_dev_config "$dir"; then
        return 1
    fi

    # Look for profile markers in CLAUDE.md
    local claude_md="$dir/.claude/CLAUDE.md"

    # Extract profiles from "Active Profiles" section
    local profiles=$(grep -A 10 "^## Active Profiles" "$claude_md" 2>/dev/null | \
                     grep "^- " | \
                     sed 's/^- \*\*//' | \
                     sed 's/\*\*.*//' | \
                     tr '\n' ' ')

    if [[ -n "$profiles" ]]; then
        echo "$profiles"
        return 0
    fi

    return 1
}

# ============================================
# INTEGRATION HELPERS
# ============================================

# Show claude-r-dev status for package
show_claude_r_dev_status() {
    local dir="${1:-$PWD}"

    print_header "claude-r-dev Status"
    echo ""

    # Check if claude-r-dev system is available
    if has_claude_r_dev; then
        local claude_r_dev_dir=$(get_claude_r_dev_dir)
        print_success "✓ claude-r-dev found at: $claude_r_dev_dir"
        echo ""

        # List available profiles
        local profiles=$(list_claude_r_dev_profiles)

        if [[ -n "$profiles" ]]; then
            echo "${fg[cyan]}Available profiles:${reset_color}"

            for profile in ${=profiles}; do
                local desc=$(get_profile_description "$profile")

                if [[ -n "$desc" ]]; then
                    echo "  ${fg[green]}$profile${reset_color} - $desc"
                else
                    echo "  ${fg[green]}$profile${reset_color}"
                fi
            done

            echo ""
        fi
    else
        print_warning "claude-r-dev not found"
        print_info "Install from: https://github.com/Data-Wise/claude-r-dev"
        echo ""
    fi

    # Check package configuration
    if has_claude_r_dev_config "$dir"; then
        local installed=$(get_installed_profiles "$dir")

        if [[ -n "$installed" ]]; then
            print_success "✓ Package is configured with profiles:"

            for profile in ${=installed}; do
                echo "  - $profile"
            done
        else
            print_success "✓ Package is configured with claude-r-dev"
        fi
    else
        print_info "Package not yet configured with claude-r-dev"
        print_info "Run: ${fg[yellow]}rpkg-setup${reset_color} to configure"
    fi

    echo ""
}

# Get integration suggestions
suggest_integration() {
    local dir="${1:-$PWD}"
    local project_type="${2:-unknown}"

    # If already configured, no suggestions needed
    if has_claude_r_dev_config "$dir"; then
        return 0
    fi

    print_info "💡 Integration Suggestions:"
    echo ""

    if [[ "$project_type" == "rpkg" ]]; then
        # Determine package type
        local pkg_type=$(get_rpkg_workflow_type "$dir")
        local recommended=$(get_recommended_profile "$pkg_type")

        echo "  ${fg[cyan]}Recommended setup for $pkg_type package:${reset_color}"
        echo "  ${fg[yellow]}rpkg-setup $(basename "$dir") --type $pkg_type${reset_color}"
        echo ""

        echo "  ${fg[cyan]}This will install profiles:${reset_color}"

        for profile in ${=recommended}; do
            local desc=$(get_profile_description "$profile")

            if [[ -n "$desc" ]]; then
                echo "    - $profile: $desc"
            else
                echo "    - $profile"
            fi
        done

        echo ""
    fi
}

# ============================================
# PROFILE UPDATES
# ============================================

# Check for profile updates
check_profile_updates() {
    local dir="${1:-$PWD}"

    if ! has_claude_r_dev_config "$dir"; then
        return 1
    fi

    local claude_r_dev_dir=$(get_claude_r_dev_dir)

    if [[ -z "$claude_r_dev_dir" ]]; then
        return 1
    fi

    # Get installed profile versions (if available)
    local package_claude="$dir/.claude/CLAUDE.md"
    local installed_version=$(grep "^Version:" "$package_claude" 2>/dev/null | head -1 | sed 's/Version: //')

    # Compare with latest version in claude-r-dev
    # (This is a simple check - could be enhanced)

    print_info "Profile update check not yet implemented"
    print_info "To update manually, run the installer again with --force"

    return 0
}
