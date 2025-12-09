# Create Exam

Create a comprehensive exam using examark format for Canvas LMS import.

## Required Input

Provide the following information:
- **Course/Topic**: What subject area is this exam for?
- **Question Types**: MC (multiple choice), TF (true/false), Short, Essay, Matching, Numerical, FMB (fill multiple blanks)
- **Number of Questions**: Total count and distribution by type
- **Difficulty Level**: Easy, Medium, Hard, or Mixed
- **Time Limit**: Expected completion time (optional)
- **Learning Objectives**: Specific concepts to assess (optional)

## Process

1. **Gather Context**: Review course materials, learning objectives, or prior exams if provided
2. **Generate Questions**: Create questions in examark markdown format
3. **Mark Correct Answers**: Use `[x]` or `**bold**` for correct options
4. **Add Point Values**: Use `[N pts]` notation
5. **Validate**: Run `examark check` to verify format
6. **Export**: Optionally create QTI package for Canvas

## Output Format

```markdown
# Exam Title

## Section: Topic Name

1. [MC] Question stem here? [2 pts]
a) Wrong answer
b) **Correct answer**
c) Wrong answer
d) Wrong answer

2. [TF] Statement to evaluate. [1 pt]
a) True [x]
b) False

3. [Short] Open-ended question here. [3 pts]

4. [Essay, 10 pts] Extended response question.
```

## Integration

After generating the exam markdown:

```bash
# Validate the exam
examark check exam.md

# Preview parsed questions
examark exam.md --preview

# Export to QTI for Canvas
examark exam.md -o exam.qti.zip

# Export to plain text for printing
examark exam.md -f text
```

## Question Type Reference

| Type | Syntax | Description |
|------|--------|-------------|
| Multiple Choice | `[MC]` | Single correct answer |
| True/False | `[TF]` | Binary choice |
| Multiple Answer | `[MA]` | Multiple correct answers |
| Short Answer | `[Short]` | Brief text response |
| Essay | `[Essay]` | Extended response |
| Numerical | `[Num]` | Numeric answer with tolerance |
| Matching | `[Match]` | Pair items together |
| Fill Multiple Blanks | `[FMB]` | Multiple blanks in one question |

## Example Prompt

"Create a 15-question midterm exam on linear regression for STAT 440.
Include: 6 MC, 4 TF, 3 short answer, 2 essay questions.
Difficulty: Medium to Hard. Cover: OLS estimation, assumptions, diagnostics, inference.
Total points: 100."

## Notes

- All questions should align with stated learning objectives
- Include a mix of conceptual and computational questions
- For statistical courses, include interpretation questions
- Essay questions should have clear expectations stated
- Consider including partial credit guidance for graders
