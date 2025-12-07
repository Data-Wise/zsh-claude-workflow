#!/usr/bin/env zsh
# rpkg-integration.sh - R package workflow integration

# ============================================
# R PACKAGE WORKFLOW DETECTION
# ============================================

# Get R package workflow type based on package characteristics
get_rpkg_workflow_type() {
    local dir="${1:-$PWD}"

    if [[ ! -f "$dir/DESCRIPTION" ]]; then
        return 1
    fi

    # Check for statistical methods indicators
    if grep -qE "(mediation|causal|statistical|inference|estimat)" "$dir/DESCRIPTION" 2>/dev/null; then
        echo "statistical"
        return 0
    fi

    # Check for data analysis indicators
    if grep -qE "(visualization|plotting|ggplot|dplyr|tidyverse)" "$dir/DESCRIPTION" 2>/dev/null; then
        echo "data-analysis"
        return 0
    fi

    # Check for Shiny indicators
    if grep -qE "shiny" "$dir/DESCRIPTION" 2>/dev/null || [[ -d "$dir/inst/shiny" ]]; then
        echo "shiny"
        return 0
    fi

    # Default to standard
    echo "standard"
    return 0
}

# ============================================
# R PACKAGE TIER MANAGEMENT
# ============================================

# Determine storage tier from path
get_rpkg_tier() {
    local dir="${1:-$PWD}"

    case "$dir" in
        */R-packages/active/*)
            echo "active"
            ;;
        */R-packages/stable/*)
            echo "stable"
            ;;
        */R-packages/scratch/*)
            echo "scratch"
            ;;
        *GoogleDrive*/R-packages-stable/*)
            echo "google-stable"
            ;;
        *GoogleDrive*/R-packages-archive/*)
            echo "google-archive"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Get tier directory path
get_tier_path() {
    local tier="$1"

    case "$tier" in
        active)
            echo "$HOME/R-packages/active"
            ;;
        stable)
            echo "$HOME/R-packages/stable"
            ;;
        scratch)
            echo "$HOME/R-packages/scratch"
            ;;
        google-stable)
            # Find Google Drive path
            local gdrive=$(echo $HOME/Library/CloudStorage/GoogleDrive-*/My\ Drive 2>/dev/null | head -1)
            if [[ -n "$gdrive" ]]; then
                echo "$gdrive/R-packages-stable"
            else
                return 1
            fi
            ;;
        *)
            return 1
            ;;
    esac
}

# Move package to different tier
move_package_tier() {
    local package_dir="$1"
    local target_tier="$2"

    if [[ ! -d "$package_dir" ]]; then
        print_error "Package directory not found: $package_dir"
        return 1
    fi

    local package_name=$(basename "$package_dir")
    local target_path=$(get_tier_path "$target_tier")

    if [[ -z "$target_path" ]]; then
        print_error "Unknown tier: $target_tier"
        return 1
    fi

    mkdir -p "$target_path"

    print_info "Moving $package_name to $target_tier tier..."

    if mv "$package_dir" "$target_path/"; then
        print_success "✓ Moved to $target_path/$package_name"
        return 0
    else
        print_error "Failed to move package"
        return 1
    fi
}

# ============================================
# INTEGRATION WITH USER'S .ZSHRC FUNCTIONS
# ============================================

