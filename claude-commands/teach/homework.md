# Create Homework Assignment

Generate problem sets with varied difficulty and clear instructions.

## Required Input

- **Topic(s)**: What concepts should the homework cover?
- **Course Level**: Undergraduate, graduate, professional
- **Number of Problems**: Total count and distribution
- **Difficulty Mix**: Easy/Medium/Hard ratio
- **Total Points**: Point value for the assignment
- **Format**: Computation, conceptual, applied, or mixed

## Process

1. **Align with Objectives**: Ensure problems match learning goals
2. **Scaffold Difficulty**: Progress from easier to harder
3. **Vary Problem Types**: Mix conceptual and computational
4. **Include Context**: Use realistic scenarios when possible
5. **Provide Guidance**: Hints without giving away answers

## Output Format

```markdown
# Homework [#]: [Topic]

**Course**: [Course name/number]
**Due**: [Date/time]
**Total Points**: [X points]

## Instructions
- Show all work for full credit
- Clearly state assumptions
- Round final answers to [X] decimal places
- [Software] may be used for problems marked with (*)

---

## Problem 1: [Topic] (X points) [Easy]

[Problem statement with clear setup]

a) [Part a - X points]

b) [Part b - X points]

---

## Problem 2: [Topic] (X points) [Medium]

[Problem with more complexity]

**Hint**: Consider using [approach/formula].

---

## Problem 3: [Topic] (X points) [Hard/Challenge]

[Complex problem requiring synthesis]

---

## Problem 4: Applied Analysis (*) (X points)

Using the dataset `[filename]`:

a) [Data analysis task]

b) [Interpretation question]

c) [Critical thinking question]

---

## Submission Guidelines
- Submit as PDF via [Canvas/system]
- Include code as appendix if applicable
- Late policy: [policy]

## Resources
- Textbook: Chapter [X]
- Lecture notes: [Topic]
- Office hours: [Times]
```

## Problem Type Templates

### Computational
```markdown
Calculate the [statistic] for the following data:
[Data or reference to data]
Show your work including:
- Formula used
- Substitution of values
- Final answer with units
```

### Conceptual
```markdown
Explain why [phenomenon occurs / assumption is needed / method is preferred].
Your answer should:
- Be 2-3 paragraphs
- Reference relevant concepts from lecture
- Include an example if helpful
```

### Proof/Derivation
```markdown
Prove that [statement].
Hint: Start with [starting point] and use [technique].
```

### Applied/Data Analysis
```markdown
The dataset [name] contains [description].
a) [Exploratory task]
b) [Analysis task]
c) [Interpretation task]
d) [Critical evaluation task]
```

### True/False with Justification
```markdown
For each statement, indicate whether it is TRUE or FALSE and provide a brief justification (1-2 sentences).

a) [Statement 1]
b) [Statement 2]
```

## Difficulty Calibration

| Level | Characteristics |
|-------|-----------------|
| Easy | Direct application of formulas, single concept |
| Medium | Multiple concepts, some problem-solving |
| Hard | Synthesis, non-obvious approach, interpretation |
| Challenge | Extension beyond lecture, research-level |

## Example Prompts

"Create a 50-point homework on hypothesis testing for undergrad stats. 6 problems: 2 easy, 3 medium, 1 hard. Include one applied problem using a provided dataset."

"Design a graduate-level problem set on causal mediation analysis. 4 problems covering identification, estimation, sensitivity analysis, and a real data application. 100 points total."

"Create a homework assignment on ANOVA for a psychology stats course. Include problems on one-way ANOVA, post-hoc tests, and interpretation of results. Mix of hand calculation and SPSS output interpretation."

## Integration

- Use `/solution` to create answer key
- Use `/rubric` to create grading rubric
- Use `/derive` for proof problems
- Can export to examark format for auto-grading portions

## Tips

1. **Test Yourself**: Solve problems before assigning
2. **Time Estimate**: Rule of thumb: 3x your time = student time
3. **Clear Instructions**: Specify format, precision, software allowed
4. **Partial Credit**: Design problems with gradable components
5. **Feedback Opportunity**: Include self-check questions
6. **Avoid Ambiguity**: Have a colleague review for clarity
