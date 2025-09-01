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
│   └── 07-post-install.sh            # fzf, VS Code extensions, Docker
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
