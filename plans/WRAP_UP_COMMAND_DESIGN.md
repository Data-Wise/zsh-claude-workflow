# Wrap-Up Command Design

> **Purpose:** Automate session wrap-up workflow
> **Date:** 2025-12-11
> **Status:** Design phase

---

## 🎯 Command Name Options

### Option 1: `session-wrap` ⭐ RECOMMENDED
**Rationale:**
- Clear purpose: wrapping up a session
- Verb-noun pattern (consistent with existing commands)
- Not too long, easy to type
- Unambiguous

**Usage:**
```bash
session-wrap                    # Full wrap-up (default)
session-wrap --quick            # Quick commit only
session-wrap --no-commit        # Update docs only
session-wrap --message "Custom" # Custom commit message
```

---

### Option 2: `checkpoint`
**Rationale:**
- Short and memorable
- Common term in gaming/computing
- Implies saving state

**Usage:**
```bash
checkpoint                  # Create checkpoint
checkpoint --message "msg"  # With custom message
```

**Pros:**
- ✅ Short (10 chars)
- ✅ Memorable
- ✅ Common term

**Cons:**
- ❌ Less descriptive
- ❌ Might confuse with git checkpoints
- ❌ Doesn't clearly indicate "session end"

---

### Option 3: `save-session`
**Rationale:**
- Very clear purpose
- Matches common UI patterns ("Save Session")
- Self-documenting

**Usage:**
```bash
save-session                # Save current session
save-session --quick        # Quick save
```

**Pros:**
- ✅ Very clear
- ✅ Self-documenting

**Cons:**
- ❌ Longer to type (12 chars)
- ❌ Hyphenated (requires Shift)

---

### Option 4: `wrap`
**Rationale:**
- Shortest possible
- Quick to type
- Common term

**Usage:**
```bash
wrap              # Wrap up session
wrap --quick      # Quick wrap
```

**Pros:**
- ✅ Ultra short (4 chars)
- ✅ Fast to type
- ✅ No special characters

**Cons:**
- ❌ Too generic
- ❌ Could mean many things
- ❌ Not self-documenting

---

### Option 5: `claude-wrap`
**Rationale:**
- Namespaced to Claude workflows
- Clear purpose
- Matches existing patterns (claude-init, claude-ctx)

**Usage:**
```bash
claude-wrap           # Wrap up Claude session
claude-wrap --quick   # Quick wrap
```

**Pros:**
- ✅ Consistent with existing commands
- ✅ Clear namespace
- ✅ Self-documenting

**Cons:**
- ❌ Longer (11 chars)
- ❌ Hyphenated

---

## 🏆 Recommendation: `session-wrap`

**Why:**
1. Clear and descriptive
2. Verb-noun pattern (like existing commands)
3. Not too long, not too short
4. Unambiguous purpose
5. Professional sound

**Alternative:** `checkpoint` as alias for quick typing

---

## 📋 Command Workflow

### Full Workflow (Default)

```bash
session-wrap
```

**Steps:**
1. **Detect changes**
   - Check for uncommitted files
   - Identify new/modified files in plans/
   - Check CLAUDE.md status

2. **Update planning documents**
   - Create/update session summary in plans/
   - Filename: `SESSION_WRAP_UP_YYYY-MM-DD.md`
   - Content: Accomplishments, files changed, next steps

3. **Update CLAUDE.md**
   - Add to version history
   - Update current version section
   - Add feature notes
   - Update statistics

4. **Stage files**
   - git add all relevant files
   - Respect .gitignore
   - Confirm staging with user

5. **Create commit**
   - Auto-generate commit message from changes
   - Or use user-provided message
   - Include Co-Authored-By footer

6. **Clean up**
   - Remove .bak files
   - Remove temp files
   - Clean build artifacts

7. **Generate summary**
   - Display what was done
   - Show commit hash
   - List files committed
   - Provide next steps

---

### Quick Workflow

```bash
session-wrap --quick
# or
checkpoint
```

**Steps:**
1. Stage all changes
2. Create simple commit
3. Show summary

**Skip:**
- Planning document creation
- CLAUDE.md update
- Cleanup
- Detailed summary

---

### Update-Only Workflow

```bash
session-wrap --no-commit
```

**Steps:**
1. Update planning documents
2. Update CLAUDE.md
3. Show summary

**Skip:**
- Git operations
- Cleanup

---

## 🛠️ Command Design

### File Structure

```bash
commands/
└── session-wrap           # Main command

lib/
├── session-manager.sh     # Session wrap-up logic
└── commit-generator.sh    # Auto-generate commit messages (optional)

templates/
└── SESSION_WRAP_UP.md     # Template for session summary
```

---

### Command Interface

