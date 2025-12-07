# Claude Skills

This directory contains templates for creating project-specific Claude skills.

## What are Skills?

Skills are context files (markdown) that Claude Code can use to understand your project-specific conventions, patterns, and requirements. They act as "expertise modules" that Claude can reference when working on your code.

## Skill Locations

Skills can exist at two levels:

1. **User-level** (`~/.claude/skills/`): Global skills available to all projects
2. **Project-level** (`.claude/skills/`): Project-specific skills or customizations

The `skill-activate` command creates symlinks from user-level skills to project-level, allowing easy activation/deactivation.

## Available Templates

- `r-package-skill.md` - R package development skill template
- `quarto-skill.md` - Quarto project skill template
- `simulation-skill.md` - Statistical simulation skill template

## Creating a Skill

From a template:

```bash
# This creates a new skill in .claude/skills/
skill-activate create my-skill --template r-package
```

Manually:

1. Create a markdown file in `~/.claude/skills/`
2. Write your guidelines, conventions, and patterns
3. Activate for specific projects with `skill-activate <skill-name>`

## Skill Format

Skills are markdown files with sections like:

```markdown
# Skill Name

Brief description of what this skill provides.

## When to Use This Skill

- Situation 1
- Situation 2

## Guidelines

### Topic 1

Detailed guidelines...

### Topic 2

More guidelines...

## Examples

Code examples and patterns...

## Notes

Additional context...
```

## Managing Skills

```bash
# List available user-level skills
skill-activate available

# Show active skills for current project
skill-activate list

# Activate a skill
skill-activate r-package-development

# Deactivate a skill
skill-activate deactivate r-package-development

# Show skill details
skill-activate show r-package-development

# Auto-activate recommended skills
skill-activate auto
```

## Recommended Skills by Project Type

- **R Package**: r-package-development, zsh-environment
- **Quarto Manuscript**: manuscript-writing-guide, doc-management
- **Research Simulation**: statistical-simulation-guide, r-simulation-config

## Best Practices

1. **Keep skills focused**: Each skill should cover one domain
2. **Use clear sections**: Organize with markdown headers
3. **Include examples**: Show don't just tell
4. **Link related skills**: Reference other skills when relevant
5. **Update regularly**: Keep skills current as conventions evolve
