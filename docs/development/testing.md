# Testing Guide

Complete testing guide for zsh-claude-workflow configuration.

---

## Quick Start

### Run All Tests (Recommended)

```bash
cd ~/code/zsh-claude-workflow
source tests/run-all-tests.zsh
```

This runs both structure and runtime tests for complete validation.

### Individual Tests

**Structure Tests** (files, permissions, syntax):
```bash
cd ~/code/zsh-claude-workflow
./tests/test-structure.zsh
```

**Runtime Tests** (aliases, PATH, commands):
```bash
cd ~/code/zsh-claude-workflow
source tests/test-runtime.zsh
```

---

## Test Suite Overview

The test suite is organized into two complementary test scripts:

| Test | File | How to Run | Tests |
|------|------|-----------|-------|
| **Structure** | `tests/test-structure.zsh` | `./tests/test-structure.zsh` | Files exist, executables, syntax |
| **Runtime** | `tests/test-runtime.zsh` | `source tests/test-runtime.zsh` | Aliases work, PATH correct, commands run |
| **Complete** | `tests/run-all-tests.zsh` | `source tests/run-all-tests.zsh` | Both structure + runtime |

---

## Understanding the Tests

### Structure Tests (test-structure.zsh)

**Purpose:** Verify files, permissions, and configuration syntax

**Tests:**
- ✅ .zshrc exists and sources without errors
- ✅ Claude CLI is installed
- ✅ Aliases are DEFINED in .zshrc
- ✅ PATH export is DEFINED in .zshrc
- ✅ All 6 command files exist and are executable
- ✅ All 3 library files exist and are readable
- ✅ All 4 templates exist
- ✅ Plugin configuration exists
- ✅ Documentation files exist
- ✅ Backup files exist

**How it works:**
- Runs in subprocess
- Checks file system and configuration files
- Does NOT test if aliases actually work (subprocess limitation)

**Expected result:** ~100% pass

### Runtime Tests (test-runtime.zsh)

**Purpose:** Verify configuration is loaded and working in your shell

**Tests:**
- ✅ Aliases exist AND have correct values
- ✅ cc='claude' (not 'claude-code')
- ✅ All workflow aliases point to correct commands
- ✅ PATH includes workflow commands directory
- ✅ Commands are accessible via PATH
- ✅ Commands execute successfully

**How it works:**
- Must be SOURCED (not executed)
- Runs in your current shell
- Tests actual runtime behavior

**Expected result:** ~100% pass

---

## Usage Examples

### After Fresh Install

```bash
cd ~/code/zsh-claude-workflow
./install.sh
source ~/.zshrc
source tests/run-all-tests.zsh
```

Expected: Both tests pass (100%)

### After Modifying .zshrc

```bash
# 1. Reload configuration
source ~/.zshrc

# 2. Run runtime tests
source tests/test-runtime.zsh
```

Expected: 100% pass

### Quick Daily Check

```bash
source ~/code/zsh-claude-workflow/tests/test-runtime.zsh
```

Expected: 100% pass

### Debugging Issues

```bash
# 1. Check structure first
cd ~/code/zsh-claude-workflow
./tests/test-structure.zsh

# 2. If structure passes, check runtime
source ~/.zshrc
source tests/test-runtime.zsh

# 3. If runtime still fails, check for errors
zsh -c "source ~/.zshrc" 2>&1 | head -20
```

---

## Common Issues & Solutions

### Issue: "cc alias correct ✗ FAIL"

**Symptom:**
```
cc alias (correct value)                              ✗ FAIL
  Expected: cc='claude'
  Got:      cc='claude-code'
```

**Cause:** Old alias value still loaded in shell

**Solution:**
```bash
source ~/.zshrc
source tests/test-runtime.zsh
```

### Issue: "Alias not defined"

**Symptom:**
```
ptype alias exists                                    ✗ FAIL
```

**Cause:** .zshrc not loaded in current shell

**Solution:**
```bash
source ~/.zshrc
source tests/test-runtime.zsh
```

### Issue: "command not found: proj-type"

**Symptom:**
```
proj-type in PATH                                     ✗ FAIL
```

**Cause:** PATH not updated

**Solution:**
```bash
source ~/.zshrc
echo $PATH | grep zsh-claude-workflow  # Should show the path
```

### Issue: Structure tests pass, runtime tests fail

**Cause:** Configuration is correct in files, but not loaded in your shell

**Solution:** Always `source ~/.zshrc` before running runtime tests

---

