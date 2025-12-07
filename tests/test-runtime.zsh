#!/usr/bin/env zsh
# test-runtime.zsh - Test runtime configuration (aliases, PATH, etc.)
#
# IMPORTANT: This script must be SOURCED, not executed:
#   source ./test-runtime.zsh
#
# This tests that aliases and PATH are correctly loaded in your current shell.

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

# ============================================
# HELPER FUNCTIONS
# ============================================

print_header() {
    echo ""
    echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo "${CYAN}$1${RESET}"
    echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

check() {
    local description="$1"
    local test_command="$2"

    printf "  %-55s" "$description"
    if eval "$test_command" >/dev/null 2>&1; then
        echo "${GREEN}✓ PASS${RESET}"
        ((PASSED++))
        return 0
    else
        echo "${RED}✗ FAIL${RESET}"
        ((FAILED++))
        return 1
    fi
}

check_alias_value() {
    local alias_name="$1"
    local expected_value="$2"
    local description="$3"

    printf "  %-55s" "$description"
    local actual=$(alias "$alias_name" 2>/dev/null)
    local expected="$alias_name='$expected_value'"

    if [[ "$actual" == "$expected" ]]; then
        echo "${GREEN}✓ PASS${RESET}"
        ((PASSED++))
        return 0
    else
        echo "${RED}✗ FAIL${RESET}"
        if [[ -n "$actual" ]]; then
            echo "    ${YELLOW}Expected:${RESET} $expected"
            echo "    ${YELLOW}Got:${RESET}      $actual"
        else
            echo "    ${YELLOW}Alias not defined${RESET}"
        fi
        ((FAILED++))
        return 1
    fi
}

# ============================================
# BANNER
# ============================================

echo ""
echo "${CYAN}╔════════════════════════════════════════════════════════════════╗${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}║              Runtime Configuration Test Suite                  ║${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}║  Tests: Aliases, PATH, Command Availability                    ║${RESET}"
echo "${CYAN}║  Run: source tests/test-runtime.zsh                            ║${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}╚════════════════════════════════════════════════════════════════╝${RESET}"

# ============================================
# TESTS
# ============================================

print_header "Claude CLI"
check "Claude CLI installed" "command -v claude"
check "Claude CLI version check" "claude --version"

print_header "Claude Code Aliases"
check_alias_value "cc" "claude" "cc alias (correct value)"
check_alias_value "ccc" "claude chat" "ccc alias (correct value)"

print_header "Workflow Aliases"
check "ptype alias exists" "alias ptype"
check "pinfo alias exists" "alias pinfo"
check "cctx alias exists" "alias cctx"
check "cinit alias exists" "alias cinit"
check "cshow alias exists" "alias cshow"
check "pclaude alias exists" "alias pclaude"

print_header "Workflow Aliases - Correct Values"
check_alias_value "ptype" "proj-type" "ptype → proj-type"
check_alias_value "pinfo" "proj-info" "pinfo → proj-info"
check_alias_value "cctx" "claude-ctx" "cctx → claude-ctx"
check_alias_value "cinit" "claude-init" "cinit → claude-init"
check_alias_value "cshow" "claude-show" "cshow → claude-show"
check_alias_value "pclaude" "proj-claude" "pclaude → proj-claude"

print_header "PATH Configuration"
check "Workflow commands in PATH" "[[ \$PATH == *zsh-claude-workflow/commands* ]]"
check "proj-type in PATH" "command -v proj-type"
check "claude-ctx in PATH" "command -v claude-ctx"

print_header "Command Execution"
check "proj-type executes" "proj-type ~/code/zsh-claude-workflow"
check "claude-ctx executes" "claude-ctx ~/code/zsh-claude-workflow"

print_header "Key Files"
check "CLAUDE.md exists" "[[ -f ~/code/zsh-claude-workflow/CLAUDE.md ]]"
check "test-structure.zsh exists" "[[ -f ~/code/zsh-claude-workflow/tests/test-structure.zsh ]]"
check "test-runtime.zsh exists" "[[ -f ~/code/zsh-claude-workflow/tests/test-runtime.zsh ]]"

# ============================================
# SUMMARY
# ============================================

print_header "Test Summary"

local total=$((PASSED + FAILED))

echo ""
echo "  Total Tests: ${CYAN}$total${RESET}"
echo "  ${GREEN}Passed:${RESET}      $PASSED"
echo "  ${RED}Failed:${RESET}      $FAILED"
echo ""

if [[ $FAILED -eq 0 ]]; then
    echo "  ${GREEN}✓ All runtime tests passed! Configuration is perfect!${RESET}"
    echo ""
    echo "  Your aliases are ready to use:"
    echo "    ${CYAN}cc${RESET}           - Launch Claude"
    echo "    ${CYAN}ccc${RESET}          - Launch Claude chat"
    echo "    ${CYAN}ptype${RESET}        - Check project type"
    echo "    ${CYAN}cctx${RESET}         - Show Claude context"
    echo "    ${CYAN}cinit${RESET}        - Create CLAUDE.md"
    echo ""
elif [[ $FAILED -le 2 ]]; then
    echo "  ${YELLOW}⚠ Some tests failed ($(( (PASSED * 100) / total ))% passed)${RESET}"
    echo ""
    echo "  Try running: ${CYAN}source ~/.zshrc${RESET}"
    echo "  Then run this test again: ${CYAN}source tests/test-runtime.zsh${RESET}"
    echo ""
else
    echo "  ${RED}✗ Multiple failures ($(( (PASSED * 100) / total ))% passed)${RESET}"
    echo ""
    echo "  ${YELLOW}Troubleshooting:${RESET}"
    echo "    1. Run: ${CYAN}source ~/.zshrc${RESET}"
    echo "    2. Check for errors: ${CYAN}zsh -c \"source ~/.zshrc\" 2>&1 | head -20${RESET}"
    echo "    3. Run test again: ${CYAN}source tests/test-runtime.zsh${RESET}"
    echo ""
fi

echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Return exit code based on failures
if [[ $FAILED -eq 0 ]]; then
    return 0
else
    return 1
fi
