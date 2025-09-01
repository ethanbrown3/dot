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

# Setup dotfiles with stow
if command -v stow >/dev/null 2>&1; then
    pushd "$(cd "$(dirname "$0")/.."; pwd)" >/dev/null
    stow -v --target="$HOME" zsh git configs || true
    popd >/dev/null
    log "Dotfiles linked"
else
    warn "stow not found, skipping dotfile linking"
fi

log "Dotfiles setup complete!"
