# Quarto Project - {{PROJECT_NAME}}

Quarto project conventions and workflows for {{PROJECT_NAME}}.

*Last Updated: {{DATE}}*

## Project Overview

**Project**: {{PROJECT_NAME}}
**Type**: [manuscript | website | presentation | book]
**Output**: [HTML | PDF | RevealJS | etc.]

## Workflow

### Development

```bash
qp                      # Preview (quarto preview)
qr                      # Render (quarto render)
qc                      # Check (quarto check)
```

### Interactive Workflow

```bash
qwork index.qmd        # Opens editor + starts preview
```

## Project Structure

```
{{PROJECT_NAME}}/
├── _quarto.yml        # Project configuration
├── index.qmd          # Main file
├── references.bib     # Bibliography (if applicable)
├── _extensions/       # Quarto extensions
└── _site/             # Rendered output (gitignored)
```

## Writing Conventions

### Markdown Style

[Define your markdown conventions]

- Headings: Use ATX style (`#`, `##`, `###`)
- Lists: Use `-` for unordered, `1.` for ordered
- Code blocks: Always specify language

### Citations

[If using citations]

Format: `@author2024` or `[@author2024]`

Bibliography: `references.bib`

### Code Chunks

R code chunks:
```{r}
#| label: chunk-name
#| echo: false
#| warning: false

# Code here
```

## Rendering

### HTML

```bash
quarto render --to html
```

### PDF

```bash
quarto render --to pdf
```

### Both

```bash
quarto render
```

## Extensions

[List any Quarto extensions used]

- Extension 1: Purpose
- Extension 2: Purpose

## Publishing

[Describe publishing workflow]

- GitHub Pages: `quarto publish gh-pages`
- Netlify: `quarto publish netlify`
- Other: [describe]

## Notes

- Keep large files out of git (use .gitignore)
- Clean build: `qclean` then `qr`
- Preview doesn't always match final render - test renders periodically

## Resources

- [Quarto Documentation](https://quarto.org/)
- [Project website](URL if available)
