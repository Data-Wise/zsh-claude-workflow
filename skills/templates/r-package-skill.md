# R Package Development - {{PROJECT_NAME}}

Custom R package development guidelines for {{PROJECT_NAME}}.

*Last Updated: {{DATE}}*

## Package Overview

**Package**: {{PROJECT_NAME}}
**Type**: [statistical-methods | data-analysis | shiny | standard]
**Purpose**: [Brief description of what this package does]

## Development Workflow

### Core Cycle

The standard development cycle for this package:

1. **Document**: `rdoc` - Generate documentation from roxygen
2. **Test**: `rtest` - Run all tests
3. **Check**: `rcheck` - R CMD check
4. **Quick**: `rdev` - Run all three steps

### Before Committing

Always run:
```bash
rpkgcommit "commit message"
```

This ensures:
- Documentation is up to date
- Tests pass
- Code is styled (if styler available)
- Changes are committed

## Package-Specific Conventions

### Function Naming

[Describe your function naming conventions]

Examples:
- `calculate_*()` - Calculation functions
- `check_*()` - Validation functions
- `plot_*()` - Plotting functions

### Code Style

- Follow [tidyverse style guide | Google style | custom]
- Use roxygen2 markdown format
- Include @examples in all exported functions
- Minimum 80% test coverage

### Documentation

- All exported functions must have complete roxygen documentation
- Include at least one example per function
- Use `@family` tags to group related functions
- Keep vignettes in vignettes/ directory

### Testing

- Use testthat 3rd edition (testthat::expect_*())
- Test files: `tests/testthat/test-<function-name>.R`
- Cover happy path, edge cases, and error handling
- Aim for >80% coverage

## Statistical Methods (if applicable)

### Notation Standards

[Define your notation conventions]

Examples:
- Y: Outcome variable
- A: Treatment/exposure
- M: Mediator
- C: Confounders

### Key Assumptions

[List key statistical assumptions]

1. Assumption 1...
2. Assumption 2...

## Dependencies

### Required Packages

[List core dependencies]

### Suggested Packages

[List optional dependencies]

## Common Tasks

### Creating New Function

```bash
rnewfun my_function     # Create R/my_function.R
rnewtest my_function    # Create test file
# Edit files
rdev                    # Test changes
```

### Adding Data

```bash
rnewdata my_data        # Create data-raw/my_data.R
# Process data
usethis::use_data(my_data)
```

### Creating Vignette

```bash
rnewvig my-topic
# Edit vignettes/my-topic.Rmd
```

## Package Structure

```
{{PROJECT_NAME}}/
├── R/                  # R source files
├── tests/testthat/     # Test files
├── man/                # Documentation (auto-generated)
├── vignettes/          # Long-form docs
├── data/               # Package data
├── data-raw/           # Data generation scripts
├── DESCRIPTION
├── NAMESPACE
└── README.Rmd
```

## Notes

- Use semantic versioning (MAJOR.MINOR.PATCH)
- Keep NEWS.md updated with changes
- Run `rpkgdown` to build website
- Before CRAN submission: `rcheckcran`, `rcheckwin`, `rcheckrhub`

## Resources

- [R Packages book](https://r-pkgs.org/)
- [Tidyverse style guide](https://style.tidyverse.org/)
- Package website: [URL if available]
