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

log "Installing packages from Brewfile..."

# Ensure Homebrew is in PATH
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || echo true)"
eval "$(/usr/local/bin/brew shellenv 2>/dev/null || echo true)"

# Install packages from Brewfile
brew update
brew bundle --file="$(dirname "$0")/../Brewfile" || true

log "Package installation complete!"
