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
