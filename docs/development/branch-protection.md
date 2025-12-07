# Branch Protection Setup

This guide explains how to configure GitHub branch protection for the `main` branch to maintain stability.

## Why Branch Protection?

- **main** branch auto-deploys to GitHub Pages
- Keep main always stable and deployable
- Prevent accidental direct commits to main
- Ensure all changes go through dev branch first

## Recommended Settings

### For `main` Branch

Go to: **Settings** → **Branches** → **Add branch protection rule**

**Branch name pattern**: `main`

#### Protection Rules

✅ **Require a pull request before merging**
  - Required approvals: 1 (or 0 for solo maintainer)
  - Dismiss stale pull request approvals when new commits are pushed
  - ❌ Do NOT require review from Code Owners (optional)

✅ **Require status checks to pass before merging**
  - ❌ Require branches to be up to date before merging (optional)
  - Status checks: Add if you have CI/CD workflows

✅ **Require conversation resolution before merging**

✅ **Include administrators**
  - Even admins must follow the rules

❌ **Do not allow bypassing the above settings**

#### Additional Settings

✅ **Require linear history**
  - Keeps git history clean

✅ **Allow force pushes** → **Specify who can force push**
  - Add yourself only if needed for emergency fixes

✅ **Allow deletions** → ❌ (keep unchecked)
  - Prevents accidental branch deletion

## For `dev` Branch (Optional)

**Branch name pattern**: `dev`

Lighter protection:
- ❌ No PR required (you can commit directly)
- ✅ Require status checks if you have CI/CD
- ❌ No approval required

## Workflow After Setup

### Normal Development

```bash
# Work on dev branch
git checkout dev
git pull origin dev

# Make changes
# Test locally
git add .
git commit -m "feat: add new feature"
git push origin dev
```

### Creating a Release

```bash
# On GitHub: Create PR from dev -> main
# Title: "Release v1.2.0"
# Review changes
# Merge PR

# This triggers GitHub Pages deployment automatically
```

### Hotfix to Production

If you need to fix something urgent in production:

```bash
# Create branch from main
git checkout main
git pull origin main
git checkout -b hotfix/urgent-fix

# Fix and test
git add .
git commit -m "fix: urgent production issue"
git push origin hotfix/urgent-fix

# Create PR to main (requires approval if configured)
# After merge, also merge main back to dev to sync
git checkout dev
git merge main
git push origin dev
```

## Current Status

- ⚠️ **main** branch protection: **Not yet configured**
- ⚠️ **dev** branch protection: **Not needed** (direct commits OK)

### To Configure

1. Go to: https://github.com/Data-Wise/zsh-claude-workflow/settings/branches
2. Click **Add branch protection rule**
3. Follow settings above for `main` branch
4. Save changes

## Verification

After setup, test by trying to push directly to main:

```bash
git checkout main
echo "test" >> test.txt
git add test.txt
git commit -m "test direct push"
git push origin main
```

You should see an error like:
```
remote: error: GH006: Protected branch update failed
```

This confirms protection is working! ✅

## Related Documentation

- [GitHub Branch Protection Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [Contributing Guide](../CONTRIBUTING.md)
- [Development Architecture](architecture.md)
