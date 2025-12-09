# Derive Formula

Step-by-step mathematical derivation for research papers or teaching materials.

## Required Input

- **Starting Point**: Initial assumptions, formulas, or definitions
- **Target Result**: What you want to derive
- **Context**: Research paper, lecture notes, or exam solution
- **Notation Style**: LaTeX, Markdown math, or plain text

## Process

1. **State Assumptions**: List all starting assumptions clearly
2. **Show Each Step**: Provide algebraic/calculus steps with justification
3. **Highlight Key Insights**: Mark non-obvious steps or tricks
4. **Verify Result**: Check dimensional consistency and special cases
5. **Format Output**: Appropriate for the context

## Output Format

### For Research Papers (LaTeX)

```latex
\begin{align}
\text{Starting from } & E[ab] = E[a]E[b] + \text{Cov}(a,b) \\
\text{By independence: } & \text{Cov}(a,b) = 0 \\
\therefore \quad & E[ab] = E[a]E[b]
\end{align}
```

### For Lecture Notes (Markdown)

```markdown
**Step 1**: Start with the definition of variance
$$\text{Var}(X) = E[(X - \mu)^2]$$

**Step 2**: Expand the square
$$= E[X^2 - 2\mu X + \mu^2]$$

**Step 3**: Apply linearity of expectation
$$= E[X^2] - 2\mu E[X] + \mu^2$$

**Step 4**: Substitute $E[X] = \mu$
$$= E[X^2] - \mu^2$$
```

## Context-Specific Guidance

### Research Context
- Be rigorous with notation
- Cite prior work for known results
- Include regularity conditions
- State when interchange of limits/integrals is valid

### Teaching Context
- Explain intuition at each step
- Use concrete numerical examples
- Highlight common mistakes
- Connect to learning objectives

### Exam Solutions
- Show all work clearly
- Justify each step briefly
- Box final answers
- Note partial credit points

## Common Derivation Types

### Statistics
- Variance of estimators
- Bias calculations
- Confidence interval derivations
- Test statistic distributions

### Regression
- OLS estimator derivation
- Standard error formulas
- R² decomposition
- Multicollinearity effects

### Mediation Analysis
- Indirect effect formulas
- Variance of products (Sobel)
- Delta method applications
- Bootstrap justifications

## Example Prompts

**Research**: "Derive the variance of the product of two normal random variables ab. This is for a methods paper on mediation analysis. Use LaTeX notation."

**Teaching**: "Derive the formula for the standard error of the mean. This is for an intro stats lecture. Include intuition about why n is in the denominator."

**Exam**: "Derive the OLS estimator for simple linear regression using calculus. Show all steps for a midterm solution key."

## Tips

1. **Check Your Work**: Verify with special cases (e.g., n=1, σ=0)
2. **Define Everything**: Don't assume notation is understood
3. **Be Explicit**: State when you use known results vs. derive from scratch
4. **Match Audience**: Graduate vs. undergraduate level of detail
