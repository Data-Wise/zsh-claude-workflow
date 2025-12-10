# Code Commands

Commands for software development: R packages, documentation, testing, releases, and debugging.

## Commands Overview

| Command | Purpose |
|---------|---------|
| `/code/rpkg-check` | R package validation |
| `/code/ecosystem-health` | Multi-package check |
| `/code/docs-check` | Documentation validation |
| `/code/release` | Release workflow guidance |
| `/code/debug` | Debugging assistance |
| `/code/refactor` | Refactoring guidance |
| `/code/test-gen` | Generate test cases |
| `/code/demo` | Code demonstrations |

---

## /code/rpkg-check

Validate R package structure and quality.

**Use for:**
- Pre-CRAN submission checks
- Package quality assurance
- Identifying issues early
- CI/CD validation

**Example:**
```
/code/rpkg-check "Check my mediation package for CRAN submission"
```

**MCP Integration:** `r_check`, `r_test`, `r_coverage` tools

**Checks performed:**
- R CMD check
- Test coverage
- Documentation completeness
- CRAN policy compliance

---

## /code/ecosystem-health

Check health of multiple related packages.

**Use for:**
- Package suite maintenance
- Dependency compatibility
- Cross-package testing
- Release coordination

**Example:**
```
/code/ecosystem-health "Check all packages in ~/R-packages/active/"
```

---

## /code/docs-check

Validate documentation before deployment.

**Use for:**
- Pre-deployment checks
- Version sync verification
- Link validation
- Build testing

**Example:**
```
/code/docs-check "Validate docs before GitHub Pages deployment"
```

**Also available as shell command:**
```bash
docs-check --quick --skip-deploy
```

**Checks performed:**
- Version sync across files
- Badge validation (static vs dynamic)
- Internal link checking
- Build success
- Optional: external link checking

---

## /code/release

Guide through release workflow.

**Use for:**
- Version bumping
- CRAN submission
- npm publishing
- GitHub releases

**Example:**
```
/code/release "Help me release v1.2.0 of my R package"
```

**Workflow:**
1. Version bump
2. Update NEWS/CHANGELOG
3. Run checks
4. Tag release
5. Push and publish

---

## /code/debug

Systematic debugging assistance.

**Use for:**
- Error interpretation
- Root cause analysis
- Reproduction steps
- Fix suggestions

**Example:**
```
/code/debug "Help me fix: object of type 'closure' is not subsettable"
```

**MCP Integration:** `r_execute`, `r_inspect` tools

**Process:**
1. Understand the problem
2. Create minimal reproduction
3. Diagnose root cause
4. Suggest fix
5. Verify solution

---

## /code/refactor

Guidance for improving code structure.

**Use for:**
- Code cleanup
- DRY improvements
- Readability enhancements
- Performance optimization

**Example:**
```
/code/refactor "Simplify this 100-line function into smaller pieces"
```

**Common refactorings:**
- Extract function
- Rename for clarity
- Simplify conditionals
- Remove duplication

---

## /code/test-gen

Generate comprehensive test cases.

**Use for:**
- Unit tests
- Edge case coverage
- Regression tests
- Integration tests

**Example:**
```
/code/test-gen "Generate tests for my calculate_effect_size function"
```

**MCP Integration:** `r_test` tool

**Test categories:**
- Happy path (normal usage)
- Edge cases (empty, single, max)
- Error handling (invalid input)
- Special values (NA, NULL, Inf)

---

## /code/demo

Create code demonstrations and examples.

**Use for:**
- Package vignettes
- Tutorial materials
- Conference presentations
- Documentation examples

**Example:**
```
/code/demo "Create a demo of linear regression in R for beginners"
```

**MCP Integration:** `r_execute`, `r_plot` tools

**Demo types:**
- Quick example (~10 lines)
- Tutorial (step-by-step)
- Vignette (comprehensive)
- Live coding (presentation format)

---

## Workflows

### R Package Development
```
1. /code/test-gen "write tests for new function"
2. /code/rpkg-check "run package checks"
3. /code/docs-check "validate documentation"
4. /code/release "prepare release"
```

### Bug Fixing
```
1. /code/debug "diagnose the issue"
2. /code/test-gen "add regression test"
3. /code/rpkg-check "verify fix"
```

### Code Improvement
```
1. /code/refactor "improve code structure"
2. /code/test-gen "ensure tests cover changes"
3. /code/demo "update examples"
```

---

## Shell Command: docs-check

The `/code/docs-check` command has a corresponding shell command:

```bash
# Quick validation
docs-check --quick --skip-deploy

# Full check with deployment
docs-check

# Options
docs-check --help
docs-check --verbose
docs-check --external  # Check external links
docs-check --strict    # Strict build mode
```
