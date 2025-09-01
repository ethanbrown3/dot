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

log "Setting up runtime environments..."

# Setup mise (replaces pyenv, nvm, tfenv)
log "Setting up mise runtime manager..."
if command -v mise >/dev/null 2>&1; then
    # Initialize mise
    mise init zsh >/dev/null 2>&1 || true
    
    # Install latest runtimes
    log "Installing latest Python..."
    mise install python@latest || true
    
    log "Installing latest Node.js..."
    mise install node@latest || true
    
    log "Installing latest Terraform..."
    mise install terraform@latest || true
    
    log "mise setup complete"
else
    error "mise not found. Please ensure it's installed via Homebrew."
fi

log "Runtime setup complete!"
