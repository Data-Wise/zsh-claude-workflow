# Plugin Optimization Guide

**Date**: 2025-12-07

This guide explains the optimized plugin configuration and recommendations.

---

## 🎯 Optimization Strategy

### 1. **Lazy Loading** (`kind:defer`)
Plugins that are not needed immediately on shell startup are lazy-loaded:
- Loads only when first used
- Reduces startup time
- No functionality loss

### 2. **Remove Redundant Plugins**
- `common-aliases` - Removed to avoid conflicts with your extensive custom aliases
- `vscode` - Removed (you primarily use Claude Code)

### 3. **Add High-Value Plugins**
Plugins that significantly enhance your workflow

---

## 📦 Recommended New Plugins

### **1. FZF Integration** ⭐⭐⭐⭐⭐
**Why**: Supercharges fuzzy finding across your system

**Installation**:
```bash
brew install fzf
```

**What it adds**:
- `Ctrl+R` - Fuzzy search command history (MUCH better than default)
- `Ctrl+T` - Fuzzy find files in current directory
- `Alt+C` - Fuzzy find and cd into directories
- Works with your existing `fd` and `bat` for previews

**Example usage**:
```bash
# Press Ctrl+R and type "git push"
# See all matching commands with fuzzy search

# Press Ctrl+T in ~/R-packages
# Fuzzy search all files with preview

# Press Alt+C
# Fuzzy search directories and jump to them
```

**Plugin line**:
```
ohmyzsh/ohmyzsh path:plugins/fzf
```

---

### **2. You Should Use** ⭐⭐⭐⭐
**Why**: Reminds you to use aliases you've already defined

**What it does**:
```bash
$ git status
You should use: gst

$ git add .
You should use: ga .

$ proj-type
# (no reminder - you used the alias!)
```

**Plugin line**:
```
MichaelAquilina/zsh-you-should-use
```

---

### **3. Fast Syntax Highlighting** ⭐⭐⭐⭐ (Optional Alternative)
**Why**: Faster than `zsh-syntax-highlighting` with more features

**Trade-off**: More features but slightly more complex
- Highlights commands in real-time
- Shows if command exists before you run it
- Highlights paths, options, strings differently

**Plugin line** (replaces zsh-syntax-highlighting):
```
zdharma-continuum/fast-syntax-highlighting
```

---

### **4. Zsh Abbreviations** ⭐⭐⭐ (Optional)
**Why**: Fish-like text expansion

**What it does**:
```bash
# Define abbreviations
abbr gp="git push"
abbr rpd="cd ~/R-packages/active"

# Type 'gp' and press Space → expands to 'git push'
# You see full command before running
```

**Plugin line**:
```
olets/zsh-abbr
```

**Benefit**: Unlike aliases, you see what actually runs (great for learning/safety)

---

### **5. Tmux Integration** ⭐⭐⭐ (Optional)
**Why**: If you use tmux, better integration

**What it adds**:
- Auto-start tmux on terminal launch
- Aliases for tmux commands
- Session management helpers

**Plugin line**:
```
ohmyzsh/ohmyzsh path:plugins/tmux kind:defer
```

---

## 🚀 Performance Optimizations

### Current Setup (Before Optimization)
- **Plugins loaded**: 20+
- **Load time**: ~0.5-1s
- **All plugins**: Loaded eagerly

### Optimized Setup (After)
- **Plugins loaded**: 18-22 (with new additions)
- **Load time**: ~0.3-0.5s (estimated)
- **Heavy plugins**: Lazy loaded

### Plugins with `kind:defer`
```
ohmyzsh/ohmyzsh path:plugins/github kind:defer
ohmyzsh/ohmyzsh path:plugins/docker kind:defer
ohmyzsh/ohmyzsh path:plugins/web-search kind:defer
```

These load only when you first use their commands.

---

## 📊 Plugin Analysis

### **Keep - High Usage**
✅ git, github (essential for R package development)
✅ extract (frequently archive .tar.gz files)
✅ sudo (ESC ESC is muscle memory)
✅ z (directory jumping)
✅ dirhistory (Alt+Left/Right navigation)
✅ copybuffer, copypath, copyfile (clipboard ops)

### **Remove - Low Value**
❌ common-aliases (conflicts with your custom aliases)
❌ vscode (not your primary editor)

### **Optimize - Lazy Load**
⏱️ docker (only when using Docker)
⏱️ github (only when using gh CLI)
⏱️ web-search (not frequently used)

