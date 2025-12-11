# GitHub Private Repo Impact: zsh-claude-workflow

> **Date:** 2025-12-10
> **Decision:** Make zsh-claude-workflow PRIVATE on GitHub
> **Context:** User feedback on COMPLETE_RESTRUCTURE_SUMMARY.md

---

## Impact Analysis

### ✅ What STILL Works (No Impact)

**Internal Collaboration (Data-Wise Organization)**
- ✅ All Data-Wise org members can access
- ✅ Can add collaborators manually
- ✅ Issues, PRs, project boards work normally
- ✅ Git operations (clone, push, pull) work
- ✅ Can still coordinate with other repos in Data-Wise org
- ✅ GitHub Actions workflows work
- ✅ Branch protection rules work

**Development Workflow**
- ✅ Can still use MCP server integration
- ✅ Claude Code can still access local files
- ✅ Commands still work the same way
- ✅ Documentation site can still be hosted (GitHub Pages for private repos)
- ✅ Can share with specific collaborators via invite

---

### ⚠️ What Changes (Impacts to Consider)

**Public Visibility**
- ❌ Repo won't appear in public GitHub search
- ❌ Can't showcase on your GitHub profile (shows private badge only)
- ❌ No public star count or community discovery
- ❌ README badges won't be publicly visible

**External Contributions**
- ⚠️ Can't accept contributions from non-org members without explicit invite
- ⚠️ No community PRs or issues from external developers
- ⚠️ Can't share via public URL (must invite collaborators)

**Documentation**
- ⚠️ GitHub Pages can be enabled for private repos (organization plan required)
- ✅ Can still deploy docs, but URL requires authentication
- ✅ Or host docs publicly on separate domain (docs site can be public even if code is private)

**Coordination Impact**
- ⚠️ Other Data-Wise repos can't reference in public docs (links will 404 for non-members)
- ✅ Can still be used internally across all Data-Wise projects
- ✅ MCP server, claude-r-dev, other tools can still reference it (local paths)

---

## Recommendations

### Recommended Approach: Private Development, Public Documentation

**Make Repo Private:**
✅ Keep zsh-claude-workflow PRIVATE

**Reasons:**
1. **Personal Workflow Tool** - This is your personal productivity system, not a public library
2. **ADHD Optimizations** - Contains personal workflow patterns
3. **Integration Points** - Tightly integrated with your specific setup
4. **Rapid Iteration** - Don't need public release process
5. **Privacy** - Contains paths and personal preferences

**Keep Documentation Public (Optional):**
If you want to share knowledge without code:
- Deploy MkDocs site to separate public domain
- OR create separate public "docs-only" repo
- OR make GitHub Pages public (org setting)

### Access Strategy

**Who Needs Access:**
1. **You** (owner) - Full access
2. **Data-Wise org members** - Automatic access if in org
3. **Specific collaborators** - Invite manually

**How to Share:**
```bash
# Clone for org members
git clone git@github.com:Data-Wise/zsh-claude-workflow.git

# Invite external collaborator (if needed)
gh repo invite-collaborator Data-Wise/zsh-claude-workflow USERNAME
```

---

## Updated GitHub Plan

### Phase 1: Publish Missing Repos (Revised)

