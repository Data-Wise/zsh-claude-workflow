# Create Lecture Outline

Generate structured lecture outlines with learning objectives, key concepts, and activities.

## Required Input

- **Topic**: What is the lecture about?
- **Course Level**: Undergraduate, graduate, professional
- **Duration**: Class length (50 min, 75 min, 3 hours, etc.)
- **Prerequisites**: What students should already know
- **Learning Objectives**: What students should be able to do after (optional)

## Process

1. **Define Objectives**: Clear, measurable learning outcomes
2. **Structure Content**: Logical flow from simple to complex
3. **Plan Activities**: Engagement points and practice opportunities
4. **Create Materials**: Slides outline, handouts, examples
5. **Design Assessment**: Check for understanding methods

## Output Format

```markdown
# Lecture: [Topic]

## Overview
- **Course**: [Course name/number]
- **Duration**: [Time]
- **Prerequisites**: [What students need to know]

## Learning Objectives
By the end of this lecture, students will be able to:
1. [Objective 1 - use action verbs: explain, calculate, compare, apply]
2. [Objective 2]
3. [Objective 3]

## Outline

### I. Introduction (X min)
- Hook/motivation: [Why this matters]
- Connection to previous material
- Overview of today's topics

### II. [First Major Topic] (X min)
- Key concept 1
  - Definition
  - Example
  - Common misconception
- Key concept 2
- **Activity**: [Brief engagement activity]

### III. [Second Major Topic] (X min)
- Key concept 3
- Worked example
- **Think-Pair-Share**: [Discussion question]

### IV. [Third Major Topic] (X min)
- Key concept 4
- Application to real-world problem
- **Practice Problem**: [In-class exercise]

### V. Summary & Preview (X min)
- Key takeaways (3-5 points)
- Connection to next lecture
- Assignment reminder

## Materials Needed
- [ ] Slides
- [ ] Handout with practice problems
- [ ] Dataset for demonstration (if applicable)

## Assessment Ideas
- Exit ticket question
- Clicker/poll questions
- Homework problems

## Notes for Instructor
- Potential student questions
- Tricky points to emphasize
- Timing adjustments if needed
```

## Lecture Types

### Conceptual/Theoretical
- Focus on understanding "why"
- Use analogies and visualizations
- Include proofs or derivations (simplified)
- Connect to intuition

### Applied/Computational
- Focus on "how to"
- Live coding or software demonstrations
- Worked examples with real data
- Practice problems

### Discussion-Based
- Prepare discussion questions
- Plan small group activities
- Have backup content if discussion stalls
- Allow flexibility in timing

## Bloom's Taxonomy Alignment

| Level | Verbs | Example Activity |
|-------|-------|------------------|
| Remember | Define, list, recall | Vocabulary quiz |
| Understand | Explain, summarize | Concept map |
| Apply | Calculate, solve | Practice problems |
| Analyze | Compare, contrast | Case study |
| Evaluate | Critique, justify | Peer review |
| Create | Design, construct | Project |

## Example Prompts

"Create a 75-minute lecture outline on multiple linear regression for an undergraduate intro stats course. Students have seen simple regression. Include at least one active learning component."

"Design a 3-hour graduate lecture on causal inference with observational data. Cover matching, propensity scores, and regression discontinuity. Include R code examples."

"Outline a 50-minute lecture introducing mediation analysis for a structural equation modeling course. Focus on Baron & Kenny approach and modern alternatives."

## Integration

- Use `/derive` for mathematical derivations in lecture
- Use `/example` for worked examples
- Use `/quiz` for embedded assessment questions
- Use `/homework` for follow-up problem sets

## Tips

1. **Plan for Less**: Content always takes longer than expected
2. **Build in Breaks**: Attention drops after 15-20 minutes
3. **Prepare Backup**: Have optional content to add or cut
4. **Check Understanding**: Don't just ask "Any questions?"
5. **Connect Dots**: Explicitly link to previous and future material