## Test Output Guide

### Successful Test Run

```
╔════════════════════════════════════════════════════════════════╗
║              Runtime Configuration Test Suite                  ║
╚════════════════════════════════════════════════════════════════╝

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Claude CLI
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Claude CLI installed                              ✓ PASS
  Claude CLI version check                          ✓ PASS

...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Test Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Total Tests: 23
  Passed:      23
  Failed:      0

  ✓ All runtime tests passed! Configuration is perfect!

  Your aliases are ready to use:
    cc           - Launch Claude
    ccc          - Launch Claude chat
    ptype        - Check project type
    cctx         - Show Claude context
    cinit        - Create CLAUDE.md
```

### Failed Test with Details

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Claude Code Aliases
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  cc alias (correct value)                          ✗ FAIL
    Expected: cc='claude'
    Got:      cc='claude-code'

...

  ⚠ Some tests failed (91% passed)

  Try running: source ~/.zshrc
  Then run this test again: source tests/test-runtime.zsh
```

---

## Integration with Development Workflow

### Before Committing Changes

```bash
source ~/.zshrc
source tests/run-all-tests.zsh
```

Ensure all tests pass before committing.

### After Pulling Updates

```bash
cd ~/code/zsh-claude-workflow
source ~/.zshrc
source tests/run-all-tests.zsh
```

Verify updates didn't break anything.

### When Adding New Commands

```bash
# After creating new command
chmod +x commands/new-command

# Test structure
./tests/test-structure.zsh

# Add alias to .zshrc
echo "alias ncmd='new-command'" >> ~/.zshrc

# Reload and test
source ~/.zshrc
source tests/test-runtime.zsh
```

---

## Test Development

### Adding Structure Tests

Edit `tests/test-structure.zsh`:

```bash
test_my_feature() {
    print_header "My Feature"

    if [[ -f "$HOME/code/zsh-claude-workflow/myfile" ]]; then
        pass "My file exists"
    else
        fail "My file not found"
    fi
}
```

Add to `main()` function.

### Adding Runtime Tests

Edit `tests/test-runtime.zsh`:

```bash
print_header "My Feature"
check "My command works" "my-command --version"
check_alias_value "myalias" "my-command" "myalias → my-command"
```

---

## Continuous Testing

### Daily Workflow

```bash
# Morning check
source ~/code/zsh-claude-workflow/tests/test-runtime.zsh

# After making changes
source ~/.zshrc
source ~/code/zsh-claude-workflow/tests/test-runtime.zsh
```

### Weekly Full Test

```bash
cd ~/code/zsh-claude-workflow
source tests/run-all-tests.zsh
```

---

## Advanced Usage

### Running Specific Test Sections

Structure tests are modular. You can comment out sections in `test-structure.zsh`:

```bash
# Run tests
test_basic_config
test_command_files
# test_documentation  # Comment out if not needed
# test_backups        # Comment out if not needed
```

### Custom Test Scripts

Create your own test script in `tests/`:

```bash
#!/usr/bin/env zsh
# tests/test-custom.zsh

source tests/test-runtime.zsh
# Add your custom tests here
```

---

## Troubleshooting the Tests Themselves

### Test script not found

```bash
cd ~/code/zsh-claude-workflow
ls tests/
# Should show: README.md, run-all-tests.zsh, test-runtime.zsh, test-structure.zsh
```

### Permission denied

```bash
chmod +x ~/code/zsh-claude-workflow/tests/*.zsh
```

### Sourcing doesn't work

Make sure you're using `source`, not `./`:

```bash
# WRONG
./tests/test-runtime.zsh

# CORRECT
source tests/test-runtime.zsh
```

---

## Related Documentation

- [Command Reference](../commands/reference.md) - Command documentation
- [Architecture](architecture.md) - Development architecture
- [Contributing](contributing.md) - How to contribute

---

## Quick Reference

| Task | Command |
|------|---------|
| Run all tests | `source tests/run-all-tests.zsh` |
| Test structure only | `./tests/test-structure.zsh` |
| Test runtime only | `source tests/test-runtime.zsh` |
| Quick daily check | `source tests/test-runtime.zsh` |
| After .zshrc changes | `source ~/.zshrc && source tests/test-runtime.zsh` |
| Debugging | `./tests/test-structure.zsh` then `source tests/test-runtime.zsh` |

---

**Last Updated**: 2025-12-07
**Test Coverage**: Structure (100%), Runtime (100%)
**Status**: Production Ready ✅
