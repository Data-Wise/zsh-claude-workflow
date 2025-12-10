# Create Analysis Plan

Develop a comprehensive statistical analysis plan (SAP) or pre-registration document.

## Purpose

Create detailed analysis plans for:
- Pre-registration (OSF, AsPredicted, etc.)
- Grant proposals
- IRB submissions
- Internal documentation
- Registered reports

## Required Input

- **Research questions/hypotheses**
- **Study design**: Experimental, observational, longitudinal
- **Variables**: Predictors, outcomes, covariates
- **Sample**: Size, characteristics, recruitment
- **Data collection**: Measures, timing

## Process

1. Document study design and hypotheses
2. Specify all variables and measures
3. Define primary and secondary analyses
4. Detail data preprocessing steps
5. Specify statistical models and tests
6. Address missing data and assumptions
7. Define sensitivity analyses
8. Set decision rules (alpha, effect sizes)

## Output Format

```markdown
# Statistical Analysis Plan

## Study Information
- **Title**: [Study title]
- **Authors**: [Names]
- **Date**: [Date]
- **Version**: [Version number]

## Research Questions and Hypotheses

### Primary Hypothesis
[H1 statement]

### Secondary Hypotheses
[H2, H3, etc.]

## Study Design
- **Design type**: [RCT, observational, etc.]
- **Groups/Conditions**: [Description]
- **Timing**: [Cross-sectional, longitudinal]

## Participants
- **Target N**: [Sample size with justification]
- **Inclusion criteria**: [List]
- **Exclusion criteria**: [List]
- **Power analysis**: [Details]

## Variables

### Primary Outcome
- **Name**: [Variable]
- **Measure**: [Instrument/operationalization]
- **Type**: [Continuous, categorical, etc.]

### Primary Predictor
- **Name**: [Variable]
- **Measure**: [Instrument/operationalization]
- **Type**: [Type]

### Covariates
| Variable | Measure | Rationale |
|----------|---------|-----------|
| | | |

## Data Preprocessing
1. [Step 1: e.g., outlier handling]
2. [Step 2: e.g., transformation]
3. [Step 3: e.g., missing data]

## Primary Analysis
- **Model**: [e.g., Linear regression]
- **Specification**: [Y ~ X + covariates]
- **Software**: [R package, version]
- **Assumptions checked**: [List]

## Secondary Analyses
[Additional analyses]

## Sensitivity Analyses
1. [Alternative specification 1]
2. [Alternative specification 2]

## Missing Data
- **Expected missingness**: [%]
- **Handling method**: [Listwise, MI, FIML]
- **Assumptions**: [MAR, MCAR, MNAR]

## Inference Criteria
- **Alpha level**: [e.g., 0.05]
- **Correction for multiple tests**: [Method]
- **Effect size reporting**: [Which measures]

## Deviations
[How deviations will be documented]
```

## Pre-Registration Platforms

- **OSF**: Open Science Framework (osf.io)
- **AsPredicted**: aspredicted.org
- **ClinicalTrials.gov**: For clinical trials
- **PROSPERO**: For systematic reviews

## Templates by Study Type

### Experimental
- Randomization procedure
- Blinding details
- Manipulation checks

### Observational
- Confounder adjustment strategy
- Causal assumptions (DAG)
- Selection bias considerations

### Longitudinal
- Attrition handling
- Time-varying analysis
- Growth modeling approach

## Examples

**Request**: "Create an analysis plan for a mediation study with 3 time points"

**Request**: "Draft a pre-registration for an RCT comparing two interventions"

**Request**: "Help me specify the analysis plan section for my R01 grant"

**Request**: "Generate an SAP template for observational health disparities research"

## Tips

- Be specific enough that someone else could run your analyses
- Include decision rules for unexpected situations
- Version control your SAP
- Time-stamp before data collection
- Distinguish confirmatory from exploratory analyses
