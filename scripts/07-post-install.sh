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
    /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish --no-zsh >/dev/null 2>&1 || true
    log "fzf keybindings installed"
fi

# VS Code extensions
if command -v code >/dev/null 2>&1; then
    log "Installing VS Code extensions..."
    while read -r ext; do
        code --install-extension "$ext" || true
    done <<'EOF'
esbenp.prettier-vscode
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
dbaeumer.vscode-eslint
ms-vscode.vscode-typescript-next
GitHub.copilot
ms-azuretools.vscode-docker
HashiCorp.terraform
EOF
    log "VS Code extensions installed"
fi

# Start Docker
open -ga "Docker" || true
log "Docker started"

log "Post-install tasks complete!"
