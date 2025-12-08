# ZDOTDIR Setup & Advanced Optimization

This guide covers setting up a professional ZDOTDIR configuration with antidote + Oh My Zsh optimization, following 2025 best practices.

---

## What is ZDOTDIR?

**ZDOTDIR** is an environment variable that tells Zsh where to find its configuration files. Instead of cluttering your home directory with 13+ zsh dotfiles, ZDOTDIR lets you organize everything in one clean location.

### Benefits

- ✅ **Clean home directory** - Only 1 file (`~/.zshenv`) instead of 13+
- ✅ **Better organization** - All zsh configs in one place
- ✅ **XDG-compliant** - Follows modern configuration standards
- ✅ **Easier backups** - Just backup `~/.config/zsh/`
- ✅ **Easier management** - Everything grouped logically

---

## Architecture Overview

```
~/
├── .zshenv                   # ONLY file in home (sets ZDOTDIR)
│
└── .config/zsh/              # ALL zsh configuration (ZDOTDIR)
    ├── .zshrc               # Main configuration
    ├── .zsh_plugins.txt     # Antidote plugin list
    ├── .p10k.zsh           # Powerlevel10k theme
    ├── conf.d/             # Modular configs (optional)
    ├── functions/          # Lazy-loaded functions (optional)
    └── completions/        # Custom completions (optional)
```

---

## Installation

### Step 1: Create ZDOTDIR Structure

```bash
# Create directory structure
mkdir -p ~/.config/zsh/{conf.d,functions,completions}
```

### Step 2: Create ~/.zshenv

Create `~/.zshenv` in your home directory (this is the ONLY file that stays in home):

```bash
# ~/.zshenv
# ============================================
# ZDOTDIR CONFIGURATION
# ============================================

export ZDOTDIR="$HOME/.config/zsh"

# ============================================
# HOMEBREW INITIALIZATION
# ============================================
# Initialize Homebrew before .zshrc runs

if [[ -f /opt/homebrew/bin/brew ]]; then
  # Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  # Intel Mac
  eval "$(/usr/local/bin/brew shellenv)"
fi
```

### Step 3: Move Existing Configs

```bash
# Backup first!
cp ~/.zshrc ~/.zshrc.backup
cp ~/.zsh_plugins.txt ~/.zsh_plugins.txt.backup

# Move to ZDOTDIR
mv ~/.zshrc ~/.config/zsh/.zshrc
mv ~/.zsh_plugins.txt ~/.config/zsh/.zsh_plugins.txt
mv ~/.p10k.zsh ~/.config/zsh/.p10k.zsh  # if using Powerlevel10k
```

### Step 4: Update Paths in .zshrc

Update any hardcoded paths in your `.zshrc`:

```bash
# OLD
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
antidote load ~/.zsh_plugins.txt

# NEW
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt
```

---

## Optimal Antidote + Oh My Zsh Configuration

