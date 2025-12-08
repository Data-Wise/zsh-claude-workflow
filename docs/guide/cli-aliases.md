# CLI Tool Aliases Guide

Comprehensive reference for Claude Code CLI and Gemini CLI aliases integrated into your zsh workflow.

**Last Updated:** 2025-12-08

---

## Overview

Your shell configuration includes **47+ productivity aliases** for AI-powered CLI tools:

| Tool | Aliases | Functions | Total | Purpose |
|------|---------|-----------|-------|---------|
| **Claude Code CLI** | 30 aliases | 4 functions | 34 shortcuts | R package development, code review |
| **Gemini CLI** | 13 aliases | 2 functions | 15 shortcuts | Web research, general assistance |
| **zsh-claude-workflow** | 6 aliases | - | 6 shortcuts | Project context management |

---

## Claude Code CLI Aliases

### Basic Commands

| Alias | Command | Description |
|-------|---------|-------------|
| `cc` | `claude` | Interactive mode (default) |
| `ccp` | `claude -p` | Print mode (non-interactive output) |
| `ccc` | `claude -c` | Continue last conversation |
| `ccr` | `claude -r` | Resume with interactive picker |
| `ccl` | `claude --resume latest` | Resume latest session |

**Usage Examples:**
```bash
cc                           # Start interactive Claude session
ccp "Explain async/await"    # Get quick answer and exit
ccc                          # Continue where you left off
ccr                          # Pick session to resume
ccl                          # Resume most recent
```

### Model Selection

| Alias | Command | Description |
|-------|---------|-------------|
| `ccs` | `claude --model sonnet` | Use Sonnet (balanced, default) |
| `cco` | `claude --model opus` | Use Opus (most capable) |
| `cch` | `claude --model haiku` | Use Haiku (fastest) |

**When to use which:**
- **Opus** - Complex logic, architecture decisions, difficult bugs
- **Sonnet** - Daily development, most tasks (default)
- **Haiku** - Quick questions, simple fixes, syntax checks

### Permission Modes

| Alias | Command | Description |
|-------|---------|-------------|
| `ccplan` | `claude --permission-mode plan` | Plan mode (review first) |
| `ccauto` | `claude --permission-mode acceptEdits` | Auto-accept edits only |
| `ccyolo` | `claude --permission-mode bypassPermissions` | Bypass all permissions |

**Safety levels:**
- `ccplan` - Safest, review everything
- `ccauto` - Safe for file edits, asks for commands
- `ccyolo` - Dangerous, only use in safe environments

### R-Specific Workflows

| Alias | Description |
|-------|-------------|
| `ccrdoc` | Generate roxygen2 documentation |
| `ccrtest` | Generate testthat tests |
| `ccrfix` | Fix R CMD check issues |
| `ccrrefactor` | Refactor to tidyverse style |
| `ccrexplain` | Explain R code |
| `ccroptimize` | Optimize R code performance |
| `ccrstyle` | Apply tidyverse style guide |

**Examples:**
```bash
# In R/myfunction.R
ccrdoc                      # Generate roxygen2 docs
ccrtest                     # Generate tests
ccrfix                      # Fix check issues
ccrstyle                    # Apply tidyverse style
```

### Common Development Tasks

| Alias | Description |
|-------|-------------|
| `ccfix` | Fix bugs |
| `ccreview` | Code review |
| `cctest` | Generate tests |
| `ccdoc` | Generate documentation |
| `ccexplain` | Explain code |
| `ccrefactor` | Refactor code |
| `ccoptimize` | Optimize performance |
| `ccsecurity` | Security review |

### Smart Functions

#### `ccask <question>`
Quick question to Claude (print mode).

```bash
ccask "How do I handle missing data in R?"
ccask "What's the best way to vectorize this loop?"
ccask "Explain CRAN submission process"
```

#### `ccfile <file> [prompt]`
Analyze a file with Claude.

```bash
ccfile R/myfunction.R                    # Explain this file
ccfile R/myfunction.R "review for bugs"  # Custom prompt
ccfile tests/testthat/test-foo.R "improve these tests"
```

#### `ccrdiff`
Review uncommitted R package changes with Claude.

```bash
# After making changes
ccrdiff                     # Review all uncommitted changes

# Use in workflow
vim R/myfunction.R          # Make changes
ccrdiff                     # Review before commit
git add . && git commit     # Commit if looks good
```

#### `ccrpkg <context>`
Smart R package helper - understands you're in an R package.

```bash
ccrpkg "help me write a vignette for mediation analysis"
ccrpkg "review my DESCRIPTION file for CRAN submission"
ccrpkg "suggest tests for my main functions"
```

**Auto-detects:**
- Package name from DESCRIPTION
- Sets R package context automatically
- Provides package-specific help

### Complete R Package Workflow

