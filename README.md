# My NeoVim Config in Lua

## Plugins

- [Packer](https://github.com/wbthomason/packer.nvim) for managing plugins.
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim) with [Detect Indent](https://github.com/ciaranm/detectindent) clearer display of code.
- [Vim One](https://github.com/rakr/vim-one) dark or [Solarized](https://github.com/lifepillar/vim-solarized8) color schemes with [Galaxy Line](https://github.com/glepnir/galaxyline.nvim) for both themes.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - the best fuzzy-finder!
- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) for better syntax highlighting.
- Native LSP ([nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)) with [nvim-compe](https://github.com/hrsh7th/nvim-compe) for completion and [LSP icons](https://github.com/onsails/lspkind-nvim).
- [Auto pairs](https://github.com/windwp/nvim-autopairs) - finds pairs like (), ""...
- [Snippet manager](https://github.com/windwp/nvim-autopairs).
- [Devicons](https://github.com/kyazdani42/nvim-web-devicons).
- [Bufferline](https://github.com/akinsho/nvim-bufferline.lua) - shows open buffers.
- [Scrollbar](https://github.com/dstein64/nvim-scrollview) and [smooth scrolling](https://github.com/karb94/neoscroll.nvim).
- [Vimtex](https://github.com/lervag/vimtex) Live preview for Latex.
- [Git symbols](https://github.com/lewis6991/gitsigns.nvim).

## Requirements

Requires NeoVim 0.5+ - if you are on Arch, use [this](https://aur.archlinux.org/packages/neovim-git/) package form AUR.
Before using, clone the Packer repository (updates itself afterwards):
```sh
git clone https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## How to use

Put the files in `~/.config/nvim/`, open `nvim` and run:

```vim
:PackerInstall
```

Use nerd font on the terminal for icons on the file tree, I use [this](https://aur.archlinux.org/packages/nerd-fonts-fira-code/) one from AUR.
