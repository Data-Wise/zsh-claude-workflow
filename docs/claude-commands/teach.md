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

### Complete Example: Statistics Midterm

**Request:**
```
/teach/exam "Create a 20-question midterm on hypothesis testing for
undergraduate statistics. Include 8 MC, 4 TF, 4 short answer, and
4 computation problems. Cover: null/alternative hypotheses, Type I/II
errors, p-values, t-tests, and confidence intervals."
```

**Generated Exam (examark format):**

~~~markdown
---
title: "STAT 101 Midterm Exam"
course: "Introduction to Statistics"
date: "2025-03-15"
time_limit: "75 minutes"
points: 100
instructions: |
  - Show all work for computation problems
  - No calculators with programming capability
  - Formula sheet provided
---

## Part 1: Multiple Choice (24 points, 3 each)

### Question 1
The null hypothesis typically represents:

- [ ] The researcher's prediction
- [x] No effect or no difference
- [ ] The alternative explanation
- [ ] A significant result

### Question 2
A Type I error occurs when we:

- [ ] Fail to reject a false null hypothesis
- [x] Reject a true null hypothesis
- [ ] Accept a true alternative hypothesis
- [ ] Fail to reject a true null hypothesis

### Question 3
If p = 0.03 and α = 0.05, we should:

- [x] Reject the null hypothesis
- [ ] Fail to reject the null hypothesis
- [ ] Accept the null hypothesis
- [ ] Increase the sample size

### Question 4
A 95% confidence interval means:

- [ ] 95% of sample means fall in this interval
- [ ] There is a 95% probability the true mean is in this interval
- [x] 95% of such intervals contain the true population parameter
- [ ] The sample mean is 95% accurate

[Questions 5-8 continue with similar format...]

## Part 2: True/False (12 points, 3 each)

### Question 9
A smaller p-value provides stronger evidence against the null hypothesis.

- [x] True
- [ ] False

### Question 10
Increasing sample size always decreases the p-value.

- [ ] True
- [x] False

[Questions 11-12 continue...]

## Part 3: Short Answer (24 points, 6 each)

### Question 13
In your own words, explain the difference between a Type I and
Type II error. Give a real-world example of each.

> [essay]
> Rubric: Type I definition (2pts), Type II definition (2pts),
> appropriate examples (2pts)

### Question 14
Why is it incorrect to say "we accept the null hypothesis"
when p > α? What should we say instead?

> [essay]
> Rubric: Explains cannot prove null (2pts), correct terminology (2pts),
> reasoning about evidence (2pts)

[Questions 15-16 continue...]

## Part 4: Computation (40 points, 10 each)

### Question 17
A researcher claims the average study time is more than 15 hours/week.
A sample of n=25 students shows x̄=17.2 hours, s=4.5 hours.

a) State H₀ and H₁ (2 pts)
b) Calculate the test statistic (3 pts)
c) Find the p-value using the t-table (2 pts)
d) State your conclusion at α=0.05 (3 pts)

> [essay]
> Answer:
> a) H₀: μ ≤ 15, H₁: μ > 15
> b) t = (17.2-15)/(4.5/√25) = 2.44
> c) df=24, p ≈ 0.011 (one-tailed)
> d) Reject H₀; evidence supports claim

[Questions 18-20 continue with similar computation problems...]
~~~

**Bloom's Taxonomy Distribution:**
- Remember/Understand: Questions 1-4, 9-10 (30%)
- Apply: Questions 5-8, 17-18 (40%)
- Analyze: Questions 11-12, 13-16, 19-20 (30%)

**Canvas Export:**
```bash
examark midterm.md -o midterm.qti.zip
# Import via Canvas > Settings > Import Course Content
```

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