```bash
#!/usr/bin/env zsh
# session-wrap - Wrap up Claude Code session with documentation

SCRIPT_DIR="${0:A:h}"
LIB_DIR="${SCRIPT_DIR}/../lib"

source "$LIB_DIR/core.sh"
source "$LIB_DIR/session-manager.sh"

# Options
local quick=false
local no_commit=false
local message=""
local cleanup=true

# Parse options
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quick)
            quick=true
            shift
            ;;
        -n|--no-commit)
            no_commit=true
            shift
            ;;
        -m|--message)
            message="$2"
            shift 2
            ;;
        --no-cleanup)
            cleanup=false
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Execute workflow
if [[ "$quick" == "true" ]]; then
    quick_wrap "$message"
elif [[ "$no_commit" == "true" ]]; then
    update_only
else
    full_wrap "$message" "$cleanup"
fi
```

---

### Session Manager Library

```bash
# lib/session-manager.sh

# Full wrap-up workflow
full_wrap() {
    local message="$1"
    local cleanup="$2"

    print_header "Session Wrap-Up"
    echo

    # 1. Detect changes
    local changes=$(detect_changes)
    if [[ -z "$changes" ]]; then
        print_warning "No changes detected"
        return 0
    fi

    # 2. Update planning documents
    print_info "Updating planning documents..."
    update_session_summary

    # 3. Update CLAUDE.md
    print_info "Updating CLAUDE.md..."
    update_knowledge

    # 4. Clean up (if enabled)
    if [[ "$cleanup" == "true" ]]; then
        print_info "Cleaning up temporary files..."
        cleanup_temp_files
    fi

    # 5. Stage files
    print_info "Staging files..."
    stage_files

    # 6. Create commit
    if [[ -z "$message" ]]; then
        message=$(generate_commit_message)
    fi

    print_info "Creating commit..."
    create_commit "$message"

    # 7. Generate summary
    print_success "Session wrapped up successfully!"
    show_summary
}

# Quick wrap-up
quick_wrap() {
    local message="$1"

    print_header "Quick Wrap-Up"

    stage_files

    if [[ -z "$message" ]]; then
        message="chore: session checkpoint"
    fi

    create_commit "$message"
    print_success "Quick save complete!"
}

# Update only (no commit)
update_only() {
    print_header "Update Documentation"

    update_session_summary
    update_knowledge

    print_success "Documentation updated!"
    print_info "Run 'git add' and 'git commit' when ready"
}

# Detect uncommitted changes
detect_changes() {
    git status --short
}

# Update session summary
update_session_summary() {
    local date=$(date +%Y-%m-%d)
    local summary_file="plans/SESSION_WRAP_UP_${date}.md"

    # Check if summary already exists
    if [[ -f "$summary_file" ]]; then
        print_warning "Session summary already exists: $summary_file"
        read "response?Update existing summary? (y/n) "
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            return 0
        fi
    fi

    # Generate summary content
    local accomplishments=$(detect_accomplishments)
    local files_changed=$(git status --short | wc -l | tr -d ' ')
    local next_steps=$(suggest_next_steps)

    # Create summary from template
    create_session_summary "$summary_file" "$accomplishments" "$files_changed" "$next_steps"

    print_success "Created: $summary_file"
}

# Update CLAUDE.md knowledge
update_knowledge() {
    local claude_md="CLAUDE.md"

    if [[ ! -f "$claude_md" ]]; then
        print_warning "CLAUDE.md not found, skipping"
        return 0
    fi

    # Detect what changed
    local new_commands=$(detect_new_commands)
    local new_libraries=$(detect_new_libraries)
    local new_features=$(detect_new_features)

    # Prompt for version notes
    echo "${fg[cyan]}What should be added to version history?${reset_color}"
    echo "Detected changes:"
    [[ -n "$new_commands" ]] && echo "  - New commands: $new_commands"
    [[ -n "$new_libraries" ]] && echo "  - New libraries: $new_libraries"
    [[ -n "$new_features" ]] && echo "  - New features: $new_features"
    echo

    read "version_note?Version note (or press Enter to skip): "

    if [[ -n "$version_note" ]]; then
        add_to_version_history "$version_note"
        print_success "Updated CLAUDE.md"
    fi
}

# Clean up temporary files
cleanup_temp_files() {
    # Remove backup files
    find . -name "*.bak" -o -name "*.bak2" -o -name "*~" | while read file; do
        print_info "Removing: $file"
        rm "$file"
    done

    # Remove temp directories
    rm -rf .tmp 2>/dev/null
    rm -rf temp 2>/dev/null

    print_success "Cleanup complete"
}

# Stage files intelligently
stage_files() {
    # Stage new commands
    git add commands/* 2>/dev/null

    # Stage new libraries
    git add lib/* 2>/dev/null

    # Stage planning docs
    git add plans/*.md 2>/dev/null

    # Stage CLAUDE.md if modified
    git add CLAUDE.md 2>/dev/null

    # Show what was staged
    local staged=$(git diff --cached --name-only | wc -l | tr -d ' ')
    print_info "Staged $staged files"
}

# Generate commit message
generate_commit_message() {
    local new_commands=$(git diff --cached --name-only | grep "^commands/" | wc -l | tr -d ' ')
    local new_libs=$(git diff --cached --name-only | grep "^lib/" | wc -l | tr -d ' ')
    local new_docs=$(git diff --cached --name-only | grep "^plans/" | wc -l | tr -d ' ')

    local message="chore: session wrap-up"

    if [[ $new_commands -gt 0 ]] || [[ $new_libs -gt 0 ]]; then
        message="feat: session wrap-up"
    fi

    local details=""
    [[ $new_commands -gt 0 ]] && details+="- New commands: $new_commands\n"
    [[ $new_libs -gt 0 ]] && details+="- New libraries: $new_libs\n"
    [[ $new_docs -gt 0 ]] && details+="- Documentation: $new_docs files\n"

    if [[ -n "$details" ]]; then
        message+="\n\n$details"
    fi

    message+="\n\n🤖 Generated with Claude Code\nCo-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

    echo "$message"
}

# Create git commit
create_commit() {
    local message="$1"

    git commit -m "$message"

    if [[ $? -eq 0 ]]; then
        print_success "Commit created: $(git rev-parse --short HEAD)"
    else
        print_error "Commit failed"
        return 1
    fi
}

# Show wrap-up summary
show_summary() {
    echo
    print_header "Wrap-Up Summary"
    echo

    echo "${fg[cyan]}Commit:${reset_color} $(git rev-parse --short HEAD)"
    echo "${fg[cyan]}Branch:${reset_color} $(git branch --show-current)"
    echo

    echo "${fg[cyan]}Files Changed:${reset_color}"
    git diff HEAD~1 --name-only | head -10
    local total=$(git diff HEAD~1 --name-only | wc -l | tr -d ' ')
    if [[ $total -gt 10 ]]; then
        echo "  ... and $((total - 10)) more"
    fi
    echo

    echo "${fg[cyan]}Next Steps:${reset_color}"
    suggest_next_steps
}

# Detect accomplishments
detect_accomplishments() {
    # Analyze staged files to determine what was accomplished
    local accomplishments=""

    # Check for new commands
    if git diff --cached --name-only | grep -q "^commands/"; then
        accomplishments+="- New commands created\n"
    fi

    # Check for new libraries
    if git diff --cached --name-only | grep -q "^lib/"; then
        accomplishments+="- New libraries added\n"
    fi

    # Check for documentation
    if git diff --cached --name-only | grep -q "^plans/"; then
        accomplishments+="- Documentation updated\n"
    fi

    echo "$accomplishments"
}

# Suggest next steps
suggest_next_steps() {
    echo "1. Review commit: git log -1"
    echo "2. Push to remote: git push origin $(git branch --show-current)"
    echo "3. Continue working or start new session"
}
```

