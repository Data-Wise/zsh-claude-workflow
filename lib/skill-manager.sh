#!/usr/bin/env zsh
# skill-manager.sh - Claude skill management for zsh-claude-workflow

# ============================================
# SKILL LOCATIONS
# ============================================

# Get user-level skills directory
get_user_skills_dir() {
    echo "$HOME/.claude/skills"
}

# Get project-level skills directory
get_project_skills_dir() {
    local dir="${1:-$PWD}"
    echo "$dir/.claude/skills"
}

# Get skill templates directory
get_skill_templates_dir() {
    local script_dir="${SCRIPT_DIR:-$(dirname ${0:A})}"
    echo "$script_dir/../skills/templates"
}

# ============================================
# SKILL DETECTION
# ============================================

# List available user-level skills
list_user_skills() {
    local skills_dir=$(get_user_skills_dir)

    if [[ ! -d "$skills_dir" ]]; then
        return 1
    fi

    # Find all .md files and symlinks
    local skills=()
    for skill_file in "$skills_dir"/*.md(N); do
        if [[ -f "$skill_file" || -L "$skill_file" ]]; then
            local skill_name=$(basename "$skill_file" .md)
            skills+=("$skill_name")
        fi
    done

    if [[ ${#skills[@]} -eq 0 ]]; then
        return 1
    fi

    echo "${skills[@]}"
    return 0
}

# List active project skills
list_project_skills() {
    local dir="${1:-$PWD}"
    local skills_dir=$(get_project_skills_dir "$dir")

    if [[ ! -d "$skills_dir" ]]; then
        return 1
    fi

    local skills=()
    for skill_file in "$skills_dir"/*.md(N); do
        if [[ -f "$skill_file" || -L "$skill_file" ]]; then
            local skill_name=$(basename "$skill_file" .md)
            skills+=("$skill_name")
        fi
    done

    if [[ ${#skills[@]} -eq 0 ]]; then
        return 1
    fi

    echo "${skills[@]}"
    return 0
}

# Get recommended skills for project type
get_recommended_skills() {
    local project_type="$1"

    case "$project_type" in
        rpkg|r-package)
            echo "r-package-development zsh-environment"
            ;;
        quarto-manuscript)
            echo "manuscript-writing-guide doc-management"
            ;;
        quarto-website|quarto-blog)
            echo "doc-management"
            ;;
        research)
            echo "statistical-simulation-guide r-simulation-config"
            ;;
        *)
            echo ""
            ;;
    esac
}

# ============================================
# SKILL ACTIVATION
# ============================================

# Activate a skill for the current project (via symlink)
activate_skill() {
    local skill_name="$1"
    local dir="${2:-$PWD}"
    local force="${3:-false}"

    local user_skills_dir=$(get_user_skills_dir)
    local project_skills_dir=$(get_project_skills_dir "$dir")

    # Check if user-level skill exists
    local user_skill="$user_skills_dir/${skill_name}.md"

    if [[ ! -f "$user_skill" && ! -L "$user_skill" ]]; then
        print_error "Skill not found: $skill_name"
        print_info "Available skills:"
        local available=$(list_user_skills)
        for skill in ${=available}; do
            echo "  - $skill"
        done
        return 1
    fi

    # Create project skills directory if needed
    mkdir -p "$project_skills_dir"

    # Create symlink
    local project_skill="$project_skills_dir/${skill_name}.md"

    if [[ -e "$project_skill" ]]; then
        if [[ "$force" != "true" ]]; then
            print_warning "Skill already active: $skill_name"
            print_info "Use --force to override"
            return 1
        else
            rm -f "$project_skill"
        fi
    fi

    ln -s "$user_skill" "$project_skill"

    if [[ $? -eq 0 ]]; then
        print_success "✓ Activated skill: $skill_name"
        return 0
    else
        print_error "Failed to activate skill"
        return 1
    fi
}

# Deactivate a skill for the current project
deactivate_skill() {
    local skill_name="$1"
    local dir="${2:-$PWD}"

    local project_skills_dir=$(get_project_skills_dir "$dir")
    local project_skill="$project_skills_dir/${skill_name}.md"

    if [[ ! -e "$project_skill" ]]; then
        print_warning "Skill not active: $skill_name"
        return 1
    fi

    rm -f "$project_skill"

    if [[ $? -eq 0 ]]; then
        print_success "✓ Deactivated skill: $skill_name"
        return 0
    else
        print_error "Failed to deactivate skill"
        return 1
    fi
}

# Activate multiple skills at once
activate_skills_batch() {
    local skills=("$@")
    local dir="$PWD"

    local activated=0
    local failed=0

    for skill in "${skills[@]}"; do
        activate_skill "$skill" "$dir" "false"

        if [[ $? -eq 0 ]]; then
            ((activated++))
        else
            ((failed++))
        fi
    done

    echo ""

    if [[ $failed -eq 0 ]]; then
        print_success "✓ Activated $activated skills"
        return 0
    else
        print_warning "Activated $activated skills, $failed failed"
        return 1
    fi
}

# ============================================
# SKILL CREATION
# ============================================

# Create a new project skill from template
create_skill_from_template() {
    local skill_name="$1"
    local template_name="$2"
    local dir="${3:-$PWD}"

    local templates_dir=$(get_skill_templates_dir)
    local template_file="$templates_dir/${template_name}.md"

    if [[ ! -f "$template_file" ]]; then
        print_error "Template not found: $template_name"
        print_info "Available templates:"
        for template in "$templates_dir"/*.md(N); do
            echo "  - $(basename "$template" .md)"
        done
        return 1
    fi

    local project_skills_dir=$(get_project_skills_dir "$dir")
    mkdir -p "$project_skills_dir"

    local skill_file="$project_skills_dir/${skill_name}.md"

    if [[ -f "$skill_file" ]]; then
        print_error "Skill already exists: $skill_name"
        return 1
    fi

    # Copy template and perform substitutions
    local content=$(cat "$template_file")

    # Get project info for substitutions
    local project_name=$(basename "$dir")
    local date=$(date +%Y-%m-%d)

    # Perform substitutions
    content="${content//\{\{PROJECT_NAME\}\}/$project_name}"
    content="${content//\{\{DATE\}\}/$date}"

    # Write skill file
    echo "$content" > "$skill_file"

    print_success "✓ Created skill: $skill_name"
    print_info "Edit at: $skill_file"

    return 0
}

# ============================================
# SKILL DISPLAY
# ============================================

# Show active skills for current project
show_active_skills() {
    local dir="${1:-$PWD}"

    print_header "Active Skills"
    echo ""

    # User-level skills
    local user_skills=$(list_user_skills)

    if [[ -n "$user_skills" ]]; then
        echo "${fg[cyan]}User-level skills (global):${reset_color}"

        for skill in ${=user_skills}; do
            local skill_file="$(get_user_skills_dir)/${skill}.md"

            # Check if it's a symlink
            if [[ -L "$skill_file" ]]; then
                local target=$(readlink "$skill_file")
                echo "  ${fg[yellow]}→${reset_color} ${fg[green]}$skill${reset_color} ${fg[blue]}(symlink)${reset_color}"
            else
                echo "  ${fg[green]}$skill${reset_color}"
            fi
        done

        echo ""
    fi

    # Project-level skills
    local project_skills=$(list_project_skills "$dir")

    if [[ -n "$project_skills" ]]; then
        echo "${fg[cyan]}Project-level skills:${reset_color}"

        for skill in ${=project_skills}; do
            local skill_file="$(get_project_skills_dir "$dir")/${skill}.md"

            # Check if it's a symlink
            if [[ -L "$skill_file" ]]; then
                local target=$(readlink "$skill_file")
                echo "  ${fg[yellow]}→${reset_color} ${fg[green]}$skill${reset_color} ${fg[blue]}(symlink to user-level)${reset_color}"
            else
                echo "  ${fg[green]}$skill${reset_color} ${fg[magenta]}(project-specific)${reset_color}"
            fi
        done

        echo ""
    fi

    if [[ -z "$user_skills" && -z "$project_skills" ]]; then
        print_info "No skills active"
        echo ""

        # Show recommendations
        local project_type=$(get_project_type "$dir")

        if [[ -n "$project_type" ]]; then
            local recommended=$(get_recommended_skills "$project_type")

            if [[ -n "$recommended" ]]; then
                print_info "Recommended skills for $project_type:"

                for skill in ${=recommended}; do
                    echo "  - $skill"
                done

                echo ""
                print_info "Activate with: ${fg[yellow]}skill-activate <skill_name>${reset_color}"
            fi
        fi
    fi
}

# Show skill details
show_skill_info() {
    local skill_name="$1"
    local dir="${2:-$PWD}"

    # Try to find skill
    local skill_file=""

    # Check project-level first
    local project_skill="$(get_project_skills_dir "$dir")/${skill_name}.md"

    if [[ -f "$project_skill" || -L "$project_skill" ]]; then
        skill_file="$project_skill"
    else
        # Check user-level
        local user_skill="$(get_user_skills_dir)/${skill_name}.md"

        if [[ -f "$user_skill" || -L "$user_skill" ]]; then
            skill_file="$user_skill"
        fi
    fi

    if [[ -z "$skill_file" ]]; then
        print_error "Skill not found: $skill_name"
        return 1
    fi

    print_header "Skill: $skill_name"
    echo ""

    # Show file location
    echo "${fg[cyan]}Location:${reset_color} $skill_file"

    # If symlink, show target
    if [[ -L "$skill_file" ]]; then
        local target=$(readlink "$skill_file")
        echo "${fg[cyan]}Target:${reset_color} $target"
    fi

    echo ""

    # Show first few lines (description)
    print_info "Description:"
    echo ""

    head -n 20 "$skill_file" | tail -n +2
    echo ""

    print_info "View full content: ${fg[yellow]}cat $skill_file${reset_color}"
    echo ""
}

# ============================================
# AUTO-ACTIVATION
# ============================================

# Auto-activate recommended skills for project type
auto_activate_skills() {
    local project_type="$1"
    local dir="${2:-$PWD}"
    local dry_run="${3:-false}"

    local recommended=$(get_recommended_skills "$project_type")

    if [[ -z "$recommended" ]]; then
        print_info "No recommended skills for project type: $project_type"
        return 0
    fi

    if [[ "$dry_run" == "true" ]]; then
        print_info "Would activate skills:"

        for skill in ${=recommended}; do
            echo "  - $skill"
        done

        return 0
    fi

    print_info "Auto-activating recommended skills for $project_type..."
    echo ""

    activate_skills_batch ${=recommended}

    return $?
}
