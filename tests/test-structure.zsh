#!/usr/bin/env zsh
# test-structure.zsh - Test file structure and configuration
#
# This tests that files exist, are executable, and .zshrc is syntactically correct.
# NOTE: Alias tests will show as "SKIP" because this runs in a subprocess.
#       Use test-runtime.zsh to test aliases in your current shell.
#
# Usage:
#   ./test-structure.zsh           # Run all structure tests
#   ./test-structure.zsh --quick   # Skip optional tests

# ============================================
# CONFIGURATION
# ============================================

SCRIPT_DIR="${0:A:h}"
QUICK_MODE=false

# Color codes
autoload -U colors && colors
RED="${fg[red]}"
GREEN="${fg[green]}"
YELLOW="${fg[yellow]}"
BLUE="${fg[blue]}"
CYAN="${fg[cyan]}"
RESET="${reset_color}"

# Test counters
PASSED=0
FAILED=0
SKIPPED=0

# ============================================
# HELPER FUNCTIONS
# ============================================

print_header() {
    echo ""
    echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo "${CYAN}$1${RESET}"
    echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

pass() {
    echo "  ${GREEN}✓${RESET} $1"
    ((PASSED++))
}

fail() {
    echo "  ${RED}✗${RESET} $1"
    ((FAILED++))
}

skip() {
    echo "  ${YELLOW}⊘${RESET} $1 (skipped - use test-runtime.zsh)"
    ((SKIPPED++))
}

warn() {
    echo "  ${YELLOW}⚠${RESET} $1"
}

# ============================================
# TEST FUNCTIONS
# ============================================

test_basic_config() {
    print_header "Basic Configuration"

    # .zshrc exists
    if [[ -f "$HOME/.zshrc" ]]; then
        pass ".zshrc exists"
    else
        fail ".zshrc not found"
        return 1
    fi

    # .zshrc sources without errors
    if zsh -c "source ~/.zshrc" >/dev/null 2>&1; then
        pass ".zshrc sources without errors"
    else
        fail ".zshrc has syntax errors"
    fi

    # Claude CLI installed
    if command -v claude >/dev/null 2>&1; then
        local version=$(claude --version 2>&1 | head -1)
        pass "Claude CLI installed: $version"
    else
        fail "Claude CLI not found"
    fi
}

test_aliases_defined_in_zshrc() {
    print_header "Aliases Defined in .zshrc"

    local aliases=(
        "cc"
        "ccc"
        "ptype"
        "pinfo"
        "cctx"
        "cinit"
        "cshow"
        "pclaude"
    )

    for alias_name in "${aliases[@]}"; do
        if /usr/bin/grep -q "^alias $alias_name=" "$HOME/.zshrc"; then
            pass "$alias_name defined in .zshrc"
        else
            fail "$alias_name NOT defined in .zshrc"
        fi
    done

    echo ""
    warn "Note: This only checks if aliases are DEFINED in .zshrc"
    warn "      To test if they WORK, use: source tests/test-runtime.zsh"
}

test_path_export() {
    print_header "PATH Configuration"

    if /usr/bin/grep -q "zsh-claude-workflow/commands" "$HOME/.zshrc"; then
        pass "PATH export defined in .zshrc"
    else
        fail "PATH export NOT in .zshrc"
    fi

    # Check if commands directory exists
    if [[ -d "$HOME/code/zsh-claude-workflow/commands" ]]; then
        pass "commands directory exists"
    else
        fail "commands directory NOT found"
    fi
}

test_command_files() {
    print_header "Command Files"

    local commands=(
        "proj-type"
        "proj-info"
        "claude-ctx"
        "claude-init"
        "claude-show"
        "proj-claude"
    )

    local cmd_dir="$HOME/code/zsh-claude-workflow/commands"

    for cmd in "${commands[@]}"; do
        local cmd_path="$cmd_dir/$cmd"

        if [[ -f "$cmd_path" ]]; then
            if [[ -x "$cmd_path" ]]; then
                pass "$cmd exists and is executable"
            else
                fail "$cmd exists but NOT executable"
            fi
        else
            fail "$cmd not found"
        fi
    done
}

test_library_files() {
    print_header "Library Files"

    local libraries=(
        "core.sh"
        "project-detector.sh"
        "claude-context.sh"
    )

    local lib_dir="$HOME/code/zsh-claude-workflow/lib"

    for lib in "${libraries[@]}"; do
        local lib_path="$lib_dir/$lib"

        if [[ -f "$lib_path" ]]; then
            if [[ -r "$lib_path" ]]; then
                pass "$lib exists and is readable"
            else
                fail "$lib exists but NOT readable"
            fi
        else
            fail "$lib not found"
        fi
    done
}

test_template_files() {
    print_header "Template Files"

    local templates=(
        "CLAUDE-rpkg.md"
        "CLAUDE-quarto.md"
        "CLAUDE-research.md"
        "zsh_plugins.txt.recommended"
    )

    local template_dir="$HOME/code/zsh-claude-workflow/templates"

    for template in "${templates[@]}"; do
        local template_path="$template_dir/$template"

        if [[ -f "$template_path" ]]; then
            pass "$template exists"
        else
            fail "$template not found"
        fi
    done
}

test_plugin_config() {
    print_header "Plugin Configuration"

    if [[ -f "$HOME/.zsh_plugins.txt" ]]; then
        pass ".zsh_plugins.txt exists"

        # Check for optimizations
        if /usr/bin/grep -q "kind:defer" "$HOME/.zsh_plugins.txt"; then
            local count=$(/usr/bin/grep -c "kind:defer" "$HOME/.zsh_plugins.txt")
            pass "Lazy loading configured ($count plugins)"
        else
            warn "No lazy loading found (consider optimization)"
        fi

        # Check for FZF
        if /usr/bin/grep -q "plugins/fzf" "$HOME/.zsh_plugins.txt"; then
            pass "FZF plugin configured"
        else
            warn "FZF plugin not configured (optional)"
        fi
    else
        warn ".zsh_plugins.txt not found (optional)"
    fi
}

test_documentation() {
    print_header "Documentation Files"

    local docs=(
        "README.md:Main README"
        "QUICKSTART.md:Quick start guide"
        "CLAUDE.md:Project CLAUDE.md"
        "docs/README.md:Docs index"
        "docs/COMMANDS.md:Command reference"
        "docs/TESTING.md:Testing guide"
    )

    for doc_entry in "${docs[@]}"; do
        local file="${doc_entry%%:*}"
        local desc="${doc_entry##*:}"
        local full_path="$HOME/code/zsh-claude-workflow/$file"

        if [[ -f "$full_path" ]]; then
            pass "$desc exists"
        else
            warn "$desc not found (optional)"
        fi
    done
}

test_backups() {
    print_header "Backup Files"

    local backups=($HOME/.zshrc.backup-*(N))
    if [[ ${#backups[@]} -gt 0 ]]; then
        pass "Found ${#backups[@]} .zshrc backup(s)"
    else
        warn "No .zshrc backups found"
    fi

    local plugin_backups=($HOME/.zsh_plugins.txt.backup-*(N))
    if [[ ${#plugin_backups[@]} -gt 0 ]]; then
        pass "Found ${#plugin_backups[@]} plugin backup(s)"
    else
        warn "No plugin backups found"
    fi
}

test_command_functionality() {
    if [[ "$QUICK_MODE" == "true" ]]; then
        skip "Functionality tests (use --verbose for full tests)"
        return 0
    fi

    print_header "Command Functionality (Basic)"

    local test_dir="$HOME/code/zsh-claude-workflow"

    # Test proj-type
    if [[ -f "$test_dir/commands/proj-type" ]]; then
        if "$test_dir/commands/proj-type" "$test_dir" >/dev/null 2>&1; then
            pass "proj-type executes successfully"
        else
            fail "proj-type failed to execute"
        fi
    else
        skip "proj-type command not found"
    fi

    # Test claude-ctx
    if [[ -f "$test_dir/commands/claude-ctx" ]]; then
        if "$test_dir/commands/claude-ctx" "$test_dir" >/dev/null 2>&1; then
            pass "claude-ctx executes successfully"
        else
            warn "claude-ctx returned non-zero"
        fi
    else
        skip "claude-ctx command not found"
    fi
}

# ============================================
# MAIN TEST RUNNER
# ============================================

main() {
    # Parse arguments
    for arg in "$@"; do
        case "$arg" in
            --quick|-q)
                QUICK_MODE=true
                ;;
            --help|-h)
                echo "Usage: $0 [options]"
                echo ""
                echo "Tests file structure, configuration, and command files."
                echo ""
                echo "Options:"
                echo "  -q, --quick      Skip functionality tests"
                echo "  -h, --help       Show this help message"
                echo ""
                echo "Note: This script runs in a subprocess, so alias tests are skipped."
                echo "      To test runtime configuration (aliases, PATH), use:"
                echo "        source tests/test-runtime.zsh"
                exit 0
                ;;
        esac
    done

    # Print banner
    echo ""
    echo "${CYAN}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo "${CYAN}║                                                                ║${RESET}"
    echo "${CYAN}║              Structure & Configuration Test Suite              ║${RESET}"
    echo "${CYAN}║                                                                ║${RESET}"
    echo "${CYAN}║  Tests: Files, Permissions, Configuration Syntax              ║${RESET}"
    echo "${CYAN}║  Note: For runtime tests (aliases), use test-runtime.zsh      ║${RESET}"
    echo "${CYAN}║                                                                ║${RESET}"
    echo "${CYAN}╚════════════════════════════════════════════════════════════════╝${RESET}"

    # Run tests
    test_basic_config
    test_aliases_defined_in_zshrc
    test_path_export
    test_command_files
    test_library_files
    test_template_files
    test_plugin_config
    test_documentation
    test_backups
    test_command_functionality

    # Print summary
    print_header "Test Summary"

    local total=$((PASSED + FAILED + SKIPPED))

    echo ""
    echo "  Total Tests: ${CYAN}$total${RESET}"
    echo "  ${GREEN}Passed:${RESET}      $PASSED"
    echo "  ${RED}Failed:${RESET}      $FAILED"
    echo "  ${YELLOW}Skipped:${RESET}     $SKIPPED"
    echo ""

    # Calculate percentage
    if [[ $total -gt 0 ]]; then
        local pass_percent=$(( (PASSED * 100) / total ))

        if [[ $FAILED -eq 0 ]]; then
            echo "  ${GREEN}✓ All structure tests passed! ($pass_percent%)${RESET}"
        elif [[ $FAILED -le 2 ]]; then
            echo "  ${YELLOW}⚠ Some tests failed ($pass_percent% passed)${RESET}"
        else
            echo "  ${RED}✗ Multiple failures ($pass_percent% passed)${RESET}"
        fi
    fi

    echo ""
    echo "${YELLOW}Next step:${RESET} Test runtime configuration (aliases, PATH):"
    echo "  ${CYAN}source tests/test-runtime.zsh${RESET}"
    echo ""
    echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""

    # Exit code based on failures
    if [[ $FAILED -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

# Run main
main "$@"
