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

log "Applying macOS defaults..."

# macOS defaults
defaults write com.apple.dock autohide -bool true
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

killall Dock >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true

log "macOS defaults applied!"