---

## 🎨 Session Summary Template

```markdown
# Session Wrap-Up - {{DATE}}

> **Session Time:** {{DURATION}}
> **Commit:** {{COMMIT_HASH}}
> **Branch:** {{BRANCH}}

---

## 🎯 Accomplishments

{{ACCOMPLISHMENTS}}

---

## 📊 Changes

### Files Modified
{{FILES_CHANGED}}

### Statistics
- Commands: {{COMMAND_COUNT}}
- Libraries: {{LIBRARY_COUNT}}
- Documentation: {{DOC_COUNT}}
- Lines changed: +{{ADDITIONS}} -{{DELETIONS}}

---

## 📁 Files Created/Modified

{{FILE_LIST}}

---

## 🔄 Next Steps

{{NEXT_STEPS}}

---

**Session End:** {{TIMESTAMP}}
**Status:** ✅ Clean working directory
```

---

## 🎯 Usage Examples

### Example 1: Default Full Wrap-Up

```bash
$ session-wrap

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Session Wrap-Up
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ Updating planning documents...
✓ Created: plans/SESSION_WRAP_UP_2025-12-11.md

ℹ Updating CLAUDE.md...
What should be added to version history?
Detected changes:
  - New commands: session-wrap
  - New libraries: session-manager.sh

Version note (or press Enter to skip): Add session wrap command

✓ Updated CLAUDE.md

ℹ Cleaning up temporary files...
✓ Cleanup complete

ℹ Staging files...
ℹ Staged 5 files

ℹ Creating commit...
✓ Commit created: a3b5c7d

✓ Session wrapped up successfully!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Wrap-Up Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Commit: a3b5c7d
Branch: dev

Files Changed:
  commands/session-wrap
  lib/session-manager.sh
  plans/SESSION_WRAP_UP_2025-12-11.md
  CLAUDE.md

Next Steps:
1. Review commit: git log -1
2. Push to remote: git push origin dev
3. Continue working or start new session
```

