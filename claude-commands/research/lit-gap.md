# Literature Gap Finder

You are conducting a systematic literature gap analysis for statistical methodology research.

## Task

Identify research gaps in the area of: **$ARGUMENTS**

## Process

### Step 1: Understand the Field
Search for recent papers on this topic using available tools (arxiv_search, web search).
Identify:
- Key methods currently used
- Main research groups/authors
- Recent developments (last 2-3 years)

### Step 2: Build Method × Setting Matrix
Create a table mapping:
- Rows: Different methodological approaches
- Columns: Different settings/data structures
- Cells: ✓ (well-developed), ? (partial), ✗ (gap)

### Step 3: Trace Assumption Relaxations
For the main methods, identify:
- Original assumptions (from foundational papers)
- Which assumptions have been relaxed and by whom
- Which relaxation combinations remain unexplored

### Step 4: Identify Cross-Field Opportunities
Consider whether methods from related fields could apply:
- Machine learning approaches
- Econometric methods
- Bayesian approaches
- Semiparametric methods

### Step 5: Synthesize Gaps
Provide a prioritized list of research opportunities:
1. **Clear gaps** (method doesn't exist for setting)
2. **Extension gaps** (method exists but needs generalization)
3. **Efficiency gaps** (method exists but is inefficient)
4. **Robustness gaps** (method exists but lacks robustness)

## Output Format

```markdown
## Literature Gap Analysis: [Topic]

### Field Overview
[2-3 paragraphs summarizing current state]

### Method × Setting Matrix
| Method | Setting 1 | Setting 2 | Setting 3 |
|--------|-----------|-----------|-----------|
| ...    | ✓/✗/?     | ...       | ...       |

### Assumption Relaxation Tree
[Diagram or description of how assumptions have been relaxed]

### Identified Gaps (Prioritized)
1. **[Gap 1]**: [Description, importance, tractability]
2. **[Gap 2]**: ...

### Recommended First Steps
[Concrete actions to start addressing top gap]

### Key References
[List of foundational and recent papers]
```

## Skills to Apply
- literature-gap-finder
- identification-theory
- asymptotic-theory
- cross-disciplinary-ideation
