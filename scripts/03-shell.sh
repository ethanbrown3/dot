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

log "Setting up shell environment..."

# Create ~/.zshenv to set ZDOTDIR
ZSHENV_FILE="$HOME/.zshenv"
ZDOTDIR_VALUE="$HOME/dotfiles/zsh"

if [ -f "$ZSHENV_FILE" ]; then
    if grep -q "ZDOTDIR=" "$ZSHENV_FILE"; then
        log ".zshenv already contains ZDOTDIR"
    else
        echo "ZDOTDIR=$ZDOTDIR_VALUE" >> "$ZSHENV_FILE"
        log "Added ZDOTDIR to existing .zshenv"
    fi
else
    echo "ZDOTDIR=$ZDOTDIR_VALUE" > "$ZSHENV_FILE"
    log "Created .zshenv with ZDOTDIR"
fi

# Setup zsh and oh-my-zsh
log "Setting up zsh and oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log "oh-my-zsh installed"
else
    log "oh-my-zsh already installed"
fi

# Install additional zsh plugins
log "Installing zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    log "zsh-autosuggestions installed"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    log "zsh-syntax-highlighting installed"
fi

log "Shell setup complete!"
