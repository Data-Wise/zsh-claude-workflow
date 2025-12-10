# Create Worked Example

Generate step-by-step worked examples for teaching or papers.

## Purpose

Create detailed worked examples for:
- Textbook problems
- Lecture demonstrations
- Paper appendices
- Student solutions
- Self-study materials

## Required Input

- **Problem type**: What mathematical concept
- **Audience**: Undergrad, grad, professional
- **Context**: Teaching vs. research
- **Level of detail**: Brief or exhaustive

## Process

1. **State the problem**
   - Clear problem statement
   - Given information
   - What to find

2. **Set up the solution**
   - Identify approach
   - State relevant formulas
   - Define notation

3. **Solve step-by-step**
   - Show all work
   - Explain each step
   - Include intermediate results

4. **Interpret**
   - State the answer clearly
   - Explain what it means
   - Note limitations

## Output Format

```markdown
## Worked Example: [Title]

### Problem
[Complete problem statement]

**Given:**
- [Given information]

**Find:**
- [What to calculate/show]

### Solution

**Step 1: [Description]**

[Explanation of what we're doing]

$$
[Mathematical expression]
$$

**Step 2: [Description]**

[Continue with next step]

$$
[Expression]
$$

[Continue for all steps...]

### Answer
$$
\boxed{[Final answer]}
$$

### Interpretation
[What this result means in context]

### Key Takeaways
- [Learning point 1]
- [Learning point 2]
```

## Example Types

### Computation
- Numerical calculation
- Show arithmetic steps
- Report with appropriate precision

### Derivation
- Mathematical proof
- Show logical progression
- Reference theorems used

### Application
- Real-world context
- Set up from description
- Interpret in context

### Conceptual
- Illustrate a concept
- Show why something works
- Build intuition

## Example: Linear Regression

```markdown
## Worked Example: Simple Linear Regression

### Problem
A researcher collects data on study hours (X) and exam scores (Y):
| X | 2 | 3 | 5 | 7 | 8 |
| Y | 65 | 70 | 75 | 82 | 90 |

Find the least squares regression line.

### Solution

**Step 1: Calculate means**
$$\bar{X} = \frac{2+3+5+7+8}{5} = 5$$
$$\bar{Y} = \frac{65+70+75+82+90}{5} = 76.4$$

**Step 2: Calculate slope**
$$b_1 = \frac{\sum(X_i - \bar{X})(Y_i - \bar{Y})}{\sum(X_i - \bar{X})^2}$$

| $X_i$ | $X_i - \bar{X}$ | $Y_i$ | $Y_i - \bar{Y}$ | Product | $(X_i-\bar{X})^2$ |
|-------|-----------------|-------|-----------------|---------|-------------------|
| 2 | -3 | 65 | -11.4 | 34.2 | 9 |
| 3 | -2 | 70 | -6.4 | 12.8 | 4 |
| 5 | 0 | 75 | -1.4 | 0 | 0 |
| 7 | 2 | 82 | 5.6 | 11.2 | 4 |
| 8 | 3 | 90 | 13.6 | 40.8 | 9 |
| | | | **Sum:** | 99 | 26 |

$$b_1 = \frac{99}{26} = 3.81$$

**Step 3: Calculate intercept**
$$b_0 = \bar{Y} - b_1\bar{X} = 76.4 - 3.81(5) = 57.35$$

### Answer
$$\boxed{\hat{Y} = 57.35 + 3.81X}$$

### Interpretation
For each additional hour of study, exam scores increase by approximately 3.81 points.
```

## Examples by Field

### Statistics
- Hypothesis testing
- Confidence intervals
- ANOVA calculations
- Effect size computation

### Calculus
- Derivatives
- Integrals
- Optimization

### Linear Algebra
- Matrix operations
- Eigenvalue problems
- Systems of equations

## Request Examples

**Request**: "Create a worked example of calculating Cohen's d"

**Request**: "Show step-by-step how to test mediation with Sobel test"

**Request**: "Generate an example of bootstrapping for confidence intervals"

**Request**: "Create a problem showing ANOVA decomposition"

## Tips

- Use realistic numbers that work out cleanly
- Show enough steps for the audience level
- Highlight common mistakes to avoid
- Connect to broader concepts
- Include interpretation, not just mechanics
