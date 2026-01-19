# Dotfiles – Mac Development Environment Setup

A comprehensive dotfiles repository that automates setting up a modern development environment on macOS. This repo installs all essential tools, configures runtimes, and applies developer-friendly defaults. The setup is **idempotent** - you can re-run it safely at any time.

---

## 🚀 Quick Start

### Fresh Mac Setup
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ethanbrown3/dotfiles/main/scripts/setup.sh)"
```

### After Cloning
```bash
git clone https://github.com/ethanbrown3/dotfiles.git ~/dotfiles
cd dotfiles
./scripts/setup.sh
```

---

## 📁 Repository Structure

```
dotfiles/
├── scripts/                          # Setup automation
│   ├── setup.sh                      # Main orchestrator
│   ├── 01-prerequisites.sh           # Xcode CLI tools, Homebrew
│   ├── 02-packages.sh                # Install packages from Brewfile
│   ├── 03-shell.sh                   # zsh, oh-my-zsh, plugins
│   ├── 04-runtimes.sh                # mise, Python, Node.js, Terraform
│   ├── 05-dotfiles.sh                # Link dotfiles with stow
│   ├── 06-macos-defaults.sh          # macOS system preferences
│   ├── 07-post-install.sh            # fzf, VS Code extensions, Docker
│   ├── 08-ai-tools.sh                # AI coding tools setup
│   ├── sync-ai-config.sh             # Sync shared AI config to tools
│   ├── fetch-pr-feedback.sh          # Fetch PR review feedback
│   └── post-review.sh                # Post review to PR
├── ai-config/                        # Shared AI tool config
│   ├── commands/                     # Slash commands (Claude Code)
│   ├── agents/                       # Agent definitions (all tools)
│   ├── rules/                        # Coding standards (Cursor, Codex)
│   └── prompts/                      # Reusable prompt snippets
├── claude/                           # Claude Code (stowed to ~/.claude)
│   └── .claude/
│       ├── settings.json             # Permissions and settings
│       ├── commands -> ai-config     # Symlink to shared commands
│       └── agents -> ai-config       # Symlink to shared agents
├── cursor/                           # Cursor rules
│   └── .cursorrules                  # Generated from ai-config/rules
├── codex/                            # OpenAI Codex
│   └── AGENTS.md                     # Generated from ai-config
├── zsh/
│   └── .zshrc                        # Main shell configuration
├── git/
│   └── .gitconfig                    # Git configuration
├── configs/
│   ├── aliases                       # Custom shell aliases
│   └── exports                       # Environment variables
├── Brewfile                          # Homebrew formulae and casks
└── README.md                         # This file
```

---

## 🛠 What Gets Installed

### **Runtimes & Package Managers**
- **[mise](https://mise.jdx.dev/)**: Unified runtime manager (replaces pyenv/nvm/tfenv)
- **[Python](https://www.python.org/)**: Latest version via mise
- **[Node.js](https://nodejs.org/)**: Latest version via mise  
- **[Terraform](https://www.terraform.io/)**: Latest version via mise
- **[AWS CLI](https://docs.aws.amazon.com/cli/)**: AWS service interaction

### **Shell & Environment**
- **[zsh](https://www.zsh.org/)** with [oh-my-zsh](https://ohmyz.sh/)
- **[Homebrew](https://brew.sh/)** package manager
- **Modern CLI tools**:
  - `git` - version control
  - `gh` - GitHub CLI
  - `fzf` - fuzzy finder
  - `ripgrep` - fast text search
  - `bat` - syntax-highlighting cat
  - `eza` - modern ls replacement
  - `fd` - fast find replacement
  - `jq` - JSON processor
  - `stow` - dotfile symlink manager
  - `tmux` - terminal multiplexer
  - `neovim` - modern Vim

### **Applications**
- **[Cursor](https://cursor.sh/)** - AI-first code editor
- **[Warp](https://www.warp.dev/)** - GPU-accelerated terminal
- **[VS Code](https://code.visualstudio.com/)** - code editor
- **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** - containers
- **[Google Chrome](https://www.google.com/chrome/)** - browser
- **[1Password](https://1password.com/)** - password manager

### **Fonts**
- **[JetBrains Mono Nerd Font](https://www.nerdfonts.com/)** - developer font

---

## ⚙️ Configuration Files

### **Shell Configuration (`zsh/.zshrc`)**
- Modern zsh setup with oh-my-zsh
- Plugins: git, aws, terraform, docker, autosuggestions, syntax highlighting, fzf
- Automatic sourcing of `~/.configs/aliases` and `~/.configs/exports`
- Modern tool aliases (bat, eza, fd, ripgrep)
- Enhanced history and completion settings

### **Git Configuration (`git/.gitconfig`)**
- User configuration
- Useful aliases (lg, lga, etc.)
- Credential caching
- Pull with rebase enabled

### **VS Code Settings (`vscode/User/settings.json`)**
- JetBrains Mono Nerd Font
- Dark theme with material icons
- Git integration settings
- Editor preferences (tab size, rulers, etc.)

### **Custom Aliases (`configs/aliases`)**
- Navigation shortcuts (.., ..., etc.)
- Git shortcuts (gs, gp, gpl)
- Development tools (mise, docker)
- System utilities (f, path, etc.)

### **Environment Variables (`configs/exports`)**
- Editor settings (nvim)
- Development environment variables
- Path additions

---

## 🔧 How to Modify

### **Adding Packages**
Edit `Brewfile` to add/remove Homebrew packages:
```bash
# Add a new package
echo 'brew "package-name"' >> Brewfile

# Refresh Brewfile from current system
brew bundle dump --force
```

### **Adding Aliases**
Use the helper function or edit manually:
```bash
# Quick add
addalias myalias 'mycommand'

