# Math Commands

Commands for mathematical work: proofs, derivations, notation standardization, and worked examples.

## Commands Overview

| Command | Purpose |
|---------|---------|
| `/math/proof` | Verify mathematical proofs |
| `/math/derive` | Step-by-step derivations |
| `/math/notation` | Standardize notation |
| `/math/example` | Create worked examples |

---

## /math/proof

Verify and check mathematical proofs.

**Use for:**
- Proof verification
- Logical gap identification
- Alternative proof suggestions
- Theorem checking

**Example:**
```
/math/proof "Verify this proof that the variance of a sum equals sum of variances for independent RVs"
```

**Output includes:**
- Step-by-step verification
- Identified gaps or errors
- Suggested corrections
- Alternative approaches

---

## /math/derive

Create step-by-step mathematical derivations.

**Use for:**
- Paper appendices
- Lecture demonstrations
- Student solutions
- Technical documentation

**Example:**
```
/math/derive "Derive the variance of the indirect effect ab in mediation analysis"
```

**Context awareness:**
- Research: Rigorous, cites prior work
- Teaching: Pedagogical, explains intuition

**Output format:**
```
## Derivation: [Title]

### Starting Point
[Assumptions and given formulas]

### Step 1: [Description]
$$[Mathematical expression]$$
[Explanation]

### Step 2: [Description]
...

### Result
$$\boxed{[Final result]}$$
```

---

## /math/notation

Standardize mathematical notation across documents.

**Use for:**
- Notation guides for papers
- Course material consistency
- LaTeX macro definitions
- Symbol tables

**Example:**
```
/math/notation "Create a notation guide for my mediation analysis paper"
```

**Standard conventions:**

| Type | Convention | Example |
|------|------------|---------|
| Random variables | Uppercase | $X$, $Y$ |
| Realizations | Lowercase | $x$, $y$ |
| Vectors | Bold lowercase | $\mathbf{x}$ |
| Matrices | Bold uppercase | $\mathbf{X}$ |
| Parameters | Greek | $\beta$, $\theta$ |
| Estimates | Hat | $\hat{\beta}$ |

**LaTeX macros generated:**
```latex
\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\text{Var}}
\newcommand{\bx}{\mathbf{x}}
\newcommand{\bbeta}{\boldsymbol{\beta}}
```

---

## /math/example

Create detailed worked examples.

**Use for:**
- Textbook problems
- Lecture demonstrations
- Paper appendices
- Student practice

**Example:**
```
/math/example "Create a worked example of calculating Cohen's d"
```

**Output format:**
```
## Worked Example: [Title]

### Problem
[Complete problem statement]

**Given:** [Information provided]
**Find:** [What to calculate]

### Solution

**Step 1:** [Description]
$$[Expression]$$

**Step 2:** [Description]
...

### Answer
$$\boxed{[Final answer]}$$

### Interpretation
[What this means in context]
```

---

## Use Cases

### For Research Papers

```
/math/notation "standardize notation for regression paper"
/math/derive "derive the standard error of the indirect effect"
/math/proof "verify the delta method approximation"
```

### For Teaching

```
/math/example "ANOVA F-test calculation with real data"
/math/derive "show how to derive the OLS estimator"
/math/notation "create notation guide for stats course"
```

### For Both Contexts

Many commands adapt to context:

| Command | Research Context | Teaching Context |
|---------|------------------|------------------|
| `/math/derive` | Rigorous, cite sources | Pedagogical, intuitive |
| `/math/example` | Publication appendix | Student practice |
| `/math/notation` | Paper consistency | Course standardization |

---

## Tips

- Use `/math/notation` early in a project for consistency
- `/math/derive` can produce LaTeX-ready output
- `/math/example` works best with realistic numbers
- `/math/proof` can suggest alternative proof strategies
