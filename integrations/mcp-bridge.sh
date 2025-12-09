#!/usr/bin/env zsh
# mcp-bridge.sh - Bridge between shell workflows and MCP server
#
# This script provides helper functions for invoking MCP server
# capabilities from shell scripts and Claude Code workflows.
#
# Note: MCP tools are typically invoked directly by Claude Code.
# This bridge is for shell automation and testing purposes.

# =============================================================================
# Configuration
# =============================================================================

# Path to MCP server (adjust if needed)
MCP_SERVER_DIR="${MCP_SERVER_DIR:-$HOME/projects/dev-tools/claude-statistical-research/mcp-server}"

# =============================================================================
# MCP Server Info
# =============================================================================

# List available MCP tools
mcp_tools() {
    cat << 'EOF'
Available MCP Tools (claude-statistical-research)
=================================================

R Development:
  r_execute      - Execute R code
  r_check        - Run R CMD check
  r_test         - Run package tests
  r_document     - Generate documentation
  r_coverage     - Check test coverage
  r_build        - Build package
  r_install      - Install package
  r_lint         - Run lintr
  r_style        - Style code with styler
  r_deps         - Check dependencies
  r_plot         - Generate R plots
  r_quarto       - Render Quarto documents

Literature:
  arxiv_search   - Search arXiv
  crossref_search - Search CrossRef

Reference:
  zotero_search  - Search Zotero library

These tools are invoked by Claude Code automatically.
For shell access, use the R functions below.
EOF
}

# List available MCP skills
mcp_skills() {
    cat << 'EOF'
Available MCP Skills (claude-statistical-research)
==================================================

Mathematical (4):
  algorithm-designer     - Design computational algorithms
  numerical-methods      - Numerical analysis guidance
  simulation-architect   - Design simulation studies
  statistical-computing  - R/Stan/numerical methods

Implementation (4):
  r-package-developer    - R package development
  r-simulation-config    - Simulation configuration
  latex-document-prep    - LaTeX document preparation
  code-quality-reviewer  - Code review for statistical software

Writing (5):
  methods-communicator   - Statistical methods communication
  methods-paper-writer   - Write methods manuscripts
  statistical-reviewer   - Review statistical methods
  grant-methods-writer   - Grant methods sections
  publication-strategist - Publication strategy

Research (4):
  literature-gap-finder  - Find research gaps
  cross-disciplinary-ideation - Cross-field idea generation
  method-transfer        - Adapt methods across fields
  research-question-refiner - Refine research questions

These skills are invoked via Claude Code Skill tool.
EOF
}

# =============================================================================
# R Execution Helpers (for testing)
# =============================================================================

# Execute R code and return result
# Usage: r_exec "1 + 1"
r_exec() {
    local code="$1"
    Rscript -e "$code"
}

# Run R CMD check on a package
# Usage: r_pkg_check path/to/package
r_pkg_check() {
    local pkg_path="${1:-.}"
    cd "$pkg_path" && R CMD check .
}

# Run tests for R package
# Usage: r_pkg_test path/to/package
r_pkg_test() {
    local pkg_path="${1:-.}"
    cd "$pkg_path" && Rscript -e "devtools::test()"
}

# Get test coverage
# Usage: r_pkg_coverage path/to/package
r_pkg_coverage() {
    local pkg_path="${1:-.}"
    cd "$pkg_path" && Rscript -e "covr::package_coverage()"
}

# =============================================================================
# Literature Search Helpers
# =============================================================================

# Search arXiv (requires curl)
# Usage: arxiv_search "mediation analysis" [max_results]
arxiv_search() {
    local query="${1// /+}"
    local max="${2:-10}"
    curl -s "http://export.arxiv.org/api/query?search_query=all:$query&max_results=$max"
}

# =============================================================================
# Workflow Helpers
# =============================================================================

# Check MCP server status
mcp_status() {
    if [[ -d "$MCP_SERVER_DIR" ]]; then
        echo "MCP Server Directory: $MCP_SERVER_DIR"
        echo "Package: $(jq -r '.name + " v" + .version' "$MCP_SERVER_DIR/package.json" 2>/dev/null || echo "Not found")"

        if [[ -f "$MCP_SERVER_DIR/src/tools/index.ts" ]]; then
            local tools=$(grep -c "export" "$MCP_SERVER_DIR/src/tools/index.ts" 2>/dev/null || echo "?")
            echo "Tools defined: ~$tools"
        fi

        if [[ -d "$MCP_SERVER_DIR/skills" ]]; then
            local skills=$(find "$MCP_SERVER_DIR/skills" -name "*.md" | wc -l | tr -d ' ')
            echo "Skills available: $skills"
        fi
    else
        echo "MCP Server not found at: $MCP_SERVER_DIR"
        echo "Set MCP_SERVER_DIR environment variable to correct path"
    fi
}

# Invoke Claude Code skill (display prompt)
# Usage: invoke_skill "algorithm-designer"
invoke_skill() {
    local skill="$1"
    echo "To invoke skill in Claude Code, use:"
    echo ""
    echo "  Skill tool with skill=\"$skill\""
    echo ""
    echo "Or reference in conversation:"
    echo "  \"Use the $skill skill to...\""
}

# =============================================================================
# Integration Points
# =============================================================================

# Show how tools and skills map to Claude commands
mcp_command_map() {
    cat << 'EOF'
MCP Integration Map
===================

Claude Command → MCP Tools/Skills Used
---------------------------------------

/research/lit-gap     → arxiv_search, crossref_search, literature-gap-finder
/research/cite        → zotero_search, crossref_search
/research/sim-design  → simulation-architect, r_execute
/research/manuscript  → methods-paper-writer, latex-document-prep
/research/revision    → publication-strategist

/teach/exam           → [uses examark CLI, not MCP]
/teach/rubric         → [standalone]
/teach/solution       → numerical-methods

/math/proof           → [standalone]
/math/derive          → numerical-methods, latex-document-prep

/code/rpkg-check      → r_check, r_test
/code/docs-check      → [standalone]
/code/release         → r_check, r_coverage, r_build

/write/abstract       → methods-paper-writer, methods-communicator
/write/cover-letter   → publication-strategist
EOF
}

# =============================================================================
# Initialization
# =============================================================================

echo "mcp-bridge loaded. Commands: mcp_tools, mcp_skills, mcp_status, mcp_command_map"
echo "Run 'mcp_tools' or 'mcp_skills' to see available capabilities."
