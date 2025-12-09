#!/usr/bin/env zsh
# examark-bridge.sh - Bridge between Claude commands and examark CLI
#
# This script provides helper functions for integrating Claude Code
# slash commands with the examark exam generation tool.
#
# Usage: source this file in your shell or call functions directly

# =============================================================================
# Configuration
# =============================================================================

# Default output directory for generated exams
EXAMARK_OUTPUT_DIR="${EXAMARK_OUTPUT_DIR:-./exams}"

# =============================================================================
# Core Functions
# =============================================================================

# Create QTI package from markdown exam
# Usage: exam_create input.md [output.qti.zip]
exam_create() {
    local input="$1"
    local output="${2:-${input%.md}.qti.zip}"

    if [[ ! -f "$input" ]]; then
        echo "Error: Input file not found: $input" >&2
        return 1
    fi

    echo "Converting $input to QTI package..."
    examark "$input" -o "$output" -v

    if [[ $? -eq 0 ]]; then
        echo "Created: $output"
    fi
}

# Validate exam markdown before conversion
# Usage: exam_validate input.md
exam_validate() {
    local input="$1"

    if [[ ! -f "$input" ]]; then
        echo "Error: Input file not found: $input" >&2
        return 1
    fi

    echo "Validating $input..."
    examark check "$input"
}

# Preview parsed questions as JSON
# Usage: exam_preview input.md
exam_preview() {
    local input="$1"

    if [[ ! -f "$input" ]]; then
        echo "Error: Input file not found: $input" >&2
        return 1
    fi

    examark "$input" --preview
}

# Export exam to plain text (for printing)
# Usage: exam_text input.md [--no-answers]
exam_text() {
    local input="$1"
    shift
    local output="${input%.md}.txt"

    if [[ ! -f "$input" ]]; then
        echo "Error: Input file not found: $input" >&2
        return 1
    fi

    echo "Exporting $input to plain text..."
    examark "$input" -f text "$@" > "$output"

    if [[ $? -eq 0 ]]; then
        echo "Created: $output"
    fi
}

# Verify QTI package structure
# Usage: exam_verify package.qti.zip [--strict]
exam_verify() {
    local package="$1"
    shift

    if [[ ! -f "$package" ]]; then
        echo "Error: Package not found: $package" >&2
        return 1
    fi

    examark verify "$package" "$@"
}

# Simulate Canvas import
# Usage: exam_emulate package.qti.zip
exam_emulate() {
    local package="$1"

    if [[ ! -f "$package" ]]; then
        echo "Error: Package not found: $package" >&2
        return 1
    fi

    examark emulate-canvas "$package"
}

# =============================================================================
# Batch Operations
# =============================================================================

# Convert all markdown files in a directory
# Usage: exam_batch_convert dir/ [output_dir/]
exam_batch_convert() {
    local input_dir="${1:-.}"
    local output_dir="${2:-$EXAMARK_OUTPUT_DIR}"

    mkdir -p "$output_dir"

    local count=0
    for f in "$input_dir"/*.md; do
        [[ -f "$f" ]] || continue
        local basename="${f:t:r}"
        echo "Converting: $basename"
        examark "$f" -o "$output_dir/${basename}.qti.zip" -v
        ((count++))
    done

    echo "Converted $count exam(s) to $output_dir"
}

# Validate all markdown files in a directory
# Usage: exam_batch_validate dir/
exam_batch_validate() {
    local input_dir="${1:-.}"

    local passed=0
    local failed=0

    for f in "$input_dir"/*.md; do
        [[ -f "$f" ]] || continue
        echo "=== ${f:t} ==="
        if examark check "$f"; then
            ((passed++))
        else
            ((failed++))
        fi
        echo ""
    done

    echo "Results: $passed passed, $failed failed"
}

# =============================================================================
# Quick Helpers
# =============================================================================

# Quick exam creation workflow
# Usage: exam_quick topic num_questions
exam_quick() {
    local topic="$1"
    local num="${2:-10}"
    local filename="${topic// /-}.md"

    echo "# $topic Exam" > "$filename"
    echo "" >> "$filename"
    echo "<!-- Generated $(date +%Y-%m-%d) -->" >> "$filename"
    echo "" >> "$filename"
    echo "<!-- Add your questions below using examark format -->" >> "$filename"
    echo "" >> "$filename"

    echo "Created template: $filename"
    echo "Add $num questions, then run: exam_create $filename"
}

# Show examark format reference
exam_help() {
    cat << 'EOF'
examark Format Quick Reference
==============================

Question Types:
  [MC]     Multiple Choice (single answer)
  [MA]     Multiple Answers (select all)
  [TF]     True/False
  [Short]  Short Answer
  [Essay]  Essay/Long Answer
  [Num]    Numerical
  [Match]  Matching
  [FMB]    Fill Multiple Blanks

Correct Answer Markers:
  [x]           Checkbox style
  **Bold**      Bold text
  ✓ or ✔        Checkmark
  [correct]     Explicit marker
  *a)           Asterisk prefix

Example:
  1. [MC] What is 2+2? [2pts]
  a) 3
  b) **4**
  c) 5

Commands:
  exam_create    - Convert MD to QTI
  exam_validate  - Check MD syntax
  exam_preview   - Preview parsed JSON
  exam_text      - Export to plain text
  exam_verify    - Validate QTI package
  exam_emulate   - Simulate Canvas import
  exam_quick     - Create template file
EOF
}

# =============================================================================
# Auto-completion (if using zsh)
# =============================================================================

if [[ -n "$ZSH_VERSION" ]]; then
    _examark_bridge_complete() {
        local -a commands
        commands=(
            'exam_create:Convert markdown to QTI package'
            'exam_validate:Validate exam markdown'
            'exam_preview:Preview parsed questions'
            'exam_text:Export to plain text'
            'exam_verify:Verify QTI package'
            'exam_emulate:Simulate Canvas import'
            'exam_batch_convert:Convert all exams in directory'
            'exam_batch_validate:Validate all exams in directory'
            'exam_quick:Create exam template'
            'exam_help:Show format reference'
        )
        _describe 'command' commands
    }
fi

# Print available commands when sourced
echo "examark-bridge loaded. Commands: exam_create, exam_validate, exam_preview, exam_text, exam_verify, exam_emulate"
echo "Run 'exam_help' for format reference."
