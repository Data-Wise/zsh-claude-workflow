# Contributing to zsh-claude-workflow

Thank you for your interest in contributing! 🎉

## Quick Links

- **Full Contributing Guide**: https://data-wise.github.io/zsh-claude-workflow/development/contributing/
- **Architecture Documentation**: https://data-wise.github.io/zsh-claude-workflow/development/architecture/
- **Testing Guide**: https://data-wise.github.io/zsh-claude-workflow/development/testing/

## Branch Strategy

We use a two-branch workflow:

- **main** - Production branch (protected)
  - Always stable and deployable
  - Auto-deploys to GitHub Pages
  - Only accepts PRs from `dev` branch

- **dev** - Development branch (default for PRs)
  - Active development happens here
  - Feature branches merge here first
  - Gets merged to `main` when stable

- **feature/** - Feature branches (optional)
  - For larger features: `feature/new-command`
  - Branch from `dev`, merge back to `dev`

## Quick Start

1. Fork the repository
2. Clone your fork
3. Create a feature branch from `dev`
4. Make your changes
5. Test thoroughly
6. Submit a pull request to `dev` (not `main`)

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR-USERNAME/zsh-claude-workflow.git
cd zsh-claude-workflow

# Switch to dev branch
git checkout dev

# Create a feature branch from dev
git checkout -b feature/your-feature-name

# Make changes and test
./commands/proj-type
./commands/claude-ctx
./tests/test-structure.zsh

# Commit and push
git add .
git commit -m "feat: your feature description"
git push origin feature/your-feature-name

# Create PR targeting 'dev' branch (not 'main')
```

## Coding Standards

- Use zsh-specific features and syntax
- Follow existing naming conventions
- Provide helpful error messages
- Test on multiple project types
- Update documentation

## Need Help?

- Read the [full contributing guide](https://data-wise.github.io/zsh-claude-workflow/development/contributing/)
- Open an issue for questions
- Join discussions on GitHub

We appreciate your contributions! 🚀
