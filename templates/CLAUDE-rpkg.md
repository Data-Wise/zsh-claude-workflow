# CLAUDE.md for {{PACKAGE_NAME}}

This file provides guidance to Claude Code when working with code in this repository.

---

## About This Package

**{{PACKAGE_NAME}}** - {{PACKAGE_DESCRIPTION}}

### Core Mission

[Describe the main purpose and goals of this package]

### Key Features

- Feature 1
- Feature 2
- Feature 3

---

## Common Development Commands

```bash
# Development workflow (uses aliases from .zshrc)
rload                  # devtools::load_all()
rdoc                   # devtools::document()
rtest                  # devtools::test()
rcheck                 # devtools::check()

# Full cycle
rdev                   # doc → test → check

# Commit with validation
rpkgcommit "message"   # doc → test → style → commit
```

---

## Coding Standards

### R Version and Style

- **Minimum R version**: [e.g., 3.5.0]
- **Style**: [tidyverse / your preference]
- **Namespacing**: Use explicit `package::function()` for non-base functions

### Naming Conventions

| Type | Convention | Examples |
|------|------------|----------|
| Functions | [snake_case / camelCase] | `function_name()` |
| Arguments | [snake_case / dot.case] | `arg_name` |
| Internal helpers | [prefix with .] | `.helper_function()` |

---

## Code Architecture

### Core Functions

| Function | Purpose | Use For |
|----------|---------|---------|
| `main_function()` | [Description] | [Use case] |

### Key Dependencies

- **Package1**: [Purpose]
- **Package2**: [Purpose]

---

## Testing Strategy

### Coverage Targets

- **Target**: >80% overall
- Test core functionality thoroughly
- Test edge cases and error handling

### Testing Commands

```bash
rtest                  # Run all tests
rtest1 "pattern"       # Run specific test
rtestfile path/to/test # Run single test file
rcov                   # Check coverage
```

---

## Integration with Ecosystem

[If this package is part of a larger ecosystem, describe relationships]

### Related Packages

| Package | Purpose | Relationship |
|---------|---------|--------------|
| [name] | [purpose] | [how they relate] |

---

## Key References

- Reference 1
- Reference 2

---

**Last Updated**: {{DATE}}
**Created with**: zsh-claude-workflow