| Repo | Visibility | Reason |
|------|-----------|---------|
| **zsh-claude-workflow** | **PRIVATE** | Personal workflow tool |
| medfit | PUBLIC | R package (future CRAN) |
| probmed | PUBLIC | R package (future CRAN) |
| rmediation | PUBLIC | R package (future CRAN) |
| medrobust | PUBLIC | R package (future CRAN) |
| medsim | PUBLIC | R package (future CRAN) |
| mediationverse | PUBLIC | Meta package (future CRAN) |
| claude-statistical-research | PUBLIC | MCP server (community tool) |
| claude-r-dev | PUBLIC | Development profiles (community) |
| emacs-r-devkit | PUBLIC | Emacs config (community) |
| r-package-dev-gemini | PRIVATE | Personal tool |
| quarto-extensions/* | PUBLIC | Community extensions |

### Phase 2: Standardize Private Repos

**For zsh-claude-workflow (PRIVATE):**
```bash
cd ~/projects/dev-tools/zsh-claude-workflow

# Create repo as PRIVATE
gh repo create Data-Wise/zsh-claude-workflow \
  --private \
  --source=. \
  --description="Personal zsh workflow automation for Claude Code integration" \
  --push

# Still add standard files (internal use)
# Already have: README.md, LICENSE, CONTRIBUTING.md, .github/, CLAUDE.md
```

**Standard Files (Even for Private Repos):**
- ✅ README.md (for collaborators)
- ✅ LICENSE (MIT)
- ✅ CONTRIBUTING.md (team guidelines)
- ✅ CLAUDE.md (AI context)
- ✅ .github/workflows/ (Actions still work)
- ✅ Issue/PR templates (internal use)

---

## Coordination Strategy (Private Repo)

### Internal Coordination (Data-Wise Org)

**How Other Repos Reference zsh-claude-workflow:**

1. **In Documentation:**
```markdown
<!-- In other Data-Wise repos -->
See [zsh-claude-workflow](https://github.com/Data-Wise/zsh-claude-workflow)
for workflow automation (Data-Wise members only).
```

2. **In Code/Scripts:**
```bash
# Local path references (works for all org members)
export ZSH_CLAUDE_WORKFLOW="$HOME/projects/dev-tools/zsh-claude-workflow"
source "$ZSH_CLAUDE_WORKFLOW/lib/core.sh"
```

3. **In CLAUDE.md Files:**
```markdown
## Related Tools

- **zsh-claude-workflow** (private) - Shell automation
  - Path: ~/projects/dev-tools/zsh-claude-workflow
  - Repo: https://github.com/Data-Wise/zsh-claude-workflow (org access only)
```

### Cross-Project Integration

**Projects that reference zsh-claude-workflow:**
- claude-statistical-research (MCP server)
- claude-r-dev (development profiles)
- R packages (via commands in PATH)

**Integration approach:**
- All use local paths (`~/projects/dev-tools/zsh-claude-workflow`)
- No public URL dependencies
- Commands in PATH work regardless of repo visibility
- Git submodules NOT needed (separate repos)

---

## Benefits of Private Repo

### Privacy Benefits
✅ Personal workflow patterns not exposed
✅ File paths and directory structure private
✅ ADHD-specific optimizations remain personal
✅ Can iterate rapidly without public scrutiny

### Coordination Benefits
✅ Still works with all Data-Wise projects
✅ Org members have full access
✅ No external noise (random issues/PRs)
✅ Focused internal development

### Workflow Benefits
✅ No need to sanitize personal info before commits
✅ Can commit WIP without worrying about public view
✅ Faster iteration (no public release process)
✅ Commands still work from PATH (local installation)

---

## Migration Checklist

```bash
# 1. Create private repo on GitHub
cd ~/projects/dev-tools/zsh-claude-workflow
gh repo create Data-Wise/zsh-claude-workflow \
  --private \
  --source=. \
  --description="Personal zsh workflow automation for Claude Code integration" \
  --push

# 2. Verify settings
gh repo view Data-Wise/zsh-claude-workflow --web
# Check: Visibility = Private

# 3. Update remote (if needed)
git remote set-url origin git@github.com:Data-Wise/zsh-claude-workflow.git

# 4. Push all branches
git push -u origin main
git push -u origin dev

# 5. Set default branch to dev
gh repo edit Data-Wise/zsh-claude-workflow --default-branch dev

# 6. Configure branch protection (optional, works in private repos)
gh api repos/Data-Wise/zsh-claude-workflow/branches/main/protection \
  -X PUT \
  -F required_pull_request_reviews[required_approving_review_count]=0 \
  -F enforce_admins=false \
  -F required_status_checks=null \
  -F restrictions=null

# 7. Invite collaborators (if needed)
# gh repo invite-collaborator Data-Wise/zsh-claude-workflow USERNAME
```

---

## Documentation Strategy (Optional)

If you want public-facing documentation without exposing code:

### Option 1: Public GitHub Pages (Separate Deploy)
```bash
# Build docs
mkdocs build

# Deploy to separate branch (can be public)
mkdocs gh-deploy --force

# Set GitHub Pages to public (repo settings)
# Repo → Settings → Pages → Set to public
```

### Option 2: External Hosting
```bash
# Deploy to Netlify/Vercel/custom domain
mkdocs build
# Upload site/ directory to hosting service
```

### Option 3: Keep Docs Private Too
```bash
# Simplest: docs only accessible to org members
# GitHub Pages deployed but requires authentication
```

**Recommendation:** Option 3 (keep docs private)
- zsh-claude-workflow is a personal tool
- Documentation contains personal workflow patterns
- Not intended for public use
- Org members can access if needed

---

## Summary

### ✅ Making zsh-claude-workflow PRIVATE is recommended

**Reasons:**
1. Personal productivity tool (not public library)
2. Contains personal workflow patterns and ADHD optimizations
3. Tightly integrated with your specific environment
4. Doesn't affect Data-Wise org coordination
5. Allows rapid iteration without public releases

**No Impact On:**
- Internal Data-Wise collaboration
- MCP server integration
- claude-r-dev integration
- Command availability (installed to PATH)
- Git workflows
- GitHub Actions
- Documentation deployment

**Affected:**
- Public discovery (not relevant for personal tool)
- External contributions (not needed)
- Public showcase (not important for workflow tool)

### 🎯 Action: Create as PRIVATE when publishing to GitHub

**Next Steps:**
1. Create repo as private on GitHub
2. Push main and dev branches
3. Set up branch protection (optional)
4. Continue using locally as before
5. Org members get automatic access

**Coordination:** Works perfectly with Data-Wise ecosystem via local paths and org access.