Based on [official use-omz documentation](https://github.com/getantidote/use-omz) and 2025 best practices.

### Recommended .zsh_plugins.txt

```bash
# ~/.config/zsh/.zsh_plugins.txt

# ============================================
# THEME
# ============================================
romkatv/powerlevel10k

# ============================================
# OH MY ZSH CORE (Recommended Order!)
# ============================================
# 1. use-omz handles OMZ dependencies
getantidote/use-omz

# 2. Load OMZ library for stability (recommended!)
# This avoids risk of future OMZ breakage
ohmyzsh/ohmyzsh path:lib

# ============================================
# OMZ PLUGINS
# ============================================
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/docker kind:defer
ohmyzsh/ohmyzsh path:plugins/colored-man-pages
# ... add more as needed

# ============================================
# COMMUNITY PLUGINS
# ============================================
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
```

### Key Points

1. **Load order matters:**
   - `use-omz` FIRST
   - `ohmyzsh/ohmyzsh path:lib` SECOND
   - Then all other plugins

2. **Don't manually run compinit** - `use-omz` + `path:lib` handles it automatically

3. **Use `kind:defer`** for plugins you don't need immediately

---

## Optimal .zshrc Configuration

```bash
# ~/.config/zsh/.zshrc

# ============================================
# POWERLEVEL10K INSTANT PROMPT
# ============================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# ANTIDOTE PLUGIN MANAGER
# ============================================
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Fix for OMZ async prompt regression (2024/2025)
zstyle ':omz:alpha:lib:git' async-prompt no

# Load plugins from ZDOTDIR
antidote load $ZDOTDIR/.zsh_plugins.txt

# ============================================
# POWERLEVEL10K CUSTOMIZATION
# ============================================
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# ============================================
# YOUR CUSTOM CONFIGURATION
# ============================================
# ... rest of your config
```

---

## Performance Optimizations

### 1. use-omz + lib Approach

**Recommended** (most stable):
```bash
getantidote/use-omz
ohmyzsh/ohmyzsh path:lib
```

**Benefits:**
- Official integration
- Lazy library loading
- Better caching
- Optimized completions
- Future-proof against OMZ changes

### 2. Lazy Loading with `kind:defer`

Defer loading of plugins you don't need immediately:

```bash
ohmyzsh/ohmyzsh path:plugins/docker kind:defer
ohmyzsh/ohmyzsh path:plugins/kubectl kind:defer
ohmyzsh/ohmyzsh path:plugins/terraform kind:defer
```

### 3. Avoid Common Mistakes

❌ **DON'T:**
- Load `use-omz` twice (check end of file!)
- Manually run `compinit` (use-omz handles it)
- Load `ohmyzsh/ohmyzsh path:lib` before `use-omz`

✅ **DO:**
- Load `use-omz` FIRST
- Load `path:lib` SECOND
- Let use-omz manage compinit
- Use `kind:defer` for slow plugins

---

## Modular Configuration (Optional)

For even better organization, split your `.zshrc` into modules:

### Structure

```
~/.config/zsh/
├── .zshrc              # Main file (loads modules)
├── .zsh_plugins.txt
├── .p10k.zsh
└── conf.d/
    ├── 01-environment.zsh
    ├── 02-aliases.zsh
    ├── 03-functions.zsh
    ├── 04-keybindings.zsh
    └── 05-integrations.zsh
```

### Load in .zshrc

```bash
# Load modular configs
for config in $ZDOTDIR/conf.d/*.zsh; do
  source "$config"
done
```

### Example Module

```bash
# ~/.config/zsh/conf.d/01-environment.zsh

# R Package Development
export R_PACKAGES_DIR="$HOME/projects/r-packages"
export QUARTO_DIR="$HOME/projects/quarto"

# Editor
export EDITOR="vim"
export VISUAL="vim"
```

---

## Lazy-Loaded Functions

For functions you don't use every session, use lazy loading:

### 1. Create function file

```bash
# ~/.config/zsh/functions/myfunction
my_heavy_function() {
  # Expensive operation here
  echo "This loads only when called!"
}
```

### 2. Enable autoload in .zshrc

```bash
# Add to fpath
fpath=($ZDOTDIR/functions $fpath)

# Autoload all functions
autoload -Uz $ZDOTDIR/functions/*
```

Now `my_heavy_function` only loads when you actually call it!

---

## Update Commands

### With ZDOTDIR + antidote

```bash
# Update all plugins (including OMZ)
antidote update

# Update only OMZ
antidote update ohmyzsh/ohmyzsh

# List loaded plugins
antidote list
```

### OLD (Don't use anymore)

```bash
# ❌ Don't use this anymore
omz update
```

With antidote managing OMZ, use `antidote update` instead!

---

## Troubleshooting

### Issue: Plugins not loading

**Check:** Is `.zshrc` being sourced?
```bash
echo $ZDOTDIR
# Should show: /Users/yourname/.config/zsh
```

**Fix:** Make sure `~/.zshenv` exists and sets ZDOTDIR

### Issue: Homebrew not found

**Check:** Is Homebrew initialized in `.zshenv`?
```bash
which brew
# Should show: /opt/homebrew/bin/brew (Apple Silicon)
```

**Fix:** Add Homebrew initialization to `~/.zshenv` (see Step 2 above)

### Issue: Completions not working

**Check:** Are you using the recommended setup?
```bash
antidote list | grep "use-omz"
antidote list | grep "path:lib"
```

**Fix:** Make sure you have:
1. `getantidote/use-omz` (FIRST)
2. `ohmyzsh/ohmyzsh path:lib` (SECOND)
3. NO manual `compinit` in `.zshrc`

### Issue: Slow shell startup

**Profile your startup:**
```bash
time zsh -i -c exit
```

**Typical results:**
- Good: 0.2-0.5s
- Acceptable: 0.5-1.0s
- Needs optimization: >1.0s

**Fixes:**
- Add `kind:defer` to more plugins
- Remove unused plugins
- Check for slow `.zshrc` commands

---

## Verification

After setup, verify everything works:

```bash
# 1. Check ZDOTDIR
echo $ZDOTDIR
# Should show: /Users/yourname/.config/zsh

# 2. Check Homebrew
which brew
# Should show path to brew

# 3. Check antidote
type antidote
# Should show it's a function

# 4. Check plugins loaded
antidote list | wc -l
# Should show number of plugins

# 5. Check git aliases (from OMZ)
alias | grep gst
# Should show: gst='git status'

# 6. Benchmark performance
time zsh -i -c exit
# Should be fast (<0.5s)
```

---

## References

- [antidote documentation](https://antidote.sh/)
- [use-omz official repo](https://github.com/getantidote/use-omz)
- [Oh My Zsh discussions](https://github.com/mattmc3/antidote/discussions/70)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

---

## Summary

**ZDOTDIR + antidote + use-omz + OMZ lib** is the recommended setup for 2025:

✅ Clean home directory (1 file vs 13+)
✅ Professional organization
✅ Optimal performance
✅ Following best practices
✅ Future-proof configuration

This setup gives you a fast, maintainable, and professional Zsh environment!
