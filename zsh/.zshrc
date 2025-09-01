# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  aws
  terraform
  docker
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || true)"
eval "$(/usr/local/bin/brew shellenv 2>/dev/null || true)"

# mise (replaces pyenv, nvm, tfenv)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Source additional configs
if [[ -f "$HOME/exports" ]]; then
  source "$HOME/exports"
fi

if [[ -f "$HOME/aliases" ]]; then
  source "$HOME/aliases"
fi

# Modern tool aliases
alias ll='eza -la'
alias la='eza -a'
alias l='eza -l'
alias cat='bat'
alias grep='rg'
alias find='fd'

# Better history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Better completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
compinit

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete

# Environment variables are now in ~/.configs/exports

# Local overrides
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
