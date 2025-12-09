# Generate Grading Rubric

Create a detailed grading rubric for assignments, exams, or projects.

## Required Input

- **Assignment Description**: What is being assessed?
- **Total Points**: Overall point value
- **Number of Criteria**: How many dimensions to evaluate (3-6 recommended)
- **Grading Scale**: 4-point, 5-point, percentage, or custom levels

## Process

1. **Identify Criteria**: Determine key dimensions to assess
2. **Define Levels**: Create performance level descriptors
3. **Assign Points**: Distribute points across criteria
4. **Write Descriptors**: Clear, specific language for each cell
5. **Format Output**: Table format for easy use

## Output Format

### Standard 4-Point Rubric

| Criterion | Excellent (4) | Good (3) | Satisfactory (2) | Needs Work (1) | Points |
|-----------|--------------|----------|------------------|----------------|--------|
| Criterion 1 | Description | Description | Description | Description | /X |
| Criterion 2 | Description | Description | Description | Description | /X |
| ... | ... | ... | ... | ... | ... |
| **Total** | | | | | **/Total** |

### Percentage-Based Rubric

| Criterion | Excellent (90-100%) | Good (80-89%) | Satisfactory (70-79%) | Needs Work (<70%) | Weight |
|-----------|---------------------|---------------|----------------------|-------------------|--------|
| ... | ... | ... | ... | ... | X% |

## Common Criteria by Assignment Type

### Research Paper
- Thesis/Argument clarity
- Evidence and support
- Analysis depth
- Organization/Structure
- Writing mechanics
- Citations/References

### Statistical Analysis
- Problem setup
- Method selection
- Computation accuracy
- Interpretation
- Assumptions checking
- Presentation/Visualization

### Programming Assignment
- Correctness/Functionality
- Code quality/Style
- Documentation
- Efficiency
- Testing
- Error handling

### Presentation
- Content knowledge
- Organization
- Delivery/Speaking
- Visual aids
- Engagement
- Time management

## Example Prompt

"Create a rubric for a 100-point research paper assignment.
5 criteria: thesis, evidence, analysis, organization, writing.
4-point scale (Excellent/Good/Satisfactory/Needs Improvement).
This is for a graduate-level causal inference course."

## Canvas-Compatible Format

For Canvas SpeedGrader, output can be formatted as:

```
Criterion: [Name]
- Excellent (X pts): [Description]
- Good (X pts): [Description]
- Satisfactory (X pts): [Description]
- Needs Work (X pts): [Description]
```

## Tips for Effective Rubrics

1. **Use Observable Behaviors**: "Includes 5+ citations" not "Good use of sources"
2. **Avoid Ambiguous Terms**: Define what "thorough" or "adequate" means
3. **Parallel Structure**: Each level should address same aspects
4. **Distinguish Levels Clearly**: Each level should be meaningfully different
5. **Include Examples**: When possible, reference exemplar work
6. **Align with Learning Objectives**: Criteria should map to course goals
