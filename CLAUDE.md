# Dotfiles

Personal dotfiles repo. Automates setting up a dev environment on macOS (workstation) or Linux (server).

## Setup Profiles

`scripts/setup.sh` prompts to choose a profile (or use `--workstation` / `--server` flags):

- **Workstation**: All 8 steps — Homebrew, packages, zsh, runtimes, dotfiles, macOS defaults, post-install, AI tools
- **Server**: Steps 3 + 5 only — zsh/oh-my-zsh setup and dotfile linking (no Homebrew)

## Directory Layout

- `scripts/` — Numbered setup scripts (`01-prerequisites.sh` through `08-ai-tools.sh`), run by `setup.sh`
- `zsh/.zshrc` — Shell config (oh-my-zsh, plugins, conditional modern tool aliases)
- `git/.gitconfig` — Git config (stowed to `~/.gitconfig`)
- `configs/aliases`, `configs/exports` — Shell aliases and env vars (stowed to `~/aliases`, `~/exports`)
- `Brewfile` — Homebrew packages and casks
- `ai-config/` — Shared AI tool config (source of truth for commands, agents, rules)
- `claude/.claude/` — Claude Code settings (stowed to `~/.claude`, symlinks to `ai-config/`)
- `cursor/`, `codex/` — Generated configs for Cursor and Codex (built by `08-ai-tools.sh`)

## Conventions

- All scripts use `set -euo pipefail` and the shared color/logging helpers (`log`, `warn`, `error`)
- Scripts are idempotent — safe to re-run
- Dotfile linking uses `stow` when available, falls back to manual `ln -sf` symlinks
- `.zshrc` aliases for modern tools (eza, bat, rg, fd) are conditional — only activate if the tool is installed
- AI config edits go in `ai-config/`, then `scripts/sync-ai-config.sh` propagates to Cursor/Codex (Claude uses symlinks directly)

## Testing Changes

- Run individual scripts directly: `./scripts/03-shell.sh`, `./scripts/05-dotfiles.sh`, etc.
- After modifying `.zshrc`, aliases, or exports: `source ~/.zshrc`
- After modifying AI config: run `ai-sync` or `./scripts/sync-ai-config.sh`