### **Add - High Value for Your Workflow**
➕ fzf (essential for fuzzy finding)
➕ you-should-use (helps remember 400+ aliases)
➕ Optional: fast-syntax-highlighting, zsh-abbr

---

## 🔧 How to Apply Optimizations

### Option 1: Apply All Recommendations

```bash
# Backup current config
cp ~/.zsh_plugins.txt ~/.zsh_plugins.txt.backup

# Use optimized version
cp ~/.zsh_plugins.txt.optimized ~/.zsh_plugins.txt

# Install FZF if not already installed
brew install fzf

# Reload shell
source ~/.zshrc
```

### Option 2: Apply Selectively

Edit `~/.zsh_plugins.txt` and:

1. **Add FZF** (highly recommended):
```
ohmyzsh/ohmyzsh path:plugins/fzf
```

2. **Add You Should Use**:
```
MichaelAquilina/zsh-you-should-use
```

3. **Add lazy loading** to existing plugins:
```
# Before
ohmyzsh/ohmyzsh path:plugins/docker

# After
ohmyzsh/ohmyzsh path:plugins/docker kind:defer
```

4. **Remove common-aliases**:
```
# Remove or comment this line
# ohmyzsh/ohmyzsh path:plugins/common-aliases
```

Then reload:
```bash
source ~/.zshrc
```

---

## 🎨 Customization for Your Workflow

### R Package Development Focus

Consider creating a custom plugin for R workflows:

**~/.zsh_plugins.txt**:
```
# Your custom R package plugin (create this)
# $HOME/.zsh/custom-plugins/r-workflow
```

**~/.zsh/custom-plugins/r-workflow/r-workflow.plugin.zsh**:
```bash
# Quick R package navigation
alias rp='cd ~/R-packages/active'
alias rps='cd ~/R-packages/stable'

# Workflow shortcuts
alias rpdev='rdev && rpkgcommit'

# FZF R package selector
rp-select() {
    local selected=$(find ~/R-packages/active -maxdepth 1 -type d | fzf)
    [[ -n "$selected" ]] && cd "$selected"
}
```

---

## 📈 Expected Benefits

After optimization:

1. **Faster Startup** (20-40% improvement)
   - Lazy loading heavy plugins
   - Removed unused plugins

2. **Better Fuzzy Finding**
   - FZF integration
   - Works with your existing fd/bat setup

3. **Alias Awareness**
   - You-should-use reminds you of aliases
   - Helps with your 400+ aliases

4. **Cleaner Config**
   - No redundant plugins
   - Clear organization

5. **Maintained Functionality**
   - All existing features preserved
   - Lazy-loaded plugins work when needed

---

## 🧪 Testing Optimization

### Measure Startup Time

**Before optimization**:
```bash
time zsh -i -c exit
```

**After optimization**:
```bash
cp ~/.zsh_plugins.txt.optimized ~/.zsh_plugins.txt
source ~/.zshrc
time zsh -i -c exit
```

Compare the times!

### Verify Plugins Loaded

```bash
# Test git aliases
gst

# Test FZF (if installed)
# Press Ctrl+R

# Test lazy-loaded plugins
docker ps  # First use loads docker plugin
gh --version  # First use loads github plugin
```

---

## 🎯 Recommended Configuration

For your specific workflow (R packages + Claude Code + Git):

**Essential Plugins**:
- Powerlevel10k theme
- Git, GitHub
- z (directory navigation)
- FZF (fuzzy finding) ⭐
- zsh-autosuggestions, zsh-syntax-highlighting
- alias-tips, you-should-use ⭐

**Optional/Lazy Load**:
- Docker (kind:defer)
- Web-search (kind:defer)
- Tmux (if you use it)

---

## 📚 Further Reading

- **Antidote Performance**: https://getantidote.github.io/usage#deferred-loading
- **FZF Wiki**: https://github.com/junegunn/fzf/wiki
- **Plugin Recommendations**: https://github.com/unixorn/awesome-zsh-plugins

---

## 💡 Pro Tips

1. **Benchmark regularly** - Run `time zsh -i -c exit` monthly
2. **Audit plugins** - Remove what you don't use
3. **Use lazy loading** - Add `kind:defer` to heavy plugins
4. **Create custom plugins** - For project-specific workflows
5. **Update plugins** - Run `antidote update` monthly

---

**Ready to optimize?** Start with FZF + you-should-use for immediate impact!
