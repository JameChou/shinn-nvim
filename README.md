# Shinn NeoVim Configuration

## Introduction

This configuration based on [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project and add some plugins that I used.

## Installation

### Install Neovim

```bash
# On ArchLinux system.
# The follow command will install the latest neovim.
sudo pacman -S neovim

git clone https://github.com/JameChou/shinn-nvim ~/.config/nvim/
```

Start neovim, the plugins will auto install by lazyvim.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
- `Yarn` 、`npm` etc.
