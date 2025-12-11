#!/usr/bin/env zsh
# research-manager.sh - Research project management functions

# ============================================
# RESEARCH PROJECT DETECTION
# ============================================

# Get all research locations
get_research_locations() {
    local locations=()

    # Local research
    [[ -d ~/projects/research ]] && locations+=(~/projects/research)

    # Dropbox research
    [[ -d ~/Dropbox/Research ]] && locations+=(~/Dropbox/Research)

    # Google Drive research
    [[ -d ~/Library/CloudStorage/GoogleDrive-*/My\ Drive/research ]] && \
        locations+=(~/Library/CloudStorage/GoogleDrive-*/My\ Drive/research)

    # OneDrive research
    [[ -d ~/Library/CloudStorage/OneDrive-*/research ]] && \
        locations+=(~/Library/CloudStorage/OneDrive-*/research)
    [[ -d ~/Library/CloudStorage/OneDrive-*/Research ]] && \
        locations+=(~/Library/CloudStorage/OneDrive-*/Research)

    echo "${locations[@]}"
}

# Find all research projects across all locations
find_research_projects() {
    local projects=()

    # Local research
    if [[ -d ~/projects/research ]]; then
        for dir in ~/projects/research/*(N/); do
            local basename="${dir:t}"
            if [[ ! "$basename" =~ "^\." ]]; then
                projects+=("$dir")
            fi
        done
    fi

    # Dropbox research
    if [[ -d ~/Dropbox/Research ]]; then
        for dir in ~/Dropbox/Research/*(N/); do
            local basename="${dir:t}"
            if [[ ! "$basename" =~ "^\." ]] && \
               [[ "$basename" != ".Trash" ]]; then
                projects+=("$dir")
            fi
        done
    fi

    # Google Drive research
    for gd in ~/Library/CloudStorage/GoogleDrive-*/My\ Drive/research(N/); do
        if [[ -d "$gd" ]]; then
            for dir in "$gd"/*(N/); do
                local basename="${dir:t}"
                if [[ ! "$basename" =~ "^\." ]]; then
                    projects+=("$dir")
                fi
            done
        fi
    done

    # OneDrive research
    for od in ~/Library/CloudStorage/OneDrive-*/research(N/) ~/Library/CloudStorage/OneDrive-*/Research(N/); do
        if [[ -d "$od" ]]; then
            for dir in "$od"/*(N/); do
                local basename="${dir:t}"
                if [[ ! "$basename" =~ "^\." ]]; then
                    projects+=("$dir")
                fi
            done
        fi
    done

    # Output each project on a new line for proper parsing
    for project in "${projects[@]}"; do
        echo "$project"
    done
}

# Get project status based on last modification time
get_project_status() {
    local project_dir="$1"
    local now=$(date +%s)
    local mod_time=$(stat -f %m "$project_dir" 2>/dev/null || echo "0")
    local days_ago=$(( (now - mod_time) / 86400 ))

    if [[ $days_ago -lt 14 ]]; then
        echo "active"
    elif [[ $days_ago -lt 90 ]]; then
        echo "recent"
    elif [[ $days_ago -lt 365 ]]; then
        echo "inactive"
    else
        echo "archive"
    fi
}

# Get project category from directory name
get_project_category() {
    local project_dir="$1"
    local basename="${project_dir:t}"
    local parent="${project_dir:h:t}"

    # Check parent directory first
    case "$parent" in
        published|Published) echo "published" ;;
        past|Past|archive|Archive) echo "archive" ;;
        future|Future|planning|Planning) echo "planning" ;;
        active|Active) echo "active" ;;
        in-review|review|Review) echo "in-review" ;;
        collaborations|Collaborations) echo "collaboration" ;;
        *)
            # Check basename patterns
            case "$basename" in
                published|Published) echo "archive" ;;
                past|Past) echo "archive" ;;
                future|Future) echo "planning" ;;
                *) echo "unknown" ;;
            esac
            ;;
    esac
}

# Get project location (local, dropbox, gdrive, onedrive)
get_project_location() {
    local project_dir="$1"

    case "$project_dir" in
        *Dropbox*) echo "dropbox" ;;
        *GoogleDrive*) echo "gdrive" ;;
        *OneDrive*) echo "onedrive" ;;
        */projects/research*) echo "local" ;;
        *) echo "unknown" ;;
    esac
}

