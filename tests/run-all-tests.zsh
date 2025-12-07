#!/usr/bin/env zsh
# run-all-tests.zsh - Run complete test suite
#
# This script runs both structure and runtime tests.
# IMPORTANT: Must be SOURCED, not executed:
#   source tests/run-all-tests.zsh

# Color codes
autoload -U colors && colors
RED="${fg[red]}"
GREEN="${fg[green]}"
YELLOW="${fg[yellow]}"
BLUE="${fg[blue]}"
CYAN="${fg[cyan]}"
RESET="${reset_color}"

# Get script directory
TEST_DIR="${0:A:h}"

# Print banner
echo ""
echo "${CYAN}╔════════════════════════════════════════════════════════════════╗${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}║            zsh-claude-workflow Complete Test Suite             ║${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}║  Phase 1: Structure Tests (files, permissions, syntax)        ║${RESET}"
echo "${CYAN}║  Phase 2: Runtime Tests (aliases, PATH, commands)             ║${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}╚════════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ============================================
# PHASE 1: STRUCTURE TESTS
# ============================================

echo "${CYAN}════════════════════════════════════════════════════════════════${RESET}"
echo "${CYAN}PHASE 1: Structure Tests${RESET}"
echo "${CYAN}════════════════════════════════════════════════════════════════${RESET}"
echo ""

# Run structure tests in subprocess
"$TEST_DIR/test-structure.zsh" --quick
STRUCTURE_RESULT=$?

echo ""

# ============================================
# PHASE 2: RUNTIME TESTS
# ============================================

echo "${CYAN}════════════════════════════════════════════════════════════════${RESET}"
echo "${CYAN}PHASE 2: Runtime Tests${RESET}"
echo "${CYAN}════════════════════════════════════════════════════════════════${RESET}"
echo ""

# Run runtime tests in current shell (sourced)
source "$TEST_DIR/test-runtime.zsh"
RUNTIME_RESULT=$?

# ============================================
# FINAL SUMMARY
# ============================================

echo ""
echo "${CYAN}╔════════════════════════════════════════════════════════════════╗${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}║                     Final Test Summary                         ║${RESET}"
echo "${CYAN}║                                                                ║${RESET}"
echo "${CYAN}╚════════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# Structure tests
if [[ $STRUCTURE_RESULT -eq 0 ]]; then
    echo "  ${GREEN}✓${RESET} Structure Tests: ${GREEN}PASSED${RESET}"
else
    echo "  ${RED}✗${RESET} Structure Tests: ${RED}FAILED${RESET}"
fi

# Runtime tests
if [[ $RUNTIME_RESULT -eq 0 ]]; then
    echo "  ${GREEN}✓${RESET} Runtime Tests:   ${GREEN}PASSED${RESET}"
else
    echo "  ${RED}✗${RESET} Runtime Tests:   ${RED}FAILED${RESET}"
fi

echo ""

# Overall result
if [[ $STRUCTURE_RESULT -eq 0 ]] && [[ $RUNTIME_RESULT -eq 0 ]]; then
    echo "  ${GREEN}╔════════════════════════════════════════════════════════════╗${RESET}"
    echo "  ${GREEN}║  ✓ ALL TESTS PASSED!                                      ║${RESET}"
    echo "  ${GREEN}║    Your zsh-claude-workflow is fully configured!          ║${RESET}"
    echo "  ${GREEN}╚════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    FINAL_RESULT=0
else
    echo "  ${YELLOW}╔════════════════════════════════════════════════════════════╗${RESET}"
    echo "  ${YELLOW}║  ⚠ SOME TESTS FAILED                                      ║${RESET}"
    echo "  ${YELLOW}║    Review the output above for details                    ║${RESET}"
    echo "  ${YELLOW}╚════════════════════════════════════════════════════════════╝${RESET}"
    echo ""

    if [[ $RUNTIME_RESULT -ne 0 ]]; then
        echo "  ${YELLOW}Common fix for runtime failures:${RESET}"
        echo "    1. Run: ${CYAN}source ~/.zshrc${RESET}"
        echo "    2. Run: ${CYAN}source tests/run-all-tests.zsh${RESET}"
        echo ""
    fi
    FINAL_RESULT=1
fi

echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

return $FINAL_RESULT
