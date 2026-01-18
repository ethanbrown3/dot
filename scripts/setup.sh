#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() { printf "${GREEN}[+] %s${NC}\n" "$*"; }
warn() { printf "${YELLOW}[!] %s${NC}\n" "$*"; }
error() { printf "${RED}[ERROR] %s${NC}\n" "$*"; }

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log "🚀 Starting development environment setup..."

# Run all setup scripts in order
log "Step 1/8: Installing prerequisites..."
"$SCRIPT_DIR/01-prerequisites.sh"

log "Step 2/8: Installing packages..."
"$SCRIPT_DIR/02-packages.sh"

log "Step 3/8: Setting up shell environment..."
"$SCRIPT_DIR/03-shell.sh"

log "Step 4/8: Setting up runtime environments..."
"$SCRIPT_DIR/04-runtimes.sh"

log "Step 5/8: Setting up dotfiles..."
"$SCRIPT_DIR/05-dotfiles.sh"

log "Step 6/8: Applying macOS defaults..."
"$SCRIPT_DIR/06-macos-defaults.sh"

log "Step 7/8: Running post-install tasks..."
"$SCRIPT_DIR/07-post-install.sh"

log "Step 8/8: Setting up AI coding tools..."
"$SCRIPT_DIR/08-ai-tools.sh"

log "🎉 Setup complete! 🚀"
log "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