# Format time ago string
time_ago() {
    local timestamp="$1"
    local now=$(date +%s)
    local diff=$(( now - timestamp ))
    local days=$(( diff / 86400 ))
    local hours=$(( (diff % 86400) / 3600 ))

    if [[ $days -eq 0 ]]; then
        if [[ $hours -eq 0 ]]; then
            echo "today"
        elif [[ $hours -eq 1 ]]; then
            echo "1 hour ago"
        else
            echo "${hours} hours ago"
        fi
    elif [[ $days -eq 1 ]]; then
        echo "yesterday"
    elif [[ $days -lt 7 ]]; then
        echo "${days} days ago"
    elif [[ $days -lt 30 ]]; then
        local weeks=$(( days / 7 ))
        echo "${weeks} week$( [[ $weeks -gt 1 ]] && echo 's') ago"
    elif [[ $days -lt 365 ]]; then
        local months=$(( days / 30 ))
        echo "${months} month$( [[ $months -gt 1 ]] && echo 's') ago"
    else
        local years=$(( days / 365 ))
        echo "${years} year$( [[ $years -gt 1 ]] && echo 's') ago"
    fi
}

# Get location icon
get_location_icon() {
    local location="$1"
    case "$location" in
        local) echo "💻" ;;
        dropbox) echo "📦" ;;
        gdrive) echo "☁️" ;;
        onedrive) echo "☁️" ;;
        *) echo "📁" ;;
    esac
}

# Get status icon
get_status_icon() {
    local proj_status="$1"
    case "$proj_status" in
        active) echo "●" ;;
        recent) echo "◐" ;;
        inactive) echo "○" ;;
        archive) echo "✓" ;;
        *) echo "?" ;;
    esac
}

# Count files in project
count_project_files() {
    local project_dir="$1"
    local count=0

    if [[ -d "$project_dir" ]]; then
        count=$(find "$project_dir" -type f ! -name ".*" 2>/dev/null | wc -l | tr -d ' ')
    fi

    echo "$count"
}

# ============================================
# DASHBOARD DISPLAY
# ============================================