# Manual edit
editaliases
```

### **Adding Environment Variables**
Use the helper function or edit manually:
```bash
# Quick add
addexport MY_VAR "value"

# Manual edit
editexports
```

### **Modifying Shell Configuration**
Edit `zsh/.zshrc` to change:
- oh-my-zsh theme
- plugins
- key bindings
- shell options

### **Modifying Git Configuration**
Edit `git/.gitconfig` to change:
- user information
- aliases
- default behaviors

### **Modifying VS Code Settings**
Edit `vscode/User/settings.json` to customize:
- theme and appearance
- editor behavior
- extensions settings

### **Adding New Config Files**
1. Create the file in the appropriate directory
2. Update `scripts/05-dotfiles.sh` to include it in stow
3. Run `./scripts/05-dotfiles.sh` to link it

---

## 🔄 Running Setup

### **Full Setup**
```bash
./scripts/setup.sh
```

### **Individual Steps**
```bash
./scripts/01-prerequisites.sh  # Just Homebrew
./scripts/02-packages.sh        # Just packages
./scripts/03-shell.sh          # Just shell setup
./scripts/04-runtimes.sh       # Just runtimes
./scripts/05-dotfiles.sh       # Just dotfile linking
./scripts/06-macos-defaults.sh # Just macOS settings
./scripts/07-post-install.sh   # Just post-install tasks
```

### **Applying Changes**
After modifying any config files:
```bash
./scripts/05-dotfiles.sh  # Re-link dotfiles
source ~/.zshrc           # Reload shell config
```

---

## 🛠 Helper Functions

After setup, these functions are available:

```bash
# Add new aliases and exports
addalias <name> <command>     # Add alias
addexport <name> <value>      # Add environment variable

# Edit configs
editaliases                   # Edit aliases file
editexports                   # Edit exports file
zshconfig                     # Edit zsh config
```

---

## 🧩 Features

- **mise integration**: Unified runtime management
- **Modern zsh config**: Autosuggestions, syntax highlighting, useful aliases
- **macOS defaults**: Dock autohide, faster key repeat, organized screenshots
- **VS Code extensions**: Pre-installs popular development extensions
- **fzf integration**: Fuzzy finder with keybindings
- **Modular setup**: Easy to customize individual components
- **Idempotent**: Safe to re-run anytime

---

## 📝 Notes

- Uses **mise** instead of pyenv/nvm/tfenv for cleaner runtime management
- All modern CLI tools are aliased for better UX
- Docker starts automatically after installation
- Screenshots are saved to `~/Screenshots` instead of Desktop
- Local overrides can be added to `~/.zshrc.local` (not tracked in git)

---

## ✅ After Setup

1. Log in to applications (Docker, VS Code, 1Password, etc.)
2. Configure Git user info: `git config --global user.name "Your Name"`
3. Add machine-specific settings to `~/.zshrc.local`
4. Customize VS Code extensions as needed
5. Enjoy your new development environment! 🚀

---

## 🤖 AI Coding Tools Configuration

This repo manages configuration for AI coding assistants (Claude Code, Cursor, Codex).

### Architecture

```
ai-config/           # Shared source of truth
├── commands/        # Slash commands (Claude Code)
├── agents/          # Agent definitions (all tools)
├── rules/           # Coding standards (Cursor, Codex)
└── prompts/         # Reusable prompt snippets

claude/              # Claude Code specific (stowed to ~/.claude)
cursor/              # Cursor rules (stowed to ~/.cursorrules)
codex/               # OpenAI Codex (AGENTS.md)
```

### Slash Commands (Claude Code)

| Command | Description |
|---------|-------------|
| `/impl-summary` | Generate implementation summary for PR description |
| `/review-pr <number>` | Focused code review with noise filtering |
| `/address-feedback <number>` | Fetch and address PR review comments |
| `/log-decision` | Record architectural decision in CLAUDE.md |
| `/sync-config` | Commit AI config changes to dotfiles |

### Context Detection

Commands auto-detect your project management context:

- **OpenSpec**: Detected if `.openspec/`, `openspec.yaml`, or `openspec.json` exists
- **Linear**: Detected if branch matches `[A-Z]+-[0-9]+` pattern or `.linear/` exists
- **Override**: Set `CLAUDE_WORK_CONTEXT=linear` or `=openspec` in `~/.claude/settings.local.json`

### Editing Commands

Commands are symlinked, so edits flow back to dotfiles:

```bash
# Edit a command (changes go to dotfiles repo)
vim ~/.claude/commands/impl-summary.md

# Check what changed
ai-status

# Commit changes
ai-commit

# Or use Claude Code
/sync-config
```

### Adding New Commands

1. Create file in `~/dotfiles/ai-config/commands/your-command.md`
2. Run `ai-sync` (or restart Claude Code)
3. Use `/your-command` in Claude Code

### Machine-Specific Config

Add API keys and local overrides to `~/.claude/settings.local.json` (gitignored):

```json
{
  "env": {
    "CLAUDE_WORK_CONTEXT": "linear"
  },
  "mcpServers": {
    "your-mcp-server": { }
  }
}
```

### Shell Aliases

```bash
cc              # Launch Claude Code
ccr             # Resume last Claude Code session
ai-status       # Show changed AI config files
ai-diff         # Show AI config diffs
ai-commit       # Commit AI config changes
ai-sync         # Sync shared config to all tools
fetch-feedback  # Fetch PR review comments
post-review     # Post review to PR
```

### Multi-Tool Sync

Edit shared content in `ai-config/`, then sync to all tools:

```bash
# Edit shared rules
vim ~/dotfiles/ai-config/rules/coding-standards.md

# Sync to Cursor and Codex (Claude uses symlinks, no sync needed)
ai-sync
```
