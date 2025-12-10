# Write Commands

Commands for writing and editing: drafts, abstracts, cover letters, responses, and proofreading.

## Commands Overview

| Command | Purpose |
|---------|---------|
| `/write/abstract` | Paper abstracts |
| `/write/cover-letter` | Journal cover letters |
| `/write/draft` | Generic drafting |
| `/write/response` | Professional responses |
| `/write/edit` | Editing and proofreading |

---

## /write/abstract

Generate paper abstracts.

**Use for:**
- Journal submissions
- Conference proposals
- Grant summaries
- Executive summaries

**Example:**
```
/write/abstract "Write an abstract for my mediation analysis paper: [brief description]"
```

**Standard structure:**
- Background/Context
- Objective/Purpose
- Methods
- Results
- Conclusions

**MCP Integration:** `methods-paper-writer` skill

### Complete Example: Methods Paper Abstract

**Request:**
```
/write/abstract "Write an abstract for my paper on Monte Carlo
confidence intervals for mediation analysis. Key findings:
MC method outperforms bootstrap for small samples, provides
accurate coverage at n=50, and is 10x faster computationally."
```

**Generated Abstract:**

```markdown
## Abstract

**Background:** Confidence interval construction for indirect effects
in mediation analysis remains challenging due to the non-normal
sampling distribution of the product of coefficients. While bootstrap
methods are widely recommended, they can be computationally intensive
and may exhibit poor coverage in small samples.

**Objective:** This study evaluates Monte Carlo confidence intervals
as an alternative to bootstrap methods for testing indirect effects,
comparing performance across varying sample sizes and effect magnitudes.

**Methods:** We conducted a comprehensive simulation study manipulating
sample size (n = 50, 100, 200, 500), effect size (small, medium, large),
and population model specifications. Performance was assessed using
empirical coverage rates, Type I error rates, statistical power, and
computational efficiency across 10,000 replications per condition.

**Results:** Monte Carlo confidence intervals achieved nominal 95%
coverage rates at sample sizes as small as n = 50, whereas percentile
bootstrap intervals required n ≥ 100 for adequate coverage. The Monte
Carlo method maintained appropriate Type I error rates (α = .048-.052)
across all conditions. Computational time was reduced by a factor of
10 compared to bootstrap with 5,000 resamples (0.3s vs. 3.2s per model).

**Conclusions:** Monte Carlo confidence intervals offer a computationally
efficient alternative to bootstrap methods for mediation analysis,
with comparable or superior statistical properties in small to moderate
samples. We recommend this approach for applied researchers, particularly
when analyzing large datasets or conducting simulation studies.

**Keywords:** mediation analysis, indirect effects, confidence intervals,
Monte Carlo, bootstrap, simulation study

**Word count:** 247
```

---

## /write/cover-letter

Create journal submission cover letters.

**Use for:**
- Journal submissions
- Resubmissions
- Transfers
- Special issue submissions

**Example:**
```
/write/cover-letter "Write a cover letter for JASA submission on product of coefficients"
```

**Components:**
- Editor address
- Manuscript summary
- Significance statement
- Fit for journal
- Conflict of interest
- Author contributions

**MCP Integration:** `publication-strategist` skill

### Complete Example: JASA Submission

**Request:**
```
/write/cover-letter "Cover letter for JASA submission. Paper title:
'Confidence Intervals for the Product of Three Normal Random Variables
with Applications to Sequential Mediation'. Novel contribution is
exact distribution derivation and practical R implementation."
```

**Generated Cover Letter:**

```markdown
Dear Editor-in-Chief,

We are pleased to submit our manuscript entitled "Confidence Intervals
for the Product of Three Normal Random Variables with Applications to
Sequential Mediation" for consideration in the *Journal of the American
Statistical Association*.

**Summary:** This paper derives the exact probability density function
of the product of three normal random variables, a problem with direct
applications to sequential mediation analysis in psychology, public
health, and organizational research. We develop computationally efficient
algorithms for confidence interval construction and provide a freely
available R package implementing these methods.

**Significance:** While the distribution of the product of two normal
variables (relevant to simple mediation) has been studied extensively,
no exact solution exists for three or more variables. Our work fills
this gap, enabling researchers to conduct valid inference for sequential
mediation models without relying on bootstrap resampling or asymptotic
approximations that may not hold in finite samples.

**Fit for JASA:** This manuscript aligns with JASA's mission to publish
work at the intersection of statistical theory and application. The
theoretical contribution (exact distribution derivation) is complemented
by practical tools (R package) and real-data illustrations from health
disparities research, making it suitable for JASA's broad readership.

**Author Contributions:** [Author 1] developed the theoretical
framework and proofs. [Author 2] implemented the computational
algorithms. [Author 3] conducted the simulation studies and applied
analyses. All authors contributed to manuscript preparation.

**Conflicts of Interest:** The authors declare no conflicts of interest.

**Data Availability:** All code, data, and reproducibility materials
are available at [GitHub repository URL].

We confirm that this manuscript has not been published elsewhere and
is not under consideration by another journal.

Thank you for considering our submission.

Sincerely,

[Corresponding Author]
[Institution]
[Email]
```

