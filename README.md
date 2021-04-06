# Andrej's NeoVim Config

![alt text](./screenshot.jpg)

## Features

- [Vim One](https://github.com/rakr/vim-one) dark theme with [Lightline](https://github.com/itchyny/lightline.vim) statusbar
- [COC](https://github.com/neoclide/coc.nvim) intellisense with support for different programming languages
- [NERDTree](https://github.com/preservim/nerdtree) with [devicons](https://github.com/ryanoasis/vim-devicons)
- [FZF](https://github.com/junegunn/fzf.vim) file search
- Live preview for Latex ([Vimtex](https://github.com/lervag/vimtex))

## Requirements

Requires [NeoVim 0.5+](https://aur.archlinux.org/packages/neovim-git/)
Before using install the following packages:

- node.js
- npm
- clang
- [bear](https://github.com/rizsotto/Bear) (optional)

## How to use

Put the files in `~/.config/nvim/` and run:

```bash
nvim +PlugInstall
```

Note:
For indentLine plugin to work with json, run this sequence of commands in NeoVim (has to be done only once):

```bash
:e $VIMRUNTIME/syntax/json.vim
:g/if has('conceal')/s//& \&\& 0/
:wq
```

Use nerd font on the terminal for icons on the file tree, I use [this](https://aur.archlinux.org/packages/nerd-fonts-ubuntu-mono/) one from AUR.

## Other

A huge help with setting this up was [this](https://medium.com/better-programming/setting-up-neovim-for-web-development-in-2020-d800de3efacd) blogpost, which I encourage you to check out!
