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

### Complete Example: Variance of Sum

**Request:**
```
/math/proof "Verify: For independent random variables X and Y,
Var(X + Y) = Var(X) + Var(Y)"
```

**Generated Verification:**

```markdown
## Proof Verification: Variance of Sum of Independent RVs

### Statement
For independent random variables X and Y:
$$\text{Var}(X + Y) = \text{Var}(X) + \text{Var}(Y)$$

### Verification

**Step 1: Apply variance definition**
$$\text{Var}(X + Y) = \mathbb{E}[(X + Y)^2] - (\mathbb{E}[X + Y])^2$$
✓ Correct application of Var(Z) = E[Z²] - (E[Z])²

**Step 2: Expand the squared term**
$$\mathbb{E}[(X + Y)^2] = \mathbb{E}[X^2 + 2XY + Y^2]$$
$$= \mathbb{E}[X^2] + 2\mathbb{E}[XY] + \mathbb{E}[Y^2]$$
✓ Correct by linearity of expectation

**Step 3: Apply independence**
For independent X, Y: $\mathbb{E}[XY] = \mathbb{E}[X]\mathbb{E}[Y]$
$$2\mathbb{E}[XY] = 2\mathbb{E}[X]\mathbb{E}[Y]$$
✓ This is where independence is crucial

**Step 4: Expand the squared expectation**
$$(\mathbb{E}[X + Y])^2 = (\mathbb{E}[X] + \mathbb{E}[Y])^2$$
$$= (\mathbb{E}[X])^2 + 2\mathbb{E}[X]\mathbb{E}[Y] + (\mathbb{E}[Y])^2$$
✓ Correct algebraic expansion

**Step 5: Combine and simplify**
$$\text{Var}(X + Y) = \mathbb{E}[X^2] + 2\mathbb{E}[X]\mathbb{E}[Y] + \mathbb{E}[Y^2]$$
$$\quad - (\mathbb{E}[X])^2 - 2\mathbb{E}[X]\mathbb{E}[Y] - (\mathbb{E}[Y])^2$$
The cross-terms $2\mathbb{E}[X]\mathbb{E}[Y]$ cancel:
$$= (\mathbb{E}[X^2] - (\mathbb{E}[X])^2) + (\mathbb{E}[Y^2] - (\mathbb{E}[Y])^2)$$
$$= \text{Var}(X) + \text{Var}(Y) \quad \square$$

### Verdict
✓ **Proof is valid.** All steps are justified.

### Notes
- Independence is essential (Step 3)
- For dependent variables: Var(X+Y) = Var(X) + Var(Y) + 2Cov(X,Y)
- Generalizes to n variables: Var(∑Xᵢ) = ∑Var(Xᵢ) when pairwise independent
```

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

### Complete Example: Indirect Effect Variance

**Request:**
```
/math/derive "Derive the variance of the indirect effect ab
in simple mediation using the delta method"
```

**Generated Derivation:**

```markdown
## Derivation: Variance of the Indirect Effect (Delta Method)

### Starting Point

In simple mediation:
- $M = i_M + aX + e_M$
- $Y = i_Y + bM + c'X + e_Y$

The indirect effect is: $ab$

**Goal:** Derive $\text{Var}(\hat{a}\hat{b})$

### Step 1: State the delta method

For a function $g(\theta)$ of parameters $\theta$ with estimates $\hat{\theta}$:
$$\text{Var}(g(\hat{\theta})) \approx \nabla g(\theta)^\top \, \Sigma_\theta \, \nabla g(\theta)$$

where $\nabla g(\theta)$ is the gradient and $\Sigma_\theta$ is the covariance matrix.

### Step 2: Define the function and gradient

Let $g(a, b) = ab$

The gradient is:
$$\nabla g(a, b) = \begin{pmatrix} \frac{\partial(ab)}{\partial a} \\ \frac{\partial(ab)}{\partial b} \end{pmatrix} = \begin{pmatrix} b \\ a \end{pmatrix}$$

### Step 3: Specify the covariance matrix

Since $\hat{a}$ and $\hat{b}$ come from separate regressions, they are independent:
$$\Sigma = \begin{pmatrix} \text{Var}(\hat{a}) & 0 \\ 0 & \text{Var}(\hat{b}) \end{pmatrix} = \begin{pmatrix} \sigma_a^2 & 0 \\ 0 & \sigma_b^2 \end{pmatrix}$$

### Step 4: Apply the delta method formula

$$\text{Var}(\hat{a}\hat{b}) \approx \begin{pmatrix} b & a \end{pmatrix} \begin{pmatrix} \sigma_a^2 & 0 \\ 0 & \sigma_b^2 \end{pmatrix} \begin{pmatrix} b \\ a \end{pmatrix}$$

$$= \begin{pmatrix} b\sigma_a^2 & a\sigma_b^2 \end{pmatrix} \begin{pmatrix} b \\ a \end{pmatrix}$$

$$= b^2\sigma_a^2 + a^2\sigma_b^2$$

### Result

$$\boxed{\text{Var}(\hat{a}\hat{b}) \approx b^2 \text{Var}(\hat{a}) + a^2 \text{Var}(\hat{b})}$$

### Notes

- This is the **Sobel (1982)** formula
- Standard error: $SE_{ab} = \sqrt{b^2 s_a^2 + a^2 s_b^2}$
- First-order approximation; ignores higher-order terms
- Alternative: multivariate delta includes $s_a^2 s_b^2$ term
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

### Complete Example: Mediation Notation Guide

**Request:**
```
/math/notation "Create a notation guide for my sequential mediation paper"
```

**Generated Guide:**

```markdown
## Notation Guide: Sequential Mediation Analysis

