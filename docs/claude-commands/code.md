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

### Complete Example: CRAN Submission Check

**Request:**
```
/code/rpkg-check "Full CRAN submission check for my mediation package"
```

**Generated Report:**

```markdown
## R Package Check: rmediation

### Summary
| Check | Status | Details |
|-------|--------|---------|
| R CMD check | ⚠️ 1 NOTE | Package size |
| Test coverage | ✅ 94% | Target: 80% |
| Documentation | ✅ Complete | All exports documented |
| CRAN policy | ✅ Compliant | No issues |

### R CMD check Output

```
* using R version 4.3.2
* checking DESCRIPTION meta-information ... OK
* checking dependencies in R code ... OK
* checking R code for possible problems ... OK
* checking examples ... OK
* checking tests ... OK

Status: 1 NOTE

NOTE: installed size is 5.2Mb
  sub-directories of 1Mb or more: libs 4.1Mb
```

**Recommendation:** NOTE about compiled code size is acceptable for CRAN.

### Test Coverage

```
rmediation Coverage: 94.2%
R/mediate.R: 96%
R/bootstrap.R: 92%
R/montecarlo.R: 95%
R/utils.R: 89%

Missing coverage:
- R/utils.R:45-48 (edge case: empty data)
- R/bootstrap.R:112 (error handler)
```

### Documentation Check

| File | Status |
|------|--------|
| DESCRIPTION | ✅ Complete |
| NAMESPACE | ✅ 12 exports |
| man/*.Rd | ✅ All functions documented |
| NEWS.md | ✅ Current version |
| README.md | ✅ Badges valid |
| vignettes/ | ✅ 2 vignettes build |

### CRAN Policy Compliance

✅ No `:::.` calls
✅ No modification of .GlobalEnv
✅ No calls to `installed.packages()`
✅ Examples run < 5s each
✅ Tests run < 60s total
✅ No CRAN-only dependencies

### Action Items

1. **Optional:** Add tests for edge cases (lines 45-48 in utils.R)
2. **Ready to submit** - No blocking issues

### Submission Command

```r
devtools::submit_cran()
```
```

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

### Complete Example: Closure Error

**Request:**
```
/code/debug "Error in my_function$result: object of type 'closure' is not subsettable"
```

**Generated Debugging Session:**

```markdown
## Debugging: "object of type 'closure' is not subsettable"

### Understanding the Error

This error occurs when you try to use `$` or `[[` on a **function** instead of a list/data.frame.

"Closure" is R's term for a function. You're treating a function like a data structure.

### Common Causes

1. **Forgot to call the function:**
   ```r
   # Wrong - my_function is a function, not its result
   my_function$result

   # Right - call the function first
   my_function()$result
   ```

2. **Variable shadowed by function name:**
   ```r
   # You have both:
   mean <- function(x) sum(x)/length(x)  # Your function
   mean <- c(1, 2, 3)                     # Overwrote with vector

   # Later R finds the function 'mean' from base, not your vector
   mean$something  # Error!
   ```

3. **Typo in object name:**
   ```r
   results <- list(a = 1, b = 2)
   result$a  # Typo! 'result' might be a function
   ```

### Diagnosis Steps

**Step 1:** Check what the object actually is:
```r
class(my_function)
# [1] "function"  <- This is the problem
typeof(my_function)
# [1] "closure"
```

**Step 2:** Find where it was defined:
```r
# In RStudio: Ctrl+F to search for "my_function <-"
# Or check your environment
ls(pattern = "my_function")
```

**Step 3:** Check if you meant to call it:
```r
# If my_function() returns a list:
result <- my_function()
result$value  # Now works
```

### The Fix

Based on typical patterns, try:

```r
# Instead of:
my_function$result

# Use:
my_function()$result

# Or store the result first:
output <- my_function()
output$result
```

### Prevention

```r
# Use explicit variable names to avoid confusion
calculate_stats <- function(x) { ... }  # Function
stats_result <- calculate_stats(data)    # Result
stats_result$mean                         # Access
```
```

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

### Complete Example: Effect Size Tests

**Request:**
```
/code/test-gen "Generate comprehensive tests for calculate_cohens_d()"
```

**Generated Tests:**

```r
# tests/testthat/test-cohens-d.R

test_that("calculate_cohens_d returns correct value for known data", {

  # Known example: d = 0.5 (medium effect)
  group1 <- c(100, 102, 98, 101, 99)
  group2 <- c(105, 107, 103, 106, 104)

  result <- calculate_cohens_d(group1, group2)

  expect_type(result, "double")
  expect_length(result, 1)
  expect_equal(result, 2.0, tolerance = 0.01)
})

test_that("calculate_cohens_d handles equal means",
{
  group1 <- c(1, 2, 3, 4, 5)
  group2 <- c(1, 2, 3, 4, 5)

  result <- calculate_cohens_d(group1, group2)

  expect_equal(result, 0)
})

test_that("calculate_cohens_d handles negative effect", {
  group1 <- c(10, 11, 12)
  group2 <- c(5, 6, 7)

  result <- calculate_cohens_d(group1, group2)

  expect_lt(result, 0)  # Negative when group1 > group2
})

# Edge cases
test_that("calculate_cohens_d handles minimum valid input", {
  # n = 2 per group (minimum for SD calculation)
  group1 <- c(1, 2)
  group2 <- c(3, 4)

  expect_no_error(calculate_cohens_d(group1, group2))
})

test_that("calculate_cohens_d handles unequal group sizes", {
  group1 <- c(1, 2, 3)
  group2 <- c(4, 5, 6, 7, 8)

  expect_no_error(calculate_cohens_d(group1, group2))
})

# Error handling
test_that("calculate_cohens_d errors on single observation", {
  expect_error(
    calculate_cohens_d(c(1), c(2, 3)),
    "at least 2 observations"
  )
})

test_that("calculate_cohens_d errors on empty input", {
  expect_error(
    calculate_cohens_d(numeric(0), c(1, 2)),
    "empty"
  )
})

test_that("calculate_cohens_d errors on non-numeric input", {
  expect_error(
    calculate_cohens_d(c("a", "b"), c(1, 2)),
    "numeric"
  )
})

# Special values
test_that("calculate_cohens_d handles NA values", {
  group1 <- c(1, 2, NA, 4)
  group2 <- c(5, 6, 7, 8)

  # Default: na.rm = FALSE should error or return NA

  expect_true(is.na(calculate_cohens_d(group1, group2)))

  # With na.rm = TRUE
  result <- calculate_cohens_d(group1, group2, na.rm = TRUE)
  expect_false(is.na(result))
})

test_that("calculate_cohens_d handles Inf values", {
  group1 <- c(1, 2, Inf)
  group2 <- c(4, 5, 6)

  expect_warning(
    calculate_cohens_d(group1, group2),
    "infinite"
  )
})

test_that("calculate_cohens_d handles zero variance", {
  # All same values = SD of 0
  group1 <- c(5, 5, 5)
  group2 <- c(10, 10, 10)

  expect_warning(
    result <- calculate_cohens_d(group1, group2),
    "zero variance"
  )
  expect_equal(result, Inf)  # Or handle differently
})
```

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
