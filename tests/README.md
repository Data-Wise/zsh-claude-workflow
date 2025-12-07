# Test Suite

Comprehensive testing for zsh-claude-workflow configuration.

---

## Quick Start

### Option 1: Run All Tests (Recommended)

```bash
source tests/run-all-tests.zsh
```

This runs both structure and runtime tests in sequence.

### Option 2: Run Individual Tests

**Structure Tests** (files, syntax, permissions):
```bash
./tests/test-structure.zsh
```

**Runtime Tests** (aliases, PATH):
```bash
source tests/test-runtime.zsh
```

---

## Test Scripts

| Script | How to Run | What It Tests | Pass Rate |
|--------|-----------|---------------|-----------|
| **run-all-tests.zsh** | `source tests/run-all-tests.zsh` | Everything | ~95% |
| **test-structure.zsh** | `./tests/test-structure.zsh` | Files, config syntax | ~100% |
| **test-runtime.zsh** | `source tests/test-runtime.zsh` | Aliases, PATH, commands | ~100% |

---

## Understanding Test Results

### test-structure.zsh

**What it tests:**
- ✅ .zshrc exists and has no syntax errors
- ✅ Claude CLI is installed
- ✅ Aliases are DEFINED in .zshrc
- ✅ PATH export is in .zshrc
- ✅ All command files exist and are executable
- ✅ All library files exist
- ✅ All templates exist
- ✅ Plugin configuration exists
- ✅ Documentation files exist
- ✅ Backups exist

**Expected result:** ~100% pass

**If tests fail:** Check file permissions or missing files

### test-runtime.zsh

**What it tests:**
- ✅ Aliases actually WORK in your shell
- ✅ Alias values are correct (cc='claude' not 'claude-code')
- ✅ PATH includes workflow commands
- ✅ Commands are accessible via PATH
- ✅ Commands execute successfully

**Expected result:** ~100% pass

**If tests fail:** Run `source ~/.zshrc` then test again

### run-all-tests.zsh

Runs both tests and provides overall summary.

**Expected result:** ~95-100% pass

---

## Test Workflows

### After Fresh Install

```bash
cd ~/code/zsh-claude-workflow
source tests/run-all-tests.zsh
```

Expected: Both phases pass

### After Modifying .zshrc

```bash
# 1. Reload config
source ~/.zshrc

# 2. Test
source tests/run-all-tests.zsh
```

Expected: Both phases pass

### Quick Daily Check

```bash
source tests/test-runtime.zsh
```

Expected: 100% pass

### Debugging Configuration Issues

```bash
# 1. Check structure first
./tests/test-structure.zsh

# 2. If structure passes, check runtime
source ~/.zshrc
source tests/test-runtime.zsh

# 3. If runtime fails, check for errors
zsh -c "source ~/.zshrc" 2>&1 | head -20
```

---

## Common Issues

### "cc alias correct ✗ FAIL"

**Problem:** Shell has old `cc='claude-code'` value

**Solution:**
```bash
source ~/.zshrc
source tests/test-runtime.zsh
```

### "Alias not defined"

**Problem:** .zshrc not loaded in current shell

**Solution:**
```bash
source ~/.zshrc
source tests/test-runtime.zsh
```

### "command not found: proj-type"

**Problem:** PATH not updated

**Solution:**
```bash
source ~/.zshrc
which proj-type  # Should show path now
```

### Structure tests pass, runtime tests fail

**Problem:** Configuration correct in files, not loaded in shell

**Solution:** Always `source ~/.zshrc` before runtime tests

---

## Test Development

### Adding New Tests

#### Structure Test

Edit `test-structure.zsh`:

```bash
test_my_feature() {
    print_header "My Feature"

    if [[ -f "$HOME/myfile" ]]; then
        pass "My file exists"
    else
        fail "My file not found"
    fi
}
```

Add to `main()`:
```bash
test_my_feature
```

#### Runtime Test

Edit `test-runtime.zsh`:

```bash
print_header "My Feature"
check "My command works" "my-command --version"
check_alias_value "myalias" "my-command" "myalias → my-command"
```

---

## Test Output Examples

### All Tests Pass

```
╔════════════════════════════════════════════════════════════════╗
║                     Final Test Summary                         ║
╚════════════════════════════════════════════════════════════════╝

  ✓ Structure Tests: PASSED
  ✓ Runtime Tests:   PASSED

  ╔════════════════════════════════════════════════════════════╗
  ║  ✓ ALL TESTS PASSED!                                      ║
  ║    Your zsh-claude-workflow is fully configured!          ║
  ╚════════════════════════════════════════════════════════════╝
```

### Some Failures

```
╔════════════════════════════════════════════════════════════════╗
║                     Final Test Summary                         ║
╚════════════════════════════════════════════════════════════════╝

  ✓ Structure Tests: PASSED
  ✗ Runtime Tests:   FAILED

  ╔════════════════════════════════════════════════════════════╗
  ║  ⚠ SOME TESTS FAILED                                      ║
  ║    Review the output above for details                    ║
  ╚════════════════════════════════════════════════════════════╝

  Common fix for runtime failures:
    1. Run: source ~/.zshrc
    2. Run: source tests/run-all-tests.zsh
```

---

## Best Practices

1. **Always source .zshrc before runtime tests**
2. **Use run-all-tests.zsh for comprehensive validation**
3. **Run tests after any .zshrc changes**
4. **Check test output for specific failure details**
5. **Structure tests first, runtime tests second**

---

## File Organization

```
tests/
├── README.md                # This file
├── run-all-tests.zsh        # Run all tests (source this)
├── test-structure.zsh       # Structure tests (execute this)
└── test-runtime.zsh         # Runtime tests (source this)
```

---

## Integration

These tests are designed to work with:
- Fresh installations
- Configuration changes
- Plugin updates
- Command modifications
- Template changes

Run tests regularly to ensure configuration integrity!

---

**Last Updated**: 2025-12-07
