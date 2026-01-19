#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Syncing AI config across tools..."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Re-run the setup (it's idempotent)
"$DOTFILES_DIR/scripts/08-ai-tools.sh"

echo ""
echo "✅ Sync complete! Restart AI tools to pick up changes."