---

### Example 2: Quick Checkpoint

```bash
$ session-wrap --quick

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Quick Wrap-Up
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Quick save complete!
```

---

### Example 3: Custom Message

```bash
$ session-wrap --message "feat: implement new research dashboard"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Session Wrap-Up
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ Updating planning documents...
✓ Created: plans/SESSION_WRAP_UP_2025-12-11.md

ℹ Updating CLAUDE.md...
✓ Updated CLAUDE.md

ℹ Staging files...
ℹ Staged 8 files

ℹ Creating commit...
✓ Commit created: b4f6e8a

✓ Session wrapped up successfully!
```

---

### Example 4: Update Only (No Commit)

```bash
$ session-wrap --no-commit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Update Documentation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Documentation updated!
ℹ Run 'git add' and 'git commit' when ready
```

---

## 🔧 Options Summary

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--quick` | `-q` | Quick commit only, skip updates | false |
| `--no-commit` | `-n` | Update docs only, no git commit | false |
| `--message` | `-m` | Custom commit message | auto-generated |
| `--no-cleanup` | - | Skip cleanup of temp files | cleanup enabled |
| `--help` | `-h` | Show help message | - |

---

## 🎯 Alias Suggestions

Add to `.zshrc`:

```bash
# Session management aliases
alias wrap='session-wrap'              # Quick alias
alias qwrap='session-wrap --quick'     # Quick wrap
alias checkpoint='session-wrap --quick' # Checkpoint alias
```

---

## 📋 Implementation Checklist

### Phase 1: Basic Command
- [ ] Create `commands/session-wrap`
- [ ] Implement basic git commit functionality
- [ ] Add help documentation
- [ ] Test on existing project

### Phase 2: Planning Document Updates
- [ ] Create `lib/session-manager.sh`
- [ ] Implement `update_session_summary()`
- [ ] Create session summary template
- [ ] Test summary generation

### Phase 3: CLAUDE.md Updates
- [ ] Implement `update_knowledge()`
- [ ] Add version detection logic
- [ ] Test CLAUDE.md updates

### Phase 4: Cleanup & Polish
- [ ] Implement temp file cleanup
- [ ] Add intelligent file staging
- [ ] Create commit message generator
- [ ] Add wrap-up summary display

### Phase 5: Testing & Documentation
- [ ] Test all options
- [ ] Create user guide
- [ ] Add to main CLAUDE.md
- [ ] Update install.sh if needed

---

## 🎓 Benefits

### For Users
1. ✅ **Consistent workflow** - Same process every time
2. ✅ **Less to remember** - Automated documentation
3. ✅ **Better git history** - Consistent commit messages
4. ✅ **Clean workspace** - Automatic cleanup
5. ✅ **Time savings** - One command instead of 5-10 steps

### For Projects
1. ✅ **Better documentation** - Session summaries always created
2. ✅ **Knowledge preservation** - CLAUDE.md always updated
3. ✅ **Clean commits** - Consistent format
4. ✅ **Easy handoffs** - Clear session boundaries
5. ✅ **Audit trail** - Session history in plans/

---

## 🤔 Open Questions

1. **Should we auto-push?**
   - Pro: Complete workflow
   - Con: User might not want to push yet
   - **Recommendation:** Add `--push` flag but don't default

2. **Should we update version number?**
   - Pro: Automatic versioning
   - Con: Not every wrap-up is a release
   - **Recommendation:** Manual versioning, just update history

3. **Should we create todos for next session?**
   - Pro: Continuity between sessions
   - Con: Might be premature
   - **Recommendation:** Add as optional feature later

4. **Should we integrate with research dashboard?**
   - Pro: Update research project status
   - Con: Scope creep
   - **Recommendation:** Future enhancement

---

## 🎯 Recommendation

**Implement:** `session-wrap` with all features

**Phase 1 (Now):**
- Basic command structure
- Git commit functionality
- Session summary creation
- CLAUDE.md updates

**Phase 2 (Later):**
- Advanced commit message generation
- Cleanup improvements
- Research integration
- Todo generation

**Aliases:**
- `wrap` → `session-wrap`
- `checkpoint` → `session-wrap --quick`

---

**Next Step:** Review design, get approval, start implementation

