# Teaching Commands

Commands for course development and teaching: exams, quizzes, lectures, and Canvas LMS integration.

## Commands Overview

| Command | Purpose |
|---------|---------|
| `/teach/exam` | Create full exams (examark format) |
| `/teach/quiz` | Quick formative assessments |
| `/teach/rubric` | Grading rubrics |
| `/teach/lecture` | Lecture outlines |
| `/teach/homework` | Problem sets |
| `/teach/solution` | Solution keys |
| `/teach/syllabus` | Course syllabus |
| `/teach/feedback` | Student feedback |
| `/teach/canvas` | Canvas LMS operations |

---

## /teach/exam

Create comprehensive exams using examark format for Canvas LMS.

**Use for:**
- Midterm and final exams
- Multi-format assessments
- Canvas-compatible exports
- Question banks

**Example:**
```
/teach/exam "Create a 25-question final on multiple regression. 10 MC, 5 TF, 5 short answer, 5 problems."
```

**Integration:** examark CLI for QTI export

**Question Types Supported:**
- Multiple choice
- True/false
- Short answer
- Essay
- Matching
- Fill-in-blank
- Numerical

---

## /teach/quiz

Generate quick quizzes for formative assessment.

**Use for:**
- In-class knowledge checks
- Pre-lecture preparation
- Post-lesson review
- Practice problems

**Example:**
```
/teach/quiz "5-question quiz on hypothesis testing basics"
```

---

## /teach/rubric

Create detailed grading rubrics.

**Use for:**
- Assignment rubrics
- Project evaluation criteria
- Presentation scoring
- Peer review guidelines

**Example:**
```
/teach/rubric "Create a rubric for a data analysis project, 100 points"
```

---

## /teach/lecture

Generate lecture outlines and materials.

**Use for:**
- Lecture planning
- Topic organization
- Learning objectives
- Discussion prompts

**Example:**
```
/teach/lecture "75-minute lecture on ANOVA for undergraduates"
```

---

## /teach/homework

Create problem sets and assignments.

**Use for:**
- Weekly homework
- Practice problems
- Take-home assignments
- Study guides

**Example:**
```
/teach/homework "10 problems on linear regression, with data sets"
```

---

## /teach/solution

Generate solution keys with explanations.

**Use for:**
- Answer keys
- Worked solutions
- Grading guides
- Study materials

**Example:**
```
/teach/solution "Create solutions for homework 5 on correlation"
```

---

## /teach/syllabus

Create comprehensive course syllabi.

**Use for:**
- New course development
- Syllabus updates
- Policy documentation
- Schedule planning

**Example:**
```
/teach/syllabus "STAT 101 Introduction to Statistics, Fall 2025, MWF 10am"
```

---

## /teach/feedback

Generate constructive student feedback.

**Use for:**
- Assignment feedback
- Exam comments
- Progress reports
- Improvement suggestions

**Example:**
```
/teach/feedback "Provide feedback on this student's regression analysis [paste work]"
```

---

## /teach/canvas

Canvas LMS operations using examark.

**Use for:**
- QTI export for Canvas import
- Quiz validation
- Format checking
- Preview generation

**Example:**
```
/teach/canvas "Export my midterm to QTI format"
```

**Operations:**
```bash
examark exam.md -o exam.qti.zip  # Export
examark check exam.md            # Validate
examark exam.md --preview        # Preview
```

---

## examark Integration

All teaching commands support [examark](https://github.com/Data-Wise/examark) format:

```markdown
---
title: "Midterm Exam"
course: "STAT 101"
time_limit: "90 minutes"
points: 100
---

## Question 1 (5 points)
What is the null hypothesis for a t-test?

- [ ] The means are different
- [x] The means are equal
- [ ] The variance is zero
- [ ] The sample size is large
```

---

## Workflows

### Exam Creation Workflow
```
1. /teach/exam "create exam content"
2. /teach/canvas "validate format"
3. /teach/solution "create answer key"
4. /teach/rubric "create grading rubric"
```

### Course Development Workflow
```
1. /teach/syllabus "create syllabus"
2. /teach/lecture "plan lectures"
3. /teach/homework "create assignments"
4. /teach/quiz "add formative assessments"
```
