# Proof Verification

You are conducting a systematic verification of a mathematical proof in statistical methodology.

## Task

Verify the proof provided in: **$ARGUMENTS**

If no file specified, verify the proof in the current context.

## Verification Levels

### Level 1: Structure Check
- [ ] Is the claim clearly stated?
- [ ] Are all assumptions explicitly enumerated?
- [ ] Is all notation defined before use?
- [ ] Is the logical flow apparent (numbered steps)?
- [ ] Does each step have explicit justification?
- [ ] Is the conclusion explicitly stated?

### Level 2: Step-by-Step Validation
For EACH step in the proof:
1. What mathematical operation is being performed?
2. What justifies this step? (theorem, lemma, definition, algebra)
3. Are the conditions for cited results actually satisfied?
4. Are there any implicit assumptions?

### Level 3: Edge Case Analysis
- [ ] What happens at boundary cases? (n=1, p→∞, effect=0)
- [ ] Are degenerate cases handled?
- [ ] What if assumptions barely hold (at the boundary)?
- [ ] Are there numerical stability concerns?

### Level 4: Consistency Check
- [ ] Does the result match intuition?
- [ ] Do special cases recover known results?
- [ ] Is the result consistent with simulations (if available)?
- [ ] Does the rate/efficiency claim make sense?

## Common Errors to Check

### Technical Errors
- Interchanging limits without justification (need DCT/MCT)
- Division by quantities that could be zero
- Incorrect conditioning (confusing conditional and marginal)
- Wrong norm (L2 vs L∞)
- Missing measurability arguments

### Logical Errors
- Circular reasoning
- Unstated assumptions ("clearly" or "obviously")
- Incorrect quantifiers (∃ vs ∀)
- Missing cases in case analysis

### Statistical Errors
- Confusing convergence modes (→ᵖ vs →ᵈ)
- Ignoring dependence when applying CLT
- Wrong variance (population vs sample)
- Incorrect influence function derivation

## Output Format

```markdown
## Proof Verification Report

### Claim Being Verified
[Statement of the theorem/lemma]

### Verification Summary
**Status**: ✓ VALID / ⚠ NEEDS ATTENTION / ✗ ERROR FOUND

### Level 1: Structure
[Checklist results]

### Level 2: Step Validation
| Step | Operation | Justification | Status |
|------|-----------|---------------|--------|
| 1    | ...       | ...           | ✓/⚠/✗  |
| 2    | ...       | ...           | ...    |

### Level 3: Edge Cases
[Analysis of boundary/degenerate cases]

### Level 4: Consistency
[Intuition check, special cases, numerical verification]

### Issues Found
1. **[Issue 1]**: [Description and severity]
   - Location: Step X
   - Suggestion: [How to fix]

### Recommendations
[Overall assessment and suggestions for improvement]
```

## Skills to Apply
- proof-architect
- identification-theory
- asymptotic-theory
