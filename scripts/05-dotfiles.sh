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

log "Setting up dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "$0")/.."; pwd)"

# Setup dotfiles with stow, fall back to manual symlinks
if command -v stow >/dev/null 2>&1; then
    pushd "$DOTFILES_DIR" >/dev/null
    stow -v --target="$HOME" zsh git configs || true
    popd >/dev/null
    log "Dotfiles linked via stow"
else
    warn "stow not found, creating symlinks manually..."

    # zsh — ZDOTDIR is set in ~/.zshenv by 03-shell.sh, but link .zshrc to
    # the zsh directory so ZDOTDIR can find it
    mkdir -p "$HOME/dotfiles/zsh" 2>/dev/null || true
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/dotfiles/zsh/.zshrc"

    # git
    ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

    # configs (aliases and exports live at ~/aliases, ~/exports)
    ln -sf "$DOTFILES_DIR/configs/aliases" "$HOME/aliases"
    ln -sf "$DOTFILES_DIR/configs/exports" "$HOME/exports"

    log "Dotfiles linked manually"
fi

log "Dotfiles setup complete!"