**Traditional:**
```bash
rload                       # Load package
rtest                       # Run tests
rdoc                        # Generate docs
rcheck                      # Check package
```

**Enhanced with Claude:**
```bash
rload && ccrtest            # Generate new tests
rtest || ccrfix             # Fix failing tests
rdoc && ccrdoc              # Enhance documentation
rcheck && ccrfix            # Fix check issues
ccrdiff                     # Review before commit
```

---

## Gemini CLI Aliases

### Basic Commands

| Alias | Command | Description |
|-------|---------|-------------|
| `gm` | `gemini` | Quick launch interactive mode |
| `gmi` | `gemini` | Interactive mode (explicit) |
| `gmpi` | `gemini -i` | Prompt then stay interactive |

**Examples:**
```bash
gm                                    # Start interactive session
gemini "Explain quantum computing"   # One-shot question
gmpi "What's in this directory?"     # Ask, then continue chatting
```

### Power User Modes

| Alias | Command | Description |
|-------|---------|-------------|
| `gmy` | `gemini --yolo` | Auto-approve all actions (YOLO mode) |
| `gms` | `gemini --sandbox` | Run in sandbox (safe mode) |
| `gmd` | `gemini --debug` | Enable debug mode |
| `gmr` | `gemini --resume latest` | Resume latest session |

**Examples:**
```bash
gmy "Install these packages"     # Auto-approves all actions
gms "Test this risky command"    # Safe sandbox environment
gmd "Debug this issue"           # Debug output enabled
gmr                              # Continue from where you left off
```

### Web Search Functions

| Function | Description |
|----------|-------------|
| `gmw <query>` | Search the web (adds "Search the web for: " prefix) |
| `gmws <query>` | Find and summarize (adds "Find and summarize information about: " prefix) |

**Examples:**
```bash
gmw latest Node.js features         # Searches web
gmws React 19 updates               # Summarizes findings

# Direct (no alias needed)
gemini "What are the latest AI developments?"  # Auto-detects need for web search
```

**How Web Search Works:**
- Gemini CLI automatically uses the `google_web_search` tool when needed
- You don't need to explicitly request web search for most queries
- Use `gmw` when you want to be explicit about searching the web

### MCP & Extensions

| Alias | Command | Description |
|-------|---------|-------------|
| `gmm` | `gemini mcp` | MCP server management |
| `gme` | `gemini extensions` | Extension management |
| `gmei` | `gemini extensions install` | Install extension |
| `gmel` | `gemini --list-extensions` | List all extensions |
| `gmeu` | `gemini extensions update` | Update extensions |

### Session Management

| Alias | Command | Description |
|-------|---------|-------------|
| `gmls` | `gemini --list-sessions` | List available sessions |
| `gmds` | `gemini --delete-session` | Delete session by index |
| `gmr` | `gemini --resume latest` | Resume latest session |

### Useful Combinations

| Alias | Command | Description |
|-------|---------|-------------|
| `gmys` | `gemini --yolo --sandbox` | YOLO mode in sandbox |
| `gmyd` | `gemini --yolo --debug` | YOLO with debug output |
| `gmsd` | `gemini --sandbox --debug` | Sandbox with debug |

---

## zsh-claude-workflow Commands

Project context management commands from the zsh-claude-workflow system.

| Alias | Command | Description |
|-------|---------|-------------|
| `ptype` | `proj-type` | Show project type and status |
| `pinfo` | `proj-info` | Full project details |
| `cctx` | `claude-ctx` | Show Claude instruction files |
| `cinit` | `claude-init` | Create CLAUDE.md from template |
| `cshow` | `claude-show` | Display CLAUDE.md |
| `pclaude` | `proj-claude` | Open Claude Code with context |

**Examples:**
```bash
cd ~/R-packages/active/rmediation
ptype                       # Check project type
cctx                        # Show Claude context files
pclaude                     # Launch Claude with context
```

See [Commands Overview](../commands/overview.md) for detailed documentation.

---

## Integration Examples

### Example 1: New R Package Function

```bash
# 1. Create function
rnewfun calculate_mediation

# 2. Write code
vim R/calculate_mediation.R

# 3. Generate docs
ccrdoc

# 4. Generate tests
ccrtest

# 5. Check
rcheck && ccrfix
```

### Example 2: Bug Fix with Claude

```bash
# 1. Test fails
rtest                       # See failure

# 2. Get help
ccrpkg "test is failing, help debug"

# 3. Fix
vim R/myfunction.R

# 4. Verify
rtest

# 5. Review
ccrdiff
```

### Example 3: Research with Gemini

```bash
# Quick web research
gmw "latest R package development best practices 2025"

# Summarize findings
gmws "R CMD check best practices"

# Interactive session
gm
> Research CRAN submission requirements
> What are common reasons for rejection?
```

### Example 4: Code Review Workflow