# Check if user's R package functions are available
check_rpkg_functions() {
    local missing_functions=()

    # Check for critical functions
    for func in rdev rpkg rtest rdoc rpkgcommit rnewpkg; do
        if ! type "$func" &>/dev/null; then
            missing_functions+=("$func")
        fi
    done

    if [[ ${#missing_functions[@]} -gt 0 ]]; then
        print_warning "Some R package functions are not available:"
        for func in "${missing_functions[@]}"; do
            echo "  - $func"
        done
        echo ""
        print_info "Make sure your .zshrc is loaded"
        return 1
    fi

    return 0
}

# Execute R package function with error handling
exec_rpkg_function() {
    local func_name="$1"
    shift
    local args=("$@")

    if ! type "$func_name" &>/dev/null; then
        print_error "Function not found: $func_name"
        print_info "This function should be defined in your .zshrc"
        return 1
    fi

    # Execute function
    "$func_name" "${args[@]}"
    return $?
}

# ============================================
# R PACKAGE SETUP WORKFLOWS
# ============================================

# Initialize new R package with full setup
initialize_rpkg_full() {
    local package_name="$1"
    local pkg_type="${2:-standard}"
    local tier="${3:-active}"

    print_header "Initializing R Package: $package_name"
    echo ""

    # Step 1: Check if rnewpkg function exists
    if ! type rnewpkg &>/dev/null; then
        print_error "rnewpkg function not found in .zshrc"
        return 1
    fi

    # Step 2: Create package using user's function
    print_info "Step 1/4: Creating package structure..."
    rnewpkg "$package_name"

    if [[ $? -ne 0 ]]; then
        print_error "Failed to create package"
        return 1
    fi

    # The package is created in ~/R-packages/ by rnewpkg
    local package_dir="$HOME/R-packages/$package_name"

    # Step 3: Move to appropriate tier
    if [[ "$tier" != "unknown" ]] && [[ -d "$package_dir" ]]; then
        print_info "Step 2/4: Moving to $tier tier..."

        local tier_path=$(get_tier_path "$tier")

        if [[ -n "$tier_path" ]] && [[ "$package_dir" != "$tier_path/$package_name" ]]; then
            mkdir -p "$tier_path"
            mv "$package_dir" "$tier_path/"
            package_dir="$tier_path/$package_name"
            print_success "✓ Moved to $tier tier"
        fi
    fi

    echo ""

    # Step 4: Show package info
    print_info "Step 3/4: Package created at:"
    echo "  ${fg[green]}$package_dir${reset_color}"
    echo ""

    # Step 5: Next steps
    print_info "Step 4/4: Next steps:"
    echo "  1. ${fg[yellow]}cd $package_dir${reset_color}"
    echo "  2. Edit DESCRIPTION file"
    echo "  3. ${fg[yellow]}rnewfun your_function${reset_color} to create first function"
    echo "  4. ${fg[yellow]}rdev${reset_color} to run full development cycle"
    echo ""

    print_success "✓ Package initialization complete!"

    return 0
}

# ============================================
# R PACKAGE DEVELOPMENT WORKFLOWS
# ============================================

# Run standard R package development cycle
run_rpkg_dev_cycle() {
    local quick="${1:-false}"

    if ! is_r_package "$PWD"; then
        print_error "Not in an R package directory"
        return 1
    fi

    print_header "R Package Development Cycle"
    echo ""

    if [[ "$quick" == "true" ]]; then
        print_info "Running quick cycle (document + test)..."
        echo ""

        # Document
        print_info "Step 1/2: Documenting..."
        exec_rpkg_function rdoc
        [[ $? -ne 0 ]] && return 1

        # Test
        print_info "Step 2/2: Testing..."
        exec_rpkg_function rtest
        [[ $? -ne 0 ]] && return 1

    else
        print_info "Running full cycle (document + test + check)..."
        echo ""

        # Use rdev function if available
        if type rdev &>/dev/null; then
            exec_rpkg_function rdev
            return $?
        else
            # Fallback: run steps manually
            exec_rpkg_function rdoc && \
            exec_rpkg_function rtest && \
            exec_rpkg_function rcheck
            return $?
        fi
    fi

    echo ""
    print_success "✓ Development cycle complete!"
    return 0
}

# Run pre-commit checks
run_rpkg_precommit() {
    local commit_msg="$1"

    if ! is_r_package "$PWD"; then
        print_error "Not in an R package directory"
        return 1
    fi

    print_header "R Package Pre-commit Checks"
    echo ""

    # Check if rpkgcommit function exists
    if type rpkgcommit &>/dev/null; then
        print_info "Using rpkgcommit function..."
        exec_rpkg_function rpkgcommit "$commit_msg"
        return $?
    else
        # Fallback: manual workflow
        print_info "Running manual pre-commit workflow..."

        # Document
        print_info "Step 1/3: Documenting..."
        exec_rpkg_function rdoc
        [[ $? -ne 0 ]] && return 1

        # Test
        print_info "Step 2/3: Testing..."
        exec_rpkg_function rtest
        [[ $? -ne 0 ]] && return 1

        # Style (if styler available)
        if Rscript -e "requireNamespace('styler', quietly = TRUE)" 2>/dev/null; then
            print_info "Step 3/3: Styling..."
            Rscript -e "styler::style_pkg(quiet = TRUE)"
        fi

        # Commit
        if [[ -n "$commit_msg" ]]; then
            print_info "Committing changes..."
            git add .
            git commit -m "$commit_msg"
        fi

        return $?
    fi
}

# ============================================
# R PACKAGE INFORMATION
# ============================================

# Get R package context summary
get_rpkg_context_summary() {
    local dir="${1:-$PWD}"

    if [[ ! -f "$dir/DESCRIPTION" ]]; then
        return 1
    fi

    local pkg_name=$(grep "^Package:" "$dir/DESCRIPTION" | cut -d' ' -f2)
    local version=$(grep "^Version:" "$dir/DESCRIPTION" | cut -d' ' -f2)
    local tier=$(get_rpkg_tier "$dir")
    local workflow_type=$(get_rpkg_workflow_type "$dir")

    echo "PACKAGE_NAME=$pkg_name"
    echo "PACKAGE_VERSION=$version"
    echo "PACKAGE_TIER=$tier"
    echo "WORKFLOW_TYPE=$workflow_type"

    # Count files
    local r_files=$(ls -1 "$dir/R"/*.R 2>/dev/null | wc -l | xargs)
    local test_files=$(ls -1 "$dir/tests/testthat"/test-*.R 2>/dev/null | wc -l | xargs)
    local rd_files=$(ls -1 "$dir/man"/*.Rd 2>/dev/null | wc -l | xargs)

    echo "R_FILES=$r_files"
    echo "TEST_FILES=$test_files"
    echo "RD_FILES=$rd_files"
}

# Display R package summary
show_rpkg_summary() {
    local dir="${1:-$PWD}"

    local context=$(get_rpkg_context_summary "$dir")

    if [[ -z "$context" ]]; then
        print_error "Not an R package directory"
        return 1
    fi

    eval "$context"

    print_header "R Package Summary"
    echo ""

    echo "${fg[cyan]}Package:${reset_color} ${fg[green]}$PACKAGE_NAME${reset_color} v$PACKAGE_VERSION"
    echo "${fg[cyan]}Tier:${reset_color} $PACKAGE_TIER"
    echo "${fg[cyan]}Type:${reset_color} $WORKFLOW_TYPE"
    echo ""

    echo "${fg[cyan]}Files:${reset_color}"
    echo "  R scripts: $R_FILES"
    echo "  Tests: $TEST_FILES"
    echo "  Docs: $RD_FILES"
    echo ""
}
