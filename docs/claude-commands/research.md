# Research Commands

Commands for academic research workflows: literature review, manuscript writing, simulations, and publication.

## Commands Overview

| Command | Purpose |
|---------|---------|
| `/research/cite` | Citation management with Zotero/BibTeX |
| `/research/lit-gap` | Find gaps in literature |
| `/research/manuscript` | Write paper sections |
| `/research/revision` | Respond to peer reviewers |
| `/research/sim-design` | Design simulation studies |
| `/research/method-scout` | Find methods across disciplines |
| `/research/hypothesis` | Formulate testable hypotheses |
| `/research/analysis-plan` | Create pre-registration/SAP |

---

## /research/cite

Manage citations using Zotero and BibTeX integration.

**Use for:**
- Adding citations to manuscripts
- Formatting reference lists
- Finding DOIs and metadata
- Managing Zotero collections

**Example:**
```
/research/cite "Add Baron & Kenny 1986 to my mediation paper"
```

**MCP Integration:** `bibtex`, `zotero` tools

---

## /research/lit-gap

Identify gaps in the literature for a research topic.

**Use for:**
- Literature review planning
- Finding research opportunities
- Identifying understudied areas
- Grant proposal justification

**Example:**
```
/research/lit-gap "sequential mediation in organizational psychology"
```

**MCP Integration:** `arxiv_search`, `crossref_lookup`, `literature-gap-finder` skill

---

## /research/manuscript

Write sections of academic manuscripts.

**Use for:**
- Methods sections
- Results descriptions
- Discussion points
- Introduction framing

**Example:**
```
/research/manuscript "Write a methods section for a bootstrap mediation study with N=500"
```

**MCP Integration:** `methods-paper-writer` skill

---

## /research/revision

Draft responses to peer reviewer comments.

**Use for:**
- Point-by-point responses
- Revision letters
- Addressing major/minor comments
- Resubmission preparation

**Example:**
```
/research/revision "Respond to these reviewer comments: [paste comments]"
```

**MCP Integration:** `publication-strategist` skill

---

## /research/sim-design

Design Monte Carlo simulation studies following best practices (Morris et al., 2019).

**Use for:**
- Power analysis simulations
- Method comparison studies
- Sensitivity analyses
- Validation studies

**Example:**
```
/research/sim-design "Compare bootstrap vs Sobel test for mediation with N=100,200,500"
```

**MCP Integration:** `simulation-architect` skill, `r_execute` tool

### Complete Example: Mediation Method Comparison

**Request:**
```
/research/sim-design "Design a simulation comparing percentile bootstrap,
bias-corrected bootstrap, and Monte Carlo CI for simple mediation.
Vary sample size (100, 250, 500) and effect size (small: a=b=0.14,
medium: a=b=0.39). Focus on Type I error and power."
```

**Generated Design:**

```markdown
## Simulation Study: Bootstrap Methods for Mediation

### Aims
Compare three CI methods for the indirect effect (ab):
1. Percentile bootstrap (PERC)
2. Bias-corrected bootstrap (BC)
3. Monte Carlo CI (MC)

### Data-Generating Process
```r
# Simple mediation: X → M → Y
generate_data <- function(n, a, b, c_prime = 0) {
  X <- rnorm(n)
  M <- a * X + rnorm(n)
  Y <- b * M + c_prime * X + rnorm(n)
  data.frame(X = X, M = M, Y = Y)
}
```

### Design Factors

| Factor | Levels | Values |
|--------|--------|--------|
| Sample size (N) | 3 | 100, 250, 500 |
| Effect size | 2 | Small (a=b=0.14), Medium (a=b=0.39) |
| True effect | 2 | Null (a=0 OR b=0), Non-null |

**Total cells:** 3 × 2 × 2 = 12

### Performance Measures
- **Type I error rate**: Target α = 0.05, acceptable [0.025, 0.075]
- **Power**: P(reject H₀ | H₁ true)
- **CI coverage**: Target 95%, acceptable [92.5%, 97.5%]
- **CI width**: Average width across replications

### Replications & Precision
- R = 2,000 replications per cell
- Bootstrap samples: B = 5,000 per replication
- MCSE for Type I error at α=0.05: √(0.05×0.95/2000) = 0.005

### Computational Requirements
- Estimated time: ~4 hours on 8-core machine
- Parallel execution recommended
- Checkpoint every 500 replications

### R Implementation Skeleton
```r
library(lavaan)
library(boot)

run_simulation <- function(n, a, b, R = 2000, B = 5000) {
  results <- replicate(R, {
    dat <- generate_data(n, a, b)

    # Fit model
    model <- 'm ~ a*x; y ~ b*m + c*x'
    fit <- sem(model, dat)

    # Get indirect effect CIs
    perc_ci <- bootstrap_mediation(dat, B, type = "perc")
    bc_ci <- bootstrap_mediation(dat, B, type = "bca")
    mc_ci <- monte_carlo_ci(fit)

    c(perc_ci, bc_ci, mc_ci)
  }, simplify = TRUE)

  summarize_results(results, true_ab = a * b)
}
```
```

