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

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script is designed for macOS only"
    exit 1
fi

log "Installing prerequisites..."

# Xcode Command Line Tools
log "Installing Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install || true
    warn "Xcode Command Line Tools installation started. Please complete it in the popup window."
    until xcode-select -p >/dev/null 2>&1; do 
        sleep 5
    done
    log "Xcode Command Line Tools installed"
else
    log "Xcode Command Line Tools already installed"
fi

# Homebrew
log "Setting up Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    log "Homebrew installed"
else
    log "Homebrew already installed"
fi

# Ensure Homebrew is in PATH
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || echo true)"
eval "$(/usr/local/bin/brew shellenv 2>/dev/null || echo true)"

log "Prerequisites installation complete!"
