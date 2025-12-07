#!/usr/bin/env zsh
# Installation script for zsh-claude-workflow

set -e

# Colors
autoload -U colors && colors

# Print functions
print_success() { echo "${fg[green]}✓${reset_color} $1" }
print_error() { echo "${fg[red]}✗${reset_color} $1" >&2 }
print_info() { echo "${fg[blue]}ℹ${reset_color} $1" }
print_header() {
    echo ""
    echo "${fg[cyan]}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset_color}"
    echo "${fg[cyan]}$1${reset_color}"
    echo "${fg[cyan]}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset_color}"
}

# Get installation directory
INSTALL_DIR="${0:A:h}"
ZSHRC="$HOME/.zshrc"

print_header "🚀 Installing zsh-claude-workflow"

# Check if .zshrc exists
if [[ ! -f "$ZSHRC" ]]; then
    print_error ".zshrc not found at $ZSHRC"
    exit 1
fi

print_info "Installation directory: $INSTALL_DIR"
echo ""

# Make commands executable
print_info "Making commands executable..."
chmod +x "$INSTALL_DIR/commands"/*
print_success "Commands are now executable"

# Check if already installed
if grep -q "zsh-claude-workflow" "$ZSHRC"; then
    print_info "zsh-claude-workflow is already in .zshrc"
    echo ""
    read -q "REPLY?Reinstall/update? (y/n) "
    echo ""
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi

    # Remove old configuration
    print_info "Removing old configuration..."
    # Use a temporary file to avoid issues with sed on macOS
    grep -v "zsh-claude-workflow" "$ZSHRC" > "${ZSHRC}.tmp"
    mv "${ZSHRC}.tmp" "$ZSHRC"
fi

# Add to .zshrc
print_info "Adding to .zshrc..."

cat >> "$ZSHRC" << EOF

# ============================================
# ZSH-CLAUDE WORKFLOW
# ============================================

# Add zsh-claude-workflow commands to PATH
export PATH="\$HOME/code/zsh-claude-workflow/commands:\$PATH"

# Aliases for quick access
alias ptype='proj-type'
alias pinfo='proj-info'
alias cctx='claude-ctx'
alias cinit='claude-init'
alias cshow='claude-show'
alias pclaude='proj-claude'

EOF

print_success "Added to .zshrc"
echo ""

# Create config directory if needed
if [[ ! -d "$INSTALL_DIR/config" ]]; then
    mkdir -p "$INSTALL_DIR/config"
fi

# Create default config if it doesn't exist
if [[ ! -f "$INSTALL_DIR/config/defaults.conf" ]]; then
    print_info "Creating default configuration..."
    cat > "$INSTALL_DIR/config/defaults.conf" << 'EOF'
# Default configuration for zsh-claude-workflow

# Project directories to scan
PROJECT_DIRS=(
    "$HOME/R-packages/active"
    "$HOME/R-packages/stable"
    "$HOME/quarto-projects"
    "$HOME/dev-tools"
)

# Cloud storage locations
CLOUD_STORAGE=(
    "$HOME/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/My Drive/R-packages-stable"
    "$HOME/Library/CloudStorage/GoogleDrive-dtofighi@gmail.com/My Drive/research"
)

# Default editor for CLAUDE.md
CLAUDE_EDITOR="${EDITOR:-vim}"

# Tree depth for project structure display
DEFAULT_TREE_DEPTH=2
EOF
    print_success "Created defaults.conf"
fi

echo ""
print_header "✅ Installation Complete!"
echo ""
print_info "Available commands:"
echo "  ${fg[yellow]}proj-type${reset_color}   - Detect project type"
echo "  ${fg[yellow]}proj-info${reset_color}   - Show project information"
echo "  ${fg[yellow]}claude-ctx${reset_color}  - Show Claude context"
echo "  ${fg[yellow]}claude-init${reset_color} - Create CLAUDE.md"
echo "  ${fg[yellow]}claude-show${reset_color} - Display CLAUDE.md"
echo "  ${fg[yellow]}proj-claude${reset_color} - Open Claude Code with context"
echo ""
print_info "Aliases available:"
echo "  ${fg[yellow]}ptype${reset_color}, ${fg[yellow]}pinfo${reset_color}, ${fg[yellow]}cctx${reset_color}, ${fg[yellow]}cinit${reset_color}, ${fg[yellow]}cshow${reset_color}, ${fg[yellow]}pclaude${reset_color}"
echo ""
print_info "Reload your shell to start using:"
echo "  ${fg[yellow]}source ~/.zshrc${reset_color}"
echo ""
print_info "Or open a new terminal window"
echo ""
