# Simulation Study Design

You are designing a Monte Carlo simulation study for a statistical method.

## Task

Design a simulation study to evaluate: **$ARGUMENTS**

## Design Framework (Morris et al., 2019)

### Step 1: Define the Aim
What question does this simulation answer?
- Comparing methods? (relative performance)
- Validating theory? (asymptotic properties)
- Exploring robustness? (assumption violations)
- Practical guidance? (when to use what)

### Step 2: Data-Generating Mechanisms (DGPs)

#### Core DGP
```r
# Template for mediation DGP
generate_data <- function(n, params) {
  # Confounders
  X <- rnorm(n)

  # Treatment (possibly confounded)
  A <- rbinom(n, 1, plogis(params$gamma0 + params$gamma1 * X))

  # Mediator
  M <- params$alpha0 + params$alpha1 * A + params$alpha2 * X + rnorm(n, sd = params$sigma_m)

  # Outcome
  Y <- params$beta0 + params$beta1 * A + params$beta2 * M +
       params$beta3 * X + params$beta4 * A * M + rnorm(n, sd = params$sigma_y)

  data.frame(Y = Y, A = A, M = M, X = X)
}
```

#### DGP Variations
Consider variations for:
- [ ] Linear vs nonlinear relationships
- [ ] Correct vs misspecified models
- [ ] Homoscedastic vs heteroscedastic errors
- [ ] No interaction vs interaction
- [ ] Measured vs unmeasured confounding

### Step 3: Parameter Grid

| Factor | Values | Rationale |
|--------|--------|-----------|
| Sample size (n) | 200, 500, 1000, 2000 | Small to large |
| Effect size | 0, 0.1, 0.3, 0.5 | Null to large |
| Confounding strength | 0, 0.3, 0.6 | None to strong |
| [Other factors] | ... | ... |

**Total scenarios**: [Calculate based on factorial design]

### Step 4: Methods to Compare

1. **Proposed method**: [Your method]
2. **Competitor 1**: [Standard approach]
3. **Competitor 2**: [Alternative]
4. **Oracle** (if applicable): [Best possible]

### Step 5: Performance Metrics

| Metric | Formula | Target |
|--------|---------|--------|
| Bias | $\bar{\hat{\psi}} - \psi_0$ | ≈ 0 |
| Empirical SE | $\text{SD}(\hat{\psi})$ | Close to ASE |
| Average SE | $\bar{\widehat{SE}}$ | Close to ESE |
| Coverage | % of CIs containing $\psi_0$ | ≈ 95% |
| MSE | Bias² + Var | Minimize |
| Power | % rejecting H₀ when false | High |

### Step 6: Replications and Computation

- **Replications**: 1000 (minimum), 2000+ (for coverage)
- **Monte Carlo SE**: Report MCSE for key metrics
- **Computation**: Parallel processing, checkpointing
- **Seed**: Set for reproducibility

## Output Format

```markdown
## Simulation Study Design: [Title]

### Aim
[Clear statement of what simulation will show]

### Data-Generating Process
[R code for DGP with all parameters]

### Parameter Grid
| Factor | Values | # Levels |
|--------|--------|----------|
| ...    | ...    | ...      |

**Total scenarios**: X
**Replications per scenario**: Y
**Total simulations**: X × Y = Z

### Methods
1. [Method 1]: [Brief description]
2. [Method 2]: ...

### Performance Metrics
[Table of metrics with definitions]

### Expected Results
[What patterns do you expect to see?]

### Computational Requirements
- Estimated time: [X hours on Y cores]
- Storage: [X GB for results]
- Checkpointing: [Strategy]

### R Code Skeleton
[Complete simulation function skeleton]
```

## Skills to Apply
- simulation-architect
- statistical-simulation-guide
- r-simulation-config
