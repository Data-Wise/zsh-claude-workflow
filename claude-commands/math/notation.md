# Standardize Notation

Create consistent mathematical notation for papers and courses.

## Purpose

Establish and apply notation standards for:
- Research manuscripts
- Course materials
- Technical documentation
- Cross-document consistency

## Required Input

- **Context**: Paper, course, or project
- **Field**: Statistics, machine learning, etc.
- **Variables**: Key quantities to notate
- **Existing conventions**: If following a standard

## Process

1. **Identify quantities**
   - Random variables vs. fixed
   - Scalars, vectors, matrices
   - Parameters vs. estimates
   - Observed vs. latent

2. **Apply conventions**
   - Choose notation style
   - Maintain consistency
   - Document choices

3. **Create reference**
   - Notation table
   - Usage guidelines
   - Examples

## Output Format

```markdown
## Notation Guide

### General Conventions

| Type | Convention | Example |
|------|------------|---------|
| Random variables | Uppercase | $X$, $Y$ |
| Realizations | Lowercase | $x$, $y$ |
| Vectors | Bold lowercase | $\mathbf{x}$ |
| Matrices | Bold uppercase | $\mathbf{X}$ |
| Parameters | Greek | $\beta$, $\theta$ |
| Estimates | Hat | $\hat{\beta}$ |
| Population | No subscript | $\mu$ |
| Sample | Bar | $\bar{x}$ |

### Project-Specific Notation

| Symbol | Meaning | Notes |
|--------|---------|-------|
| $Y$ | Outcome variable | |
| $X$ | Treatment indicator | Binary: 0/1 |
| $M$ | Mediator | |
| $a$ | $X \to M$ effect | |
| $b$ | $M \to Y$ effect | |

### Subscript Conventions
- $i$: Individual/observation
- $j$: Group/cluster
- $t$: Time point
- $k$: Category/level

### Operator Notation
- $E[\cdot]$: Expectation
- $\text{Var}(\cdot)$: Variance
- $\text{Cov}(\cdot, \cdot)$: Covariance
- $P(\cdot)$: Probability
```

## Common Standards

### Statistics
```latex
% Random variables: uppercase
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i

% Estimates: hat
\hat{\beta}_1 = \frac{\sum(X_i - \bar{X})(Y_i - \bar{Y})}{\sum(X_i - \bar{X})^2}

% Matrices: bold uppercase
\mathbf{Y} = \mathbf{X}\boldsymbol{\beta} + \boldsymbol{\epsilon}
```

### Machine Learning
```latex
% Loss function
\mathcal{L}(\theta) = -\sum_{i=1}^{n} \log p(y_i | x_i, \theta)

% Model parameters
\theta = \{W^{(1)}, b^{(1)}, W^{(2)}, b^{(2)}\}
```

### Mediation Analysis
```latex
% Path coefficients
M = i_M + aX + e_M
Y = i_Y + bM + c'X + e_Y

% Indirect effect
ab = a \times b

% Confidence interval
CI_{95\%} = [ab_{lower}, ab_{upper}]
```

## LaTeX Commands

```latex
% Define custom commands for consistency
\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\text{Var}}
\newcommand{\Cov}{\text{Cov}}
\newcommand{\bx}{\mathbf{x}}
\newcommand{\bX}{\mathbf{X}}
\newcommand{\bbeta}{\boldsymbol{\beta}}
```

## Examples

**Request**: "Create a notation guide for my mediation analysis paper"

**Request**: "Standardize notation across my regression course materials"

**Request**: "Convert this paper's notation to match journal style"

**Request**: "Create LaTeX macros for consistent notation"

## Tips

- Define all notation before first use
- Use familiar conventions when possible
- Avoid overloading symbols
- Include a notation table in papers
- Keep subscript schemes consistent
- Document any non-standard choices

## Common Pitfalls

- Using same letter for different things
- Inconsistent case conventions
- Missing definitions
- Changing notation mid-document
- Overly complex subscripting
