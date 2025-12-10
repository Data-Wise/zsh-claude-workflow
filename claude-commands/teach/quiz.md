# Create Quiz

Create a quick quiz or formative assessment using examark format.

## Purpose

Generate short, focused quizzes for:
- Quick knowledge checks during lectures
- Pre-class preparation assessment
- Post-lesson comprehension checks
- Low-stakes practice problems

## Required Input

- **Topic**: Subject area or specific concept
- **Question count**: Number of questions (typically 5-10)
- **Question types**: MC (multiple choice), TF (true/false), or mixed
- **Difficulty**: Basic, intermediate, or advanced

## Process

1. Identify key concepts to assess
2. Generate questions in examark markdown format
3. Include clear answer keys with `[x]` markers
4. Balance question difficulty appropriately
5. Validate format if examark CLI is available

## Output Format

```markdown
---
title: "Quiz: [Topic]"
course: "[Course Name]"
date: "[Date]"
time_limit: "[X] minutes"
points: [total]
---

## Question 1 (2 points)
[Question text]

- [ ] Option A
- [x] Option B (correct)
- [ ] Option C
- [ ] Option D

## Question 2 (1 point)
[True/False question]

- [x] True
- [ ] False
```

## Integration

- Uses examark format for Canvas LMS compatibility
- Can be validated with `examark check`
- Exportable to QTI format for Canvas import

## Tips

- Keep quizzes focused on 1-2 learning objectives
- Use clear, unambiguous language
- Avoid trick questions for formative assessments
- Include brief feedback explanations when helpful

## Examples

**Request**: "Create a 5-question quiz on hypothesis testing basics for introductory stats"

**Request**: "Quick 3-question T/F quiz on R data types"

**Request**: "Generate a 10-question mixed quiz on linear regression assumptions"
