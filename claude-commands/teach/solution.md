# Create Solution Key

Generate detailed solution keys for exams, homework, or problem sets.

## Required Input

- **Assignment**: The original problems (paste or file path)
- **Detail Level**: Brief answers, worked solutions, or instructor notes
- **Format**: Student handout, grader guide, or both
- **Include**: Point breakdown, common errors, partial credit guidance

## Process

1. **Solve Each Problem**: Work through systematically
2. **Show Key Steps**: Highlight critical reasoning
3. **Note Alternatives**: Valid alternative approaches
4. **Anticipate Errors**: Common mistakes and how to grade them
5. **Format Clearly**: Match assignment structure

## Output Format

### Student Solution Key

```markdown
# Solution Key: [Assignment Name]

---

## Problem 1 (X points)

**Answer**: [Final answer]

**Solution**:
[Step-by-step work]

Step 1: [First step with explanation]
$$[Math if applicable]$$

Step 2: [Second step]
$$[Math]$$

Therefore, [conclusion].

---

## Problem 2 (X points)

### Part a) (X points)
**Answer**: [Answer]

**Solution**: [Work]

### Part b) (X points)
**Answer**: [Answer]

**Solution**: [Work]

---
```

### Grader Guide (Additional)

```markdown
# Grading Guide: [Assignment Name]

## Problem 1 (X points)

**Correct Answer**: [Answer]

**Point Breakdown**:
- Setup/formula: X pts
- Calculation: X pts
- Final answer: X pts
- Interpretation: X pts

**Common Errors**:
| Error | Deduction | Notes |
|-------|-----------|-------|
| Wrong formula | -X pts | If used [wrong thing], give partial |
| Arithmetic error | -X pts | Give credit if method correct |
| Missing units | -1 pt | |
| No interpretation | -X pts | Must mention [key point] |

**Alternative Approaches**:
- Method B: [Description] - Full credit if executed correctly
- Method C: [Description] - Acceptable with justification

**Notes for Graders**:
- [Special instruction 1]
- [Special instruction 2]
```

## Solution Detail Levels

### Brief (Answer Key Only)
```markdown
1. B
2. True
3. x̄ = 42.5, s = 3.2
4. Reject H₀ (p = 0.023)
```

### Standard (Worked Solutions)
```markdown
1. **Answer: B**

   The variance of the sample mean is σ²/n = 16/25 = 0.64.
   Standard error = √0.64 = 0.8.
```

### Detailed (Instructor Notes)
```markdown
1. **Answer: B**

   **Solution**: The variance of the sample mean is σ²/n.
   - Given: σ² = 16, n = 25
   - Var(x̄) = 16/25 = 0.64
   - SE = √0.64 = 0.8

   **Teaching Note**: Students often confuse σ and σ².
   Emphasize the distinction in review.

   **Common Error**: Using σ/n instead of σ/√n (-3 pts)

   **Partial Credit**:
   - Correct formula, wrong calculation: 4/5 pts
   - Wrong formula, correct execution: 2/5 pts
```

## By Assignment Type

### Multiple Choice
- State correct answer
- Explain why correct
- Explain why distractors are wrong

### Short Answer
- Model answer
- Key points required for full credit
- Acceptable variations

### Computation
- Full worked solution
- Alternative methods
- Point allocation by step

### Essay
- Rubric criteria
- Model answer or key points
- Examples of excellent/good/poor responses

### Proof
- Complete proof
- Alternative proof methods
- Grading for partial proofs

## Example Prompts

"Create a solution key for this midterm exam. Include worked solutions and a grading guide with common errors. [paste exam]"

"Generate brief answer key for this homework assignment. Just answers, no work shown. [paste problems]"

"Create detailed instructor solutions for this problem set on regression. Include teaching notes about where students typically struggle. [paste problems]"

## Integration

- Use `/derive` for detailed mathematical derivations
- Use `/rubric` if full rubric needed separately
- Use `/homework` to create original problems
- Works with examark format questions

## Tips

1. **Solve Fresh**: Don't assume you remember - work through completely
2. **Multiple Methods**: Acknowledge valid alternatives
3. **Be Specific**: "Approximately 3.5" is not helpful for grading
4. **Anticipate Questions**: What will confused students ask?
5. **Calibrate Points**: Ensure point values reflect difficulty and importance
6. **Proofread**: Errors in solutions cause major confusion
