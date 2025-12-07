# CLAUDE.md for {{PROJECT_NAME}}

This file provides guidance to Claude Code when working with this Quarto project.

---

## About This Project

**{{PROJECT_NAME}}** - {{PROJECT_DESCRIPTION}}

### Project Type

[Book / Website / Document / Presentation / Extension]

### Purpose

[Describe the main purpose and audience]

---

## Common Development Commands

```bash
# Quarto workflow (uses aliases from .zshrc)
qp                     # quarto preview
qr                     # quarto render
qc                     # quarto check
qclean                # Clean output files

# Preview workflow
qprev file.qmd        # Preview in background
```

---

## Project Structure

```
{{PROJECT_NAME}}/
├── _quarto.yml       # Project configuration
├── index.qmd         # Main file
├── chapters/         # Chapter files (if book)
├── _extensions/      # Extensions (if any)
└── references.bib    # Bibliography
```

---

## Writing Standards

### Style Guidelines

- [Tone: Academic / Technical / Conversational]
- [Target audience]
- [Formatting preferences]

### Citation Style

- **Style**: [APA / Chicago / etc.]
- **Bibliography**: `references.bib`
- **Citation command**: `[@key]`

---

## Content Organization

### Key Sections

1. [Section 1]
2. [Section 2]
3. [Section 3]

---

## Technical Requirements

### Dependencies

- Quarto version: [version]
- R packages: [if using R chunks]
- Python packages: [if using Python chunks]

### Output Formats

- Primary: [HTML / PDF / etc.]
- Additional: [other formats]

---

## Build and Deployment

```bash
# Local preview
qp

# Build for production
qr

# Deploy
[deployment commands if applicable]
```

---

**Last Updated**: {{DATE}}
**Created with**: zsh-claude-workflow
