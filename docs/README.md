# Documentation Index

Complete documentation for zsh-claude-workflow system.

---

## 📚 Quick Links

### Getting Started
- [Main README](../README.md) - Project overview and features
- [Quick Start Guide](getting-started/quickstart.md) - Get up and running in 5 minutes
- [Command Reference](COMMANDS.md) - Detailed command documentation
- [Testing Guide](TESTING.md) - Test your configuration

### Plugin Management
- **[Migration Guide](migration/ANTIDOTE_MIGRATION.md)** - Oh My Zsh → Antidote migration
- **[Optimization Guide](optimization/PLUGIN_OPTIMIZATION.md)** - Plugin performance tuning
- **[Comparison](optimization/PLUGIN_COMPARISON.md)** - Before/after analysis

---

## 📂 Documentation Structure

```
docs/
├── README.md                      # This file
├── COMMANDS.md                    # Command reference
├── TESTING.md                     # Testing guide
├── migration/
│   └── ANTIDOTE_MIGRATION.md     # Antidote migration guide
└── optimization/
    ├── PLUGIN_OPTIMIZATION.md     # Plugin optimization guide
    └── PLUGIN_COMPARISON.md       # Before/after comparison
```

---

## 🎯 By Topic

### Context Management
**What**: Smart project detection and Claude integration

**Documentation**:
- [Main README](../README.md) - Overview of context features
- [Command Reference](COMMANDS.md) - proj-type, claude-ctx, etc.
- [Quick Start](getting-started/quickstart.md) - Try it now

**Key Commands**:
```bash
proj-type      # Detect project type
claude-ctx     # Show Claude context
claude-init    # Create CLAUDE.md
```

---

### Plugin Management
**What**: Optimized zsh plugin configuration with antidote

**Documentation**:
- [Migration Guide](migration/ANTIDOTE_MIGRATION.md) - Switch from Oh My Zsh
- [Optimization Guide](optimization/PLUGIN_OPTIMIZATION.md) - Improve performance
- [Comparison](optimization/PLUGIN_COMPARISON.md) - See the benefits

**Key Files**:
- `~/.zsh_plugins.txt` - Your current plugin configuration
- `../templates/zsh_plugins.txt.recommended` - Optimized template

---

### Templates
**What**: CLAUDE.md templates for different project types

**Documentation**:
- [Main README](../README.md#templates) - Template overview

**Available Templates**:
- `../templates/CLAUDE-rpkg.md` - R package template
- `../templates/CLAUDE-quarto.md` - Quarto project template
- `../templates/CLAUDE-research.md` - Research project template
- `../templates/zsh_plugins.txt.recommended` - Optimized plugins

---

## 🚀 Common Tasks

### Install the System
```bash
cd ~/code/zsh-claude-workflow
./install.sh
source ~/.zshrc
```
**Docs**: [Quick Start Guide](getting-started/quickstart.md)

---

### Optimize Plugins
```bash
# Use recommended configuration
cp ~/code/zsh-claude-workflow/templates/zsh_plugins.txt.recommended ~/.zsh_plugins.txt
source ~/.zshrc
```
**Docs**: [Optimization Guide](optimization/PLUGIN_OPTIMIZATION.md)

---

### Create CLAUDE.md for Project
```bash
cd ~/R-packages/active/mypackage
claude-init
```
**Docs**: [Command Reference](COMMANDS.md#claude-init)

---

### Check Project Type
```bash
proj-type
# or shorter:
ptype
```
**Docs**: [Command Reference](COMMANDS.md#proj-type)

---

## 🔧 Configuration

### Main Configuration Files
| File | Purpose | Location |
|------|---------|----------|
| `.zshrc` | Shell configuration | `~/.zshrc` |
| `.zsh_plugins.txt` | Plugin list | `~/.zsh_plugins.txt` |
| `defaults.conf` | zsh-claude-workflow config | `~/code/zsh-claude-workflow/config/defaults.conf` |

### Customization
- **Add plugins**: Edit `~/.zsh_plugins.txt`
- **Customize templates**: Edit files in `../templates/`
- **Add commands**: Create scripts in `../commands/`

---

## 📖 Full Documentation

### Core Documentation
1. **[README.md](../README.md)** - Start here
   - Features overview
   - Installation
   - Quick examples

2. **[Quick Start](getting-started/quickstart.md)** - Hands-on guide
   - Test it out
   - Common workflows
   - Examples

3. **[COMMANDS.md](COMMANDS.md)** - Reference
   - All commands
   - Options and flags
   - Usage examples

### Plugin Management
4. **[ANTIDOTE_MIGRATION.md](migration/ANTIDOTE_MIGRATION.md)**
   - Migration from Oh My Zsh
   - Benefits of antidote
   - How to manage plugins

5. **[PLUGIN_OPTIMIZATION.md](optimization/PLUGIN_OPTIMIZATION.md)**
   - Performance optimization
   - Recommended plugins
   - Lazy loading

6. **[PLUGIN_COMPARISON.md](optimization/PLUGIN_COMPARISON.md)**
   - Before/after analysis
   - Benchmark results
   - Migration paths

---

## 🎓 Learning Path

### New to zsh-claude-workflow?
1. Read [README.md](../README.md) (5 min)
2. Run [Quick Start](getting-started/quickstart.md) (5 min)
3. Try commands in your R packages

### Want to optimize?
1. Read [Plugin Optimization](optimization/PLUGIN_OPTIMIZATION.md) (10 min)
2. Review [Comparison](optimization/PLUGIN_COMPARISON.md) (5 min)
3. Apply optimizations

### Want to customize?
1. Check [Command Reference](COMMANDS.md)
2. Edit templates in `../templates/`
3. Add your own commands

---

## 💡 Tips

1. **Keep docs handy** - Bookmark this page
2. **Use bat to read** - `bat docs/README.md`
3. **Check templates** - Great starting points
4. **Read migrations** - Even if already migrated, has good tips

---

## 🆘 Getting Help

### Quick Reference
```bash
# View any doc with bat
bat ~/code/zsh-claude-workflow/docs/COMMANDS.md

# List all docs
ls ~/code/zsh-claude-workflow/docs/

# View templates
ls ~/code/zsh-claude-workflow/templates/
```

### Common Questions

**Q: How do I add a new plugin?**
A: Edit `~/.zsh_plugins.txt`, add line, run `source ~/.zshrc`
→ See: [Migration Guide](migration/ANTIDOTE_MIGRATION.md#managing-plugins)

**Q: How do I create CLAUDE.md for my project?**
A: Run `claude-init` in your project directory
→ See: [Commands](COMMANDS.md#claude-init)

**Q: How do I optimize my shell startup?**
A: Use recommended plugins with lazy loading
→ See: [Optimization Guide](optimization/PLUGIN_OPTIMIZATION.md)

---

## 📊 Documentation Coverage

| Topic | Coverage | Docs |
|-------|----------|------|
| Installation | ✅ Complete | README, QuickStart |
| Commands | ✅ Complete | COMMANDS.md |
| Plugin Management | ✅ Complete | Migration, Optimization |
| Templates | ✅ Complete | Template files |
| Customization | ✅ Complete | All guides |
| Troubleshooting | ⚠️ Basic | Scattered in guides |

---

**Last Updated**: 2025-12-07
**Version**: 1.0
