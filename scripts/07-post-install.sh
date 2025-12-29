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

log "Running post-install tasks..."

# fzf bindings
if command -v fzf >/dev/null 2>&1; then
    if [ ! -f "$HOME/.fzf.zsh" ]; then
        /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish >/dev/null 2>&1 || true
        log "fzf keybindings installed"
    else
        log "fzf keybindings already installed"
    fi
fi

# VS Code extensions
if command -v code >/dev/null 2>&1; then
    log "Installing VS Code extensions..."
    INSTALLED_EXTENSIONS=$(code --list-extensions 2>/dev/null || echo "")
    while read -r ext; do
        if ! echo "$INSTALLED_EXTENSIONS" | grep -qi "^${ext}$"; then
            code --install-extension "$ext" || true
            log "Installed $ext"
        fi
    done <<'EOF'
esbenp.prettier-vscode
ms-python.python
ms-python.vscode-pylance
dbaeumer.vscode-eslint
ms-vscode.vscode-typescript-next
ms-azuretools.vscode-docker
EOF
    log "VS Code extensions check complete"
fi

# Start Docker if not running
if ! pgrep -x "Docker" >/dev/null 2>&1; then
    open -ga "Docker" || true
    log "Docker started"
else
    log "Docker already running"
fi

log "Post-install tasks complete!"