### Variables

| Symbol | Description | Type |
|--------|-------------|------|
| $X$ | Treatment/predictor | Observed |
| $M_1$ | First mediator | Observed |
| $M_2$ | Second mediator | Observed |
| $Y$ | Outcome | Observed |
| $\mathbf{C}$ | Covariates vector | Observed |

### Path Coefficients

| Symbol | Equation | Interpretation |
|--------|----------|----------------|
| $a_1$ | $M_1 = a_1 X + \ldots$ | $X \to M_1$ |
| $a_2$ | $M_2 = a_2 X + \ldots$ | $X \to M_2$ |
| $d_{21}$ | $M_2 = d_{21} M_1 + \ldots$ | $M_1 \to M_2$ |
| $b_1$ | $Y = b_1 M_1 + \ldots$ | $M_1 \to Y$ |
| $b_2$ | $Y = b_2 M_2 + \ldots$ | $M_2 \to Y$ |
| $c'$ | $Y = c' X + \ldots$ | Direct effect |

### Effects

| Symbol | Formula | Name |
|--------|---------|------|
| $a_1 b_1$ | $a_1 \times b_1$ | Indirect through $M_1$ only |
| $a_2 b_2$ | $a_2 \times b_2$ | Indirect through $M_2$ only |
| $a_1 d_{21} b_2$ | $a_1 \times d_{21} \times b_2$ | Serial indirect |
| $c'$ | Direct coefficient | Direct effect |
| $c$ | $a_1 b_1 + a_2 b_2 + a_1 d_{21} b_2 + c'$ | Total effect |

### Distributional Notation

| Symbol | Meaning |
|--------|---------|
| $\hat{\theta}$ | Estimate of $\theta$ |
| $\theta^*$ | Bootstrap replicate |
| $\text{SE}(\hat{\theta})$ | Standard error |
| $\text{CI}_{95}$ | 95% confidence interval |

### LaTeX Macros

```latex
% Expectations and variance
\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\operatorname{Var}}
\newcommand{\Cov}{\operatorname{Cov}}
\newcommand{\SE}{\operatorname{SE}}

% Vectors and matrices
\newcommand{\bC}{\mathbf{C}}
\newcommand{\btheta}{\boldsymbol{\theta}}

% Effects
\newcommand{\ind}{\text{ind}}
\newcommand{\dir}{\text{dir}}
\newcommand{\tot}{\text{tot}}

% Estimates
\newcommand{\ahat}{\hat{a}}
\newcommand{\bhat}{\hat{b}}
```
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

### Complete Example: Cohen's d Calculation

**Request:**
```
/math/example "Create a worked example of calculating Cohen's d
for independent samples"
```

**Generated Example:**

```markdown
## Worked Example: Cohen's d for Independent Samples

### Problem

A researcher compares exam scores between two teaching methods.

**Group 1 (Traditional):** n₁ = 25, M₁ = 72.4, SD₁ = 8.2
**Group 2 (Active Learning):** n₂ = 28, M₂ = 78.1, SD₂ = 9.5

Calculate Cohen's d to quantify the effect size.

**Given:**
- Group 1: $n_1 = 25$, $\bar{X}_1 = 72.4$, $s_1 = 8.2$
- Group 2: $n_2 = 28$, $\bar{X}_2 = 78.1$, $s_2 = 9.5$

**Find:** Cohen's $d$

### Solution

**Step 1:** Calculate the pooled standard deviation

$$s_p = \sqrt{\frac{(n_1 - 1)s_1^2 + (n_2 - 1)s_2^2}{n_1 + n_2 - 2}}$$

$$s_p = \sqrt{\frac{(25-1)(8.2)^2 + (28-1)(9.5)^2}{25 + 28 - 2}}$$

$$s_p = \sqrt{\frac{(24)(67.24) + (27)(90.25)}{51}}$$

$$s_p = \sqrt{\frac{1613.76 + 2436.75}{51}} = \sqrt{\frac{4050.51}{51}} = \sqrt{79.42}$$

$$s_p = 8.91$$

**Step 2:** Calculate Cohen's d

$$d = \frac{\bar{X}_2 - \bar{X}_1}{s_p} = \frac{78.1 - 72.4}{8.91} = \frac{5.7}{8.91}$$

### Answer

$$\boxed{d = 0.64}$$

### Interpretation

- **Effect size:** Medium (Cohen's conventions: 0.2 = small, 0.5 = medium, 0.8 = large)
- **Meaning:** Active learning group scored 0.64 standard deviations higher
- **Practical significance:** Students using active learning scored about 5.7 points higher, roughly half a letter grade

### R Verification

```r
# Manual calculation
sp <- sqrt(((25-1)*8.2^2 + (28-1)*9.5^2) / (25+28-2))
d <- (78.1 - 72.4) / sp
d  # 0.6396

# Using effectsize package
library(effectsize)
cohens_d(c(rep(72.4, 25), rep(78.1, 28)),
         c(rep(8.2, 25), rep(9.5, 28)))
```
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
