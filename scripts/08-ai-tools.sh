#!/usr/bin/env bash
set -euo pipefail

echo "🤖 Setting up AI coding tool configurations..."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
AI_CONFIG_DIR="$DOTFILES_DIR/ai-config"

# ============================================
# Ensure shared ai-config structure exists
# ============================================
mkdir -p "$AI_CONFIG_DIR"/{commands,agents,rules,prompts}

# ============================================
# Claude Code
# ============================================
setup_claude() {
    echo "  Setting up Claude Code..."

    CLAUDE_DIR="$HOME/.claude"
    CLAUDE_DOTFILES="$DOTFILES_DIR/claude/.claude"

    # Check for existing backups and warn
    existing_backups=$(ls -d "$HOME/.claude.backup."* 2>/dev/null | wc -l)
    if [ "$existing_backups" -gt 0 ]; then
        echo "    ⚠️  Found $existing_backups existing backup(s) at ~/.claude.backup.*"
        echo "    Consider cleaning up old backups: rm -rf ~/.claude.backup.*"
    fi

    # Backup existing if not stow-managed
    if [ -d "$CLAUDE_DIR" ] && [ ! -L "$CLAUDE_DIR" ]; then
        backup_dir="$CLAUDE_DIR.backup.$(date +%Y%m%d-%H%M%S)"
        echo "    Backing up existing ~/.claude to $backup_dir"
        mv "$CLAUDE_DIR" "$backup_dir"
    fi

    # Ensure claude dotfiles directory exists
    mkdir -p "$CLAUDE_DOTFILES"

    # Create symlinks from claude/.claude to shared ai-config
    # Remove existing if they exist
    rm -f "$CLAUDE_DOTFILES/commands" 2>/dev/null || true
    rm -f "$CLAUDE_DOTFILES/agents" 2>/dev/null || true

    # Create relative symlinks to shared content
    ln -s "../../ai-config/commands" "$CLAUDE_DOTFILES/commands"
    ln -s "../../ai-config/agents" "$CLAUDE_DOTFILES/agents"

    # Stow claude config to home directory
    cd "$DOTFILES_DIR"
    stow -v --target="$HOME" claude

    # Create local settings file for machine-specific overrides if it doesn't exist
    if [ ! -f "$CLAUDE_DIR/settings.local.json" ]; then
        echo "    Creating settings.local.json for machine-specific config..."
        cat > "$CLAUDE_DIR/settings.local.json" << 'EOF'
{
  "_comment": "Machine-specific Claude Code settings. This file is gitignored.",
  "_example_work_context": "Set CLAUDE_WORK_CONTEXT to 'linear' or 'openspec' to override auto-detection",
  "env": {},
  "mcpServers": {}
}
EOF
    fi

    echo "    ✅ Claude Code configured"
}

# ============================================
# Cursor
# ============================================
setup_cursor() {
    echo "  Setting up Cursor..."

    CURSOR_DOTFILES="$DOTFILES_DIR/cursor"
    mkdir -p "$CURSOR_DOTFILES"

    # Generate .cursorrules from shared rules
    CURSORRULES="$CURSOR_DOTFILES/.cursorrules"

    cat > "$CURSORRULES" << 'EOF'
# Cursor Rules
# Auto-generated from ~/dotfiles/ai-config/rules/
# Edit source files there and run ~/dotfiles/scripts/sync-ai-config.sh

EOF

    # Append all rule files
    for rulefile in "$AI_CONFIG_DIR/rules/"*.md; do
        if [ -f "$rulefile" ]; then
            echo "# === $(basename "$rulefile") ===" >> "$CURSORRULES"
            cat "$rulefile" >> "$CURSORRULES"
            echo "" >> "$CURSORRULES"
        fi
    done

    # Append agent definitions as additional context
    echo "# === Agent Guidelines ===" >> "$CURSORRULES"
    for agentfile in "$AI_CONFIG_DIR/agents/"*.md; do
        if [ -f "$agentfile" ]; then
            cat "$agentfile" >> "$CURSORRULES"
            echo "" >> "$CURSORRULES"
        fi
    done

    # Stow to home directory
    cd "$DOTFILES_DIR"
    stow -v --target="$HOME" cursor 2>/dev/null || true

    echo "    ✅ Cursor configured"
}

# ============================================
# Codex (OpenAI)
# ============================================
setup_codex() {
    echo "  Setting up Codex..."

    CODEX_DOTFILES="$DOTFILES_DIR/codex"
    mkdir -p "$CODEX_DOTFILES"

    # Generate AGENTS.md from shared agents
    AGENTS_MD="$CODEX_DOTFILES/AGENTS.md"

    cat > "$AGENTS_MD" << 'EOF'
# Codex Agent Configuration
# Auto-generated from ~/dotfiles/ai-config/
# Edit source files there and run ~/dotfiles/scripts/sync-ai-config.sh

EOF

    # Append shared agent definitions
    for agentfile in "$AI_CONFIG_DIR/agents/"*.md; do
        if [ -f "$agentfile" ]; then
            echo "## $(basename "$agentfile" .md)" >> "$AGENTS_MD"
            echo "" >> "$AGENTS_MD"
            cat "$agentfile" >> "$AGENTS_MD"
            echo "" >> "$AGENTS_MD"
            echo "---" >> "$AGENTS_MD"
            echo "" >> "$AGENTS_MD"
        fi
    done

    # Append rules
    echo "# Coding Standards" >> "$AGENTS_MD"
    echo "" >> "$AGENTS_MD"
    for rulefile in "$AI_CONFIG_DIR/rules/"*.md; do
        if [ -f "$rulefile" ]; then
            cat "$rulefile" >> "$AGENTS_MD"
            echo "" >> "$AGENTS_MD"
        fi
    done

    echo "    ✅ Codex configured"
}

# ============================================
# Main
# ============================================

setup_claude
setup_cursor
setup_codex

echo ""
echo "✅ AI tool configurations complete!"
echo ""
echo "📁 Shared config location: ~/dotfiles/ai-config/"
echo "   - commands/  → Slash commands (edit here, used by Claude)"
echo "   - agents/    → Agent definitions (used by all tools)"
echo "   - rules/     → Coding standards (used by Cursor, Codex)"
echo ""
echo "🔧 Tool-specific locations:"
echo "   - Claude: ~/.claude/ (symlinked via stow)"
echo "   - Cursor: ~/.cursorrules (generated)"
echo "   - Codex:  ~/dotfiles/codex/AGENTS.md (generated)"
echo ""
echo "📝 Next steps:"
echo "   1. Add machine-specific config to ~/.claude/settings.local.json"
echo "   2. Restart Claude Code to pick up new commands"
echo "   3. Try: /impl-summary, /review-pr 123, /address-feedback 123"
echo ""
echo "🔄 After editing ai-config/, run: ~/dotfiles/scripts/sync-ai-config.sh"
