# Citation Lookup

You are helping find and format citations for a manuscript.

## Task

Find citation for: **$ARGUMENTS**

## Search Strategy

### Step 1: Identify What's Needed
- Is this a specific paper (by title/author)?
- Is this a concept that needs a canonical citation?
- Is this recent work (use arXiv)?
- Is this a foundational result (use CrossRef/bibtex)?

### Step 2: Search Sources

**For specific papers:**
1. Search local BibTeX first (bibtex_search)
2. If not found, search CrossRef by DOI or title
3. If still not found, search arXiv

**For concepts:**
Common canonical citations in mediation/causal inference:

| Concept | Canonical Citation |
|---------|-------------------|
| Baron-Kenny mediation | Baron & Kenny (1986) |
| Causal mediation | VanderWeele (2015) |
| Potential outcomes | Rubin (1974) |
| DAGs | Pearl (2009) |
| Propensity scores | Rosenbaum & Rubin (1983) |
| Double robustness | Robins et al. (1994) |
| AIPW | Robins, Rotnitzky, Zhao (1994) |
| Influence functions | Hampel (1974) |
| Semiparametric efficiency | Bickel et al. (1993) |
| Simulation guidelines | Morris et al. (2019) |

### Step 3: Format Output

Provide:
1. **BibTeX entry** (ready to paste)
2. **In-text citation** (Author, Year)
3. **Full reference** (APA style)

## Output Format

```markdown
## Citation Found

### In-Text
`\citet{citekey}` → Author et al. (Year)
`\citep{citekey}` → (Author et al., Year)

### BibTeX Entry
```bibtex
@article{citekey,
  author = {...},
  title = {...},
  ...
}
```

### Full Reference (APA)
Author, A. A., & Author, B. B. (Year). Title. *Journal*, Volume(Issue), Pages. DOI

### Notes
[Any relevant context about this paper/when to cite it]
```

## Tools to Use
- bibtex_search (search local .bib)
- crossref_lookup (get by DOI)
- arxiv_search (search arXiv)
