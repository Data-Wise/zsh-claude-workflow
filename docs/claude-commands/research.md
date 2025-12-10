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

Design Monte Carlo simulation studies.

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