# Display research dashboard
display_research_dashboard() {
    local projects=("${(@f)$(find_research_projects)}")

    if [[ ${#projects[@]} -eq 0 ]]; then
        print_warning "No research projects found"
        print_info "Searched in:"
        for loc in $(get_research_locations); do
            echo "  - $loc"
        done
        return 1
    fi

    # Categorize projects
    local -A project_data
    local active_projects=()
    local recent_projects=()
    local inactive_projects=()
    local archive_projects=()
    local planning_projects=()
    local published_projects=()

    # Collect project data
    for project in "${projects[@]}"; do
        local basename="${project:t}"
        local proj_status=$(get_project_status "$project")
        local category=$(get_project_category "$project")
        local location=$(get_project_location "$project")
        local mod_time=$(stat -f %m "$project" 2>/dev/null || echo "0")
        local time_str=$(time_ago "$mod_time")
        local file_count=$(count_project_files "$project")

        # Override status with category if category is more specific
        if [[ "$category" == "published" ]] || [[ "$category" == "archive" ]]; then
            proj_status="archive"
        elif [[ "$category" == "planning" ]]; then
            proj_status="planning"
        fi

        # Store project data
        project_data[$project]="$proj_status|$category|$location|$mod_time|$time_str|$file_count"

        # Categorize for display
        case "$proj_status" in
            active) active_projects+=("$project") ;;
            recent) recent_projects+=("$project") ;;
            planning) planning_projects+=("$project") ;;
            inactive) inactive_projects+=("$project") ;;
            archive) archive_projects+=("$project") ;;
        esac

        if [[ "$category" == "published" ]]; then
            published_projects+=("$project")
        fi
    done

    # Display dashboard
    print_header "🔬 RESEARCH DASHBOARD"
    echo

    # Summary statistics
    local total=${#projects[@]}
    local active_count=${#active_projects[@]}
    local recent_count=${#recent_projects[@]}
    local planning_count=${#planning_projects[@]}
    local archive_count=${#archive_projects[@]}

    echo "${fg[cyan]}PORTFOLIO SUMMARY${reset_color}"
    echo "  Total projects: ${fg[yellow]}$total${reset_color}"
    echo "  Active (< 2 weeks): ${fg[green]}$active_count${reset_color}"
    echo "  Recent (< 3 months): ${fg[yellow]}$recent_count${reset_color}"
    echo "  Planning: ${fg[blue]}$planning_count${reset_color}"
    echo "  Archive: ${fg[white]}$archive_count${reset_color}"
    echo

    # Active projects (detailed)
    if [[ ${#active_projects[@]} -gt 0 ]]; then
        echo "${fg[green]}━━━ ACTIVE PROJECTS (Modified < 2 weeks) ━━━${reset_color}"
        echo

        # Sort by modification time (most recent first)
        local sorted_active=("${(@on)active_projects}")
        for project in "${sorted_active[@]}"; do
            local data="${project_data[$project]}"
            local proj_status="${data%%|*}"; data="${data#*|}"
            local category="${data%%|*}"; data="${data#*|}"
            local location="${data%%|*}"; data="${data#*|}"
            local mod_time="${data%%|*}"; data="${data#*|}"
            local time_str="${data%%|*}"; data="${data#*|}"
            local file_count="${data}"

            local basename="${project:t}"
            local loc_icon=$(get_location_icon "$location")
            local status_icon=$(get_status_icon "$proj_status")

            echo "  ${fg[green]}$status_icon${reset_color} ${fg[cyan]}$basename${reset_color}"
            echo "     Location: $loc_icon  ${project}"
            echo "     Modified: ${fg[yellow]}$time_str${reset_color} | Files: $file_count"

            # Check for _next.md
            if [[ -f "$project/_next.md" ]]; then
                local next_action=$(head -3 "$project/_next.md" | tail -1)
                echo "     Next: ${fg[blue]}$next_action${reset_color}"
            fi
            echo
        done
    fi

    # Recent projects (summary)
    if [[ ${#recent_projects[@]} -gt 0 ]]; then
        echo "${fg[yellow]}━━━ RECENT PROJECTS (Modified < 3 months) ━━━${reset_color}"
        for project in "${recent_projects[@]}"; do
            local data="${project_data[$project]}"
            local time_str=$(echo "$data" | cut -d'|' -f5)
            local basename="${project:t}"
            local location=$(echo "$data" | cut -d'|' -f3)
            local loc_icon=$(get_location_icon "$location")

            echo "  ${fg[yellow]}◐${reset_color} ${basename} ${fg[white]}($time_str)${reset_color} $loc_icon"
        done
        echo
    fi

    # Planning projects
    if [[ ${#planning_projects[@]} -gt 0 ]]; then
        echo "${fg[blue]}━━━ PLANNING / FUTURE PROJECTS ━━━${reset_color}"
        for project in "${planning_projects[@]}"; do
            local basename="${project:t}"
            echo "  ${fg[blue]}○${reset_color} ${basename}"
        done
        echo
    fi

    # Archive summary
    if [[ ${#archive_projects[@]} -gt 0 ]]; then
        echo "${fg[white]}━━━ ARCHIVED PROJECTS ━━━${reset_color}"
        echo "  Total: ${#archive_projects[@]} projects"
        if [[ ${#published_projects[@]} -gt 0 ]]; then
            echo "  Published: ${#published_projects[@]} papers"
        fi
        echo
    fi

    # Warnings and recommendations
    echo "${fg[yellow]}⚠ ORGANIZATION STATUS${reset_color}"
    echo

    # Check for scattered projects
    local locations=($(get_research_locations))
    if [[ ${#locations[@]} -gt 1 ]]; then
        echo "  ${fg[red]}!${reset_color} Research is scattered across ${#locations[@]} locations:"
        for loc in "${locations[@]}"; do
            local count=$(echo "${projects[@]}" | tr ' ' '\n' | grep -c "$loc" || echo "0")
            echo "     - $loc (${count} projects)"
        done
        echo
        echo "  ${fg[blue]}💡 Recommendation:${reset_color} Consolidate to ~/research/"
        echo "     See: plans/SCATTERED_RESEARCH_CRISIS.md"
        echo
    fi

    # Check for too many active projects
    if [[ $active_count -gt 5 ]]; then
        echo "  ${fg[yellow]}!${reset_color} You have ${active_count} active projects (ADHD-friendly limit: 3)"
        echo "  ${fg[blue]}💡 Recommendation:${reset_color} Focus on top 3, move rest to planning/"
        echo
    fi

    # Next steps
    echo "${fg[cyan]}📋 NEXT STEPS${reset_color}"
    echo
    echo "  1. Review active projects above"
    echo "  2. Identify your TOP 3 most important"
    echo "  3. Move rest to ~/research/planning/"
    echo "  4. Consolidate scattered locations to ~/research/"
    echo
    echo "${fg[white]}Commands:${reset_color}"
    echo "  research status <project>  - Detailed project status"
    echo "  research work <project>    - Start working on project"
    echo "  research migrate          - Begin migration to ~/research/"
    echo
}

# ============================================
# PROJECT STATUS
# ============================================

# Display detailed project status
display_project_status() {
    local project_name="$1"

    if [[ -z "$project_name" ]]; then
        print_error "Project name required"
        echo "Usage: research status <project-name>"
        return 1
    fi

    # Find project
    local projects=("${(@f)$(find_research_projects)}")
    local project_dir=""

    for proj in "${projects[@]}"; do
        if [[ "${proj:t}" == "$project_name" ]]; then
            project_dir="$proj"
            break
        fi
    done

    if [[ -z "$project_dir" ]]; then
        print_error "Project not found: $project_name"
        return 1
    fi

    # Get project data
    local proj_status=$(get_project_status "$project_dir")
    local category=$(get_project_category "$project_dir")
    local location=$(get_project_location "$project_dir")
    local mod_time=$(stat -f %m "$project_dir" 2>/dev/null || echo "0")
    local time_str=$(time_ago "$mod_time")
    local file_count=$(count_project_files "$project_dir")

    # Display
    print_header "📊 ${project_name} - Status"
    echo
    echo "${fg[cyan]}OVERVIEW${reset_color}"
    echo "  Location: $project_dir"
    echo "  Status:   $(get_status_icon "$proj_status") $status"
    echo "  Category: $category"
    echo "  Storage:  $(get_location_icon "$location") $location"
    echo "  Modified: $time_str"
    echo

    echo "${fg[cyan]}FILES${reset_color}"
    echo "  Total: $file_count files"
    echo

    # List key files
    if [[ -d "$project_dir" ]]; then
        echo "${fg[cyan]}KEY FILES${reset_color}"

        # Look for manuscripts
        local manuscripts=$(find "$project_dir" -maxdepth 2 -name "*.qmd" -o -name "*.Rmd" -o -name "*.docx" 2>/dev/null)
        if [[ -n "$manuscripts" ]]; then
            echo "  Manuscripts:"
            echo "$manuscripts" | while read -r file; do
                local basename="${file:t}"
                local size=$(ls -lh "$file" | awk '{print $5}')
                echo "    - $basename ($size)"
            done
        fi

        # Look for R scripts
        local scripts=$(find "$project_dir" -maxdepth 2 -name "*.R" 2>/dev/null | head -5)
        if [[ -n "$scripts" ]]; then
            echo "  R Scripts:"
            echo "$scripts" | while read -r file; do
                echo "    - ${file:t}"
            done
        fi

        # Look for data
        local data=$(find "$project_dir" -maxdepth 2 -name "*.csv" -o -name "*.xlsx" -o -name "*.rds" 2>/dev/null | head -5)
        if [[ -n "$data" ]]; then
            echo "  Data:"
            echo "$data" | while read -r file; do
                local size=$(ls -lh "$file" | awk '{print $5}')
                echo "    - ${file:t} ($size)"
            done
        fi
        echo
    fi

    # Check for _next.md
    if [[ -f "$project_dir/_next.md" ]]; then
        echo "${fg[cyan]}NEXT ACTIONS${reset_color}"
        cat "$project_dir/_next.md" | head -10
        echo
    else
        echo "${fg[yellow]}No _next.md file found${reset_color}"
        echo "  Create one: echo '# Next Actions\n\n- [ ] ...' > \"$project_dir/_next.md\""
        echo
    fi

    # Recommendations
    echo "${fg[blue]}💡 RECOMMENDATIONS${reset_color}"

    if [[ "$proj_status" == "archive" ]] || [[ "$proj_status" == "inactive" ]]; then
        echo "  This project appears inactive (last modified: $time_str)"
        echo "  Consider moving to: ~/research/archive/$project_name"
    elif [[ "$proj_status" == "active" ]] && [[ "$location" != "local" ]]; then
        echo "  Active project in cloud storage (slower access)"
        echo "  Consider moving to: ~/research/active/$project_name"
    fi
    echo
}