```bash
# Before submitting PR
ccrdiff                     # Review changes with Claude
ccsecurity                  # Security check
ccrpkg "anything missing for this PR?"

# Quick Gemini check
gmw "R package CRAN submission checklist"
```

---

## Workflow Patterns

### Daily R Development

```bash
# Morning: Start new feature
cd ~/R-packages/active/mypackage
ptype                       # Orient yourself
rload                       # Load package
ccrpkg "help me implement feature X"

# During: Develop with Claude
vim R/newfunction.R         # Write code
ccrdoc                      # Generate docs
ccrtest                     # Generate tests

# Evening: Check and review
rcheck && ccrfix            # Fix any issues
ccrdiff                     # Review changes
git add . && git commit     # Commit
```

### Quick Questions

```bash
# Use Claude for code-specific questions
ccask "how to use map() with multiple arguments?"

# Use Gemini for web research
gmw "latest tidyverse best practices"
```

### Safe Experimentation

```bash
# Try risky operations safely
gms "refactor this complex function"

# Auto-approve known-safe operations
gmy "run standard test suite"
```

---

## Best Practices

### 1. Choose the Right Tool

| Task | Tool | Reason |
|------|------|--------|
| R package code | Claude (`cc`, `ccrpkg`) | Deep code understanding |
| Web research | Gemini (`gmw`, `gmws`) | Web search integration |
| Quick question | Claude (`ccask`) | Fast, focused answers |
| Project setup | zsh-claude (`cinit`, `ptype`) | Context management |

### 2. Use Appropriate Permission Modes

```bash
✅ ccplan "refactor this module"   # Review changes first
✅ ccauto "update docs"             # Safe auto-approval
⚠️  ccyolo "run tests"              # Only in safe environments
```

### 3. Leverage Context

```bash
# Good - provides context
ccrpkg "help with this package"    # Knows package name
ccrdiff                            # Reviews uncommitted changes

# Less good - no context
cc "help with R"                   # Generic
```

### 4. Integrate with Existing Workflow

```bash
# Don't replace - enhance
rload && ccrtest                   # Keep rload, add ccrtest
rcheck && ccrfix                   # Keep rcheck, add ccrfix
```

### 5. Use Model Selection Wisely

```bash
cch "quick syntax check"           # Fast
ccs "implement feature"            # Balanced
cco "complex algorithm design"     # Thorough
```

---

## Configuration Files

### Location

```bash
~/.config/zsh/.zshrc                # All aliases defined here
  Lines 237-330: Claude CLI aliases
  Lines 628-658: Gemini CLI aliases
  Lines 609-621: zsh-claude-workflow
```

### Reference Guides

Comprehensive reference guides available at:
```bash
~/claude-cli-aliases-reference.md   # Claude CLI complete reference
~/gemini-aliases-reference.md       # Gemini CLI complete reference
```

---

## Quick Reference Card

### Most Used Commands

**Claude Code:**
```bash
cc                          # Interactive
ccp "question"             # Quick answer
ccrpkg "context-aware"     # R package help
ccrdiff                    # Review changes
ccrtest                    # Generate tests
```

**Gemini CLI:**
```bash
gm                         # Interactive
gmw "search query"         # Web search
gmws "topic"              # Summarize
gmr                        # Resume
```

**Project Context:**
```bash
ptype                      # Check project
cctx                       # Show context
cinit                      # Create CLAUDE.md
```

---

## Troubleshooting

### Aliases Not Found

```bash
# Re-source configuration
source ~/.config/zsh/.zshrc

# Verify alias exists
type ccask
type gmw

# Check if function is defined
which ccrpkg
```

### Functions Not Working

```bash
# Test function directly
zsh -c 'source ~/.config/zsh/.zshrc && ccask'

# Check for errors
ccask 2>&1 | head
```

### Claude/Gemini Not Installed

```bash
# Check installation
which claude
which gemini

# Install if missing (example)
brew install claude-cli
pip install gemini-cli
```

---

## Related Documentation

- [Command Reference](../commands/reference.md) - Full command documentation
- [Quick Start](../getting-started/quickstart.md) - Getting started guide
- [Context Management](context-management.md) - Managing Claude context
- [Project Types](project-types.md) - Understanding project detection

---

## Status

| Component | Count | Status |
|-----------|-------|--------|
| Claude CLI Aliases | 30 | ✅ Active |
| Claude CLI Functions | 4 | ✅ Active |
| Gemini CLI Aliases | 13 | ✅ Active |
| Gemini CLI Functions | 2 | ✅ Active |
| zsh-claude Aliases | 6 | ✅ Active |
| **Total Shortcuts** | **55** | ✅ All Working |

**Reference Guides:** Complete and up-to-date (2025-12-08)

---

**Pro Tip:** Keep the reference guides handy for detailed usage:
```bash
bat ~/claude-cli-aliases-reference.md
bat ~/gemini-aliases-reference.md
```
