#!/usr/bin/env zsh
# workflow-dispatcher.sh - Universal workflow dispatcher for zsh-claude-workflow

# ============================================
# WORKFLOW DETECTION
# ============================================

# Get available workflows for a project type
get_available_workflows() {
    local project_type="${1:-unknown}"
    local workflows_dir="${SCRIPT_DIR:-$(dirname ${0:A})/../workflows}"
    local workflow_type_dir="$workflows_dir/$project_type"

    if [[ ! -d "$workflow_type_dir" ]]; then
        return 1
    fi

    # List all .yml files in the workflow type directory
    local workflows=()
    for workflow_file in "$workflow_type_dir"/*.yml(N); do
        if [[ -f "$workflow_file" ]]; then
            workflows+=($(basename "$workflow_file" .yml))
        fi
    done

    if [[ ${#workflows[@]} -eq 0 ]]; then
        return 1
    fi

    echo "${workflows[@]}"
    return 0
}

# Find workflow file for project type and workflow name
find_workflow_file() {
    local project_type="$1"
    local workflow_name="$2"
    local workflows_dir="${SCRIPT_DIR:-$(dirname ${0:A})/../workflows}"

    # Check project-specific workflow first
    local project_workflow=".claude/workflows/${workflow_name}.yml"
    if [[ -f "$project_workflow" ]]; then
        echo "$project_workflow"
        return 0
    fi

    # Check default workflows
    local default_workflow="$workflows_dir/$project_type/${workflow_name}.yml"
    if [[ -f "$default_workflow" ]]; then
        echo "$default_workflow"
        return 0
    fi

    return 1
}

# ============================================
# YAML PARSING (Lightweight)
# ============================================

# Parse workflow YAML and extract steps
parse_workflow_yaml() {
    local workflow_file="$1"

    if [[ ! -f "$workflow_file" ]]; then
        print_error "Workflow file not found: $workflow_file"
        return 1
    fi

    # Simple YAML parser for our workflow format
    # We'll extract: name, steps (name, command, description)
    local in_steps=false
    local step_count=0

    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue

        # Check for steps section
        if [[ "$line" =~ ^steps: ]]; then
            in_steps=true
            continue
        fi

        # Parse step items
        if $in_steps; then
            # New step starts with "  - name:"
            if [[ "$line" =~ ^[[:space:]]{2}-[[:space:]]name:[[:space:]](.+)$ ]]; then
                ((step_count++))
                local step_name="${match[1]}"
                echo "STEP_${step_count}_NAME=$step_name"

            # Command
            elif [[ "$line" =~ ^[[:space:]]{4}command:[[:space:]](.+)$ ]]; then
                echo "STEP_${step_count}_COMMAND=${match[1]}"

            # Description
            elif [[ "$line" =~ ^[[:space:]]{4}description:[[:space:]](.+)$ ]]; then
                echo "STEP_${step_count}_DESCRIPTION=${match[1]}"

            # Type (optional)
            elif [[ "$line" =~ ^[[:space:]]{4}type:[[:space:]](.+)$ ]]; then
                echo "STEP_${step_count}_TYPE=${match[1]}"
            fi
        fi

        # Check if we're leaving steps section (new top-level key)
        if $in_steps && [[ "$line" =~ ^[a-z]+: ]]; then
            in_steps=false
        fi
    done < "$workflow_file"

    echo "STEP_COUNT=$step_count"
}

# ============================================
# WORKFLOW EXECUTION
# ============================================

# Execute a single workflow step
execute_workflow_step() {
    local step_name="$1"
    local command="$2"
    local step_type="${3:-shell}"
    local description="$4"

    print_header "$step_name"

    if [[ -n "$description" ]]; then
        print_info "$description"
        echo ""
    fi

    case "$step_type" in
        shell)
            # Execute shell command directly
            eval "$command"
            ;;
        r-script)
            # Execute R script
            Rscript -e "$command"
            ;;
        function)
            # Call zsh function
            $command
            ;;
        *)
            print_warning "Unknown step type: $step_type"
            eval "$command"
            ;;
    esac

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        print_success "✓ $step_name completed"
        echo ""
        return 0
    else
        print_error "✗ $step_name failed (exit code: $exit_code)"
        echo ""
        return 1
    fi
}

# Run a complete workflow
run_workflow() {
    local workflow_file="$1"
    local continue_on_error="${2:-false}"

    print_header "Running Workflow"
    echo ""

    # Parse workflow
    local workflow_data=$(parse_workflow_yaml "$workflow_file")

    if [[ -z "$workflow_data" ]]; then
        print_error "Failed to parse workflow file"
        return 1
    fi

    # Load workflow data into associative arrays
    eval "$workflow_data"

    if [[ -z "$STEP_COUNT" || "$STEP_COUNT" -eq 0 ]]; then
        print_warning "No steps found in workflow"
        return 1
    fi

    print_info "Found $STEP_COUNT steps"
    echo ""

    # Execute each step
    local failed_steps=0
    for ((i=1; i<=STEP_COUNT; i++)); do
        local step_name_var="STEP_${i}_NAME"
        local step_command_var="STEP_${i}_COMMAND"
        local step_type_var="STEP_${i}_TYPE"
        local step_desc_var="STEP_${i}_DESCRIPTION"

        local step_name="${(P)step_name_var}"
        local step_command="${(P)step_command_var}"
        local step_type="${(P)step_type_var:-shell}"
        local step_desc="${(P)step_desc_var}"

        if [[ -z "$step_command" ]]; then
            print_warning "Skipping step $i: no command defined"
            continue
        fi

        execute_workflow_step "$step_name" "$step_command" "$step_type" "$step_desc"

        if [[ $? -ne 0 ]]; then
            ((failed_steps++))

            if [[ "$continue_on_error" != "true" ]]; then
                print_error "Workflow aborted due to failure"
                return 1
            fi
        fi
    done

    # Summary
    echo ""
    print_header "Workflow Summary"

    local successful=$((STEP_COUNT - failed_steps))

    if [[ $failed_steps -eq 0 ]]; then
        print_success "✓ All $STEP_COUNT steps completed successfully!"
        return 0
    else
        print_warning "⚠ Completed with errors: $successful/$STEP_COUNT steps successful"
        return 1
    fi
}

# ============================================
# WORKFLOW DISPLAY
# ============================================

# Show workflow information
show_workflow_info() {
    local workflow_file="$1"

    if [[ ! -f "$workflow_file" ]]; then
        print_error "Workflow file not found: $workflow_file"
        return 1
    fi

    # Extract workflow name and description
    local workflow_name=$(grep "^name:" "$workflow_file" | sed 's/name: //')
    local workflow_type=$(grep "^type:" "$workflow_file" | sed 's/type: //')

    print_header "Workflow: $workflow_name"

    if [[ -n "$workflow_type" ]]; then
        echo "${fg[cyan]}Type:${reset_color} $workflow_type"
    fi

    echo ""
    print_info "Steps:"
    echo ""

    # Parse and display steps
    local workflow_data=$(parse_workflow_yaml "$workflow_file")
    eval "$workflow_data"

    for ((i=1; i<=STEP_COUNT; i++)); do
        local step_name_var="STEP_${i}_NAME"
        local step_desc_var="STEP_${i}_DESCRIPTION"

        local step_name="${(P)step_name_var}"
        local step_desc="${(P)step_desc_var}"

        echo "  ${fg[yellow]}$i.${reset_color} ${fg[green]}$step_name${reset_color}"

        if [[ -n "$step_desc" ]]; then
            echo "     $step_desc"
        fi
    done

    echo ""
}

# List all available workflows for current project
list_workflows() {
    local project_type="$1"

    print_header "Available Workflows"
    echo ""

    local workflows=$(get_available_workflows "$project_type")

    if [[ -z "$workflows" ]]; then
        print_warning "No workflows found for project type: $project_type"
        return 1
    fi

    echo "${fg[cyan]}Project Type:${reset_color} $project_type"
    echo ""

    for workflow in ${=workflows}; do
        local workflow_file=$(find_workflow_file "$project_type" "$workflow")

        if [[ -n "$workflow_file" ]]; then
            local workflow_name=$(grep "^name:" "$workflow_file" 2>/dev/null | sed 's/name: //')

            if [[ -n "$workflow_name" ]]; then
                echo "  ${fg[green]}$workflow${reset_color} - $workflow_name"
            else
                echo "  ${fg[green]}$workflow${reset_color}"
            fi
        fi
    done

    echo ""
    print_info "Run with: ${fg[yellow]}workflow-run <name>${reset_color}"
    echo ""
}

# ============================================
# HELPER FUNCTIONS
# ============================================

# Check if workflow exists
workflow_exists() {
    local project_type="$1"
    local workflow_name="$2"

    local workflow_file=$(find_workflow_file "$project_type" "$workflow_name")
    [[ -n "$workflow_file" ]]
}
