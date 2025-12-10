# Canvas LMS Operations

Perform Canvas LMS-related tasks using examark integration.

## Purpose

Streamline Canvas LMS workflows:
- Convert exams to QTI format for import
- Validate quiz formatting
- Preview how questions will appear
- Manage question banks

## Available Operations

### 1. Export to QTI
Convert examark markdown to Canvas-compatible QTI format.

```bash
examark exam.md -o exam.qti.zip
```

### 2. Validate Format
Check exam file for formatting issues before export.

```bash
examark check exam.md
```

### 3. Preview Questions
See how questions will render in Canvas.

```bash
examark exam.md --preview
```

### 4. Emulate Canvas View
Test the full Canvas quiz experience locally.

```bash
examark exam.md --emulate
```

## Supported Question Types

| Type | Examark Syntax | Canvas Type |
|------|----------------|-------------|
| Multiple Choice | `- [ ]` / `- [x]` | MC |
| True/False | `- [x] True` / `- [ ] False` | TF |
| Multiple Answer | `- [x]` (multiple) | MA |
| Short Answer | `> answer` | SA |
| Essay | `> [essay]` | Essay |
| Matching | `A -> 1` | Matching |
| Fill-in-Blank | `___[answer]___` | FIB |
| Numerical | `> 42 +/- 0.5` | Numerical |

## Workflow

1. **Create exam** using `/exam` or `/quiz` command
2. **Validate** with `examark check`
3. **Preview** to verify rendering
4. **Export** to QTI zip file
5. **Import** into Canvas via Settings > Import

## Canvas Import Steps

1. Go to course Settings
2. Click "Import Course Content"
3. Select "QTI .zip file"
4. Upload the generated .qti.zip
5. Select import options
6. Review imported questions in Question Banks

## Troubleshooting

### Common Issues

- **Import fails**: Run `examark check` to validate format
- **Images missing**: Ensure image paths are correct
- **Points wrong**: Check frontmatter `points` field
- **Answers not marked**: Verify `[x]` syntax

### Format Requirements

- UTF-8 encoding
- Valid YAML frontmatter
- Proper markdown structure
- Correct answer markers

## Examples

**Request**: "Export my midterm exam to QTI format for Canvas"

**Request**: "Check if my quiz file is valid for Canvas import"

**Request**: "Preview how question 5 will look in Canvas"

**Request**: "Help me fix Canvas import errors in my exam file"

## Integration

This command works with:
- `/exam` - Create full exams
- `/quiz` - Create quick quizzes
- `/homework` - Create problem sets
- `examark` CLI tool