---

## /research/method-scout

Find statistical methods across disciplines.

**Use for:**
- Discovering new methods
- Cross-disciplinary solutions
- Comparing alternative approaches
- Finding seminal papers

**Example:**
```
/research/method-scout "Methods for causal mediation with binary outcomes"
```

**MCP Integration:** `cross-disciplinary-ideation`, `method-transfer` skills

---

## /research/hypothesis

Formulate clear, testable hypotheses.

**Use for:**
- Research question refinement
- H0/H1 specification
- Directional vs. non-directional
- Pre-registration preparation

**Example:**
```
/research/hypothesis "Social support affects depression through coping mechanisms"
```

---

## /research/analysis-plan

Create statistical analysis plans for pre-registration.

**Use for:**
- OSF pre-registration
- Grant proposals
- IRB submissions
- Registered reports

**Example:**
```
/research/analysis-plan "Create SAP for a 3-wave longitudinal mediation study"
```

### Complete Example: OSF Pre-Registration

**Request:**
```
/research/analysis-plan "Create an OSF pre-registration for a study examining
whether social support reduces depression through improved coping.
3 time points, 6 months apart, expected N=300."
```

**Generated Plan:**

```markdown
# Pre-Registration: Social Support, Coping, and Depression

## Study Information

**Title**: Longitudinal Mediation of Social Support on Depression Through Coping
**Authors**: [Your name]
**Date**: 2025-01-15
**OSF Project**: [Link]

## Hypotheses

**H1 (Primary)**: Social support at T1 predicts lower depression at T3,
mediated by adaptive coping at T2.
- H₀: ab = 0 (no indirect effect)
- H₁: ab < 0 (negative indirect effect)

**H2 (Secondary)**: The indirect effect is stronger for participants with
higher baseline stress.

## Design

- **Type**: Longitudinal observational, 3 waves
- **Timing**: Baseline (T1), 6 months (T2), 12 months (T3)
- **Setting**: Online survey panel

## Sample

- **Target N**: 300 (accounting for 20% attrition = 360 at T1)
- **Power**: 80% power to detect medium indirect effect (ab = -0.10)
  based on Monte Carlo simulation with 10,000 replications
- **Inclusion**: Adults 18+, English-speaking, no current treatment

## Measures

| Variable | Measure | Timepoints | Reliability |
|----------|---------|------------|-------------|
| Social Support (X) | MSPSS | T1 | α > .85 |
| Coping (M) | Brief COPE | T2 | α > .80 |
| Depression (Y) | PHQ-9 | T1, T3 | α > .85 |
| Stress (W) | PSS-10 | T1 | α > .80 |

## Analysis Plan

### Primary Analysis

**Model**: Longitudinal mediation with covariates

```
M_T2 ~ a*X_T1 + c1*Y_T1 + covariates
Y_T3 ~ b*M_T2 + c_prime*X_T1 + c2*Y_T1 + covariates
```

**Indirect effect**: ab with 95% Monte Carlo CI (20,000 draws)
**Software**: R 4.3+, lavaan 0.6-17

### Missing Data

- **Expected**: 15-20% by T3
- **Assumption**: MAR (Missing at Random)
- **Method**: FIML (Full Information Maximum Likelihood)
- **Sensitivity**: Pattern-mixture models if >25% missing

### Decision Rules

| Outcome | Criterion | Interpretation |
|---------|-----------|----------------|
| Support H1 | 95% CI excludes 0, ab < 0 | Mediation supported |
| Reject H1 | 95% CI includes 0 | No evidence of mediation |
| Inconclusive | ab < 0 but CI wide | Underpowered |

### Sensitivity Analyses

1. **Alternative mediator timing**: Test M at T1 and T3
2. **Reverse causation**: Test Y_T1 → M_T2 → X_T3
3. **Unmeasured confounding**: Sensitivity analysis (Rho = 0.1, 0.2, 0.3)

## Deviations

Any deviations from this plan will be:
1. Documented in supplementary materials
2. Clearly labeled as exploratory
3. Justified with rationale
```

---

## Workflows

### Literature Review Workflow
```
1. /research/lit-gap "your topic"
2. /research/cite "add key references"
3. /research/manuscript "write introduction"
```

### Publication Workflow
```
1. /research/hypothesis "define hypotheses"
2. /research/analysis-plan "create pre-registration"
3. /research/sim-design "run power analysis"
4. /research/manuscript "write methods"
5. /research/revision "respond to reviewers"
```