---

## /write/draft

General-purpose drafting assistance.

**Use for:**
- Initial drafts
- Outlines
- Brainstorming
- Content expansion

**Example:**
```
/write/draft "Draft an introduction section about mediation in health research"
```

**Adaptable to:**
- Academic writing
- Technical documentation
- Reports
- Proposals

---

## /write/response

Craft professional responses.

**Use for:**
- Email replies
- Colleague requests
- Meeting follow-ups
- Support inquiries

**Example:**
```
/write/response "Draft a polite decline for a meeting invitation"
```

**Templates available:**
- Acknowledging requests
- Declining politely
- Following up
- Providing information

**Note:** For peer review responses, use `/research/revision` instead.

---

## /write/edit

Editing and proofreading assistance.

**Use for:**
- Grammar and spelling
- Clarity improvements
- Conciseness
- Style consistency

**Example:**
```
/write/edit "Proofread this methods section for grammar and clarity"
```

**Edit levels:**

| Level | Focus |
|-------|-------|
| Proofreading | Spelling, grammar, typos |
| Copyediting | + Sentence structure, word choice |
| Substantive | + Organization, argument flow |

**Common improvements:**
```
Before: "It is important to note that..."
After: "Notably,..." or just state the point

Before: "In order to"
After: "To"

Before: "Due to the fact that"
After: "Because"
```

### Complete Example: Methods Section Edit

**Request:**
```
/write/edit "Edit this methods paragraph for clarity and conciseness:

'In order to test our hypotheses, we utilized a bootstrapping
procedure that was implemented using the lavaan package in the R
statistical software program. The number of bootstrap samples that
we used was 5000, which is the number that is generally recommended
in the literature. Confidence intervals were calculated at the 95%
level of confidence.'"
```

**Generated Edit:**

```markdown
## Editing: Methods Paragraph

### Original (56 words)

> In order to test our hypotheses, we utilized a bootstrapping
> procedure that was implemented using the lavaan package in the R
> statistical software program. The number of bootstrap samples that
> we used was 5000, which is the number that is generally recommended
> in the literature. Confidence intervals were calculated at the 95%
> level of confidence.

### Edited Version (25 words)

> We tested hypotheses using bootstrap confidence intervals (5,000
> resamples) via the lavaan package in R (Rosseel, 2012), with α = .05.

### Changes Made

| Issue | Original | Revised |
|-------|----------|---------|
| Wordiness | "In order to" | "to" (implied) |
| Redundancy | "bootstrapping procedure" | "bootstrap" |
| Wordiness | "that was implemented using" | "via" |
| Redundancy | "R statistical software program" | "R" |
| Passive voice | "was 5000" | Direct statement |
| Wordiness | "number that is generally recommended" | (implied by citation) |
| Redundancy | "95% level of confidence" | "α = .05" |

### Alternative Versions

**Version A (Detailed):**
> Indirect effects were tested using percentile bootstrap confidence
> intervals with 5,000 resamples, implemented in lavaan 0.6-17
> (Rosseel, 2012). We used α = .05 for all tests.

**Version B (Minimal):**
> Bootstrap 95% CIs (5,000 resamples) were computed in lavaan.

### Recommendation

Use **Version A** for methods sections requiring full detail, or the
edited version for standard reporting. Add the lavaan citation if not
already in the manuscript.
```

---

## Writing Tips

### For Academic Writing
- Use active voice when possible
- Be specific about methods and results
- Avoid hedging language ("might," "could")
- Follow journal guidelines

### For Professional Communication
- State purpose early
- Be concise
- Include clear next steps
- Match formality to relationship

### For All Writing
- Read aloud to catch issues
- Cut unnecessary words
- One idea per paragraph
- Use transitions

---

## Workflows

### Paper Submission
```
1. /write/abstract "summarize paper"
2. /write/cover-letter "prepare submission"
3. /write/edit "final proofread"
```

### Grant Writing
```
1. /write/draft "outline specific aims"
2. /write/abstract "executive summary"
3. /write/edit "polish final version"
```

### Professional Communication
```
1. /write/draft "initial content"
2. /write/edit "improve clarity"
3. /write/response "if replying to someone"
```

---

## Related Commands

| Task | Use This Command |
|------|------------------|
| Peer review responses | `/research/revision` |
| Technical documentation | `/code/demo` |
| Course materials | `/teach/lecture` |
| Mathematical content | `/math/derive` |
