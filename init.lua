require "plugins"
require "telescope_config"
require "indentline"
require "lsp_settings"

-- Macros
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-----------------------
-- Key Bindings: ------
-----------------------

-- Binding options
options = { noremap = true }

-- Map leader to space
vim.g.mapleader = ' '

-- Basic
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>N', ':bprev<cr>', options)

-- Use alt+hjkl to move between panels
map('n', '<A-h>', '<C-w>h', options)
map('n', '<A-j>', '<C-w>j', options)
map('n', '<A-k>', '<C-w>k', options)
map('n', '<A-l>', '<C-w>l', options)

-- Copying:
-- Primary
map('n', '<Leader>Y', '"*y', options)
map('n', '<Leader>P', '"*p', options)
-- Clipboard
map('n', '<Leader>y', '"+y  ', options)
map('n', '<Leader>p', '"+p  ', options)
map('n', '<Leader>yy', '"+yy', options)

-- Alt + top keys for tab switching
map('n', '<A-q>', '1gt ', options)
map('n', '<A-w>', '2gt ', options)
map('n', '<A-e>', '3gt ', options)
map('n', '<A-r>', '4gt ', options)
map('n', '<A-t>', '5gt ', options)
map('n', '<A-z>', '6gt ', options)
map('n', '<A-u>', '7gt ', options)
map('n', '<A-i>', '8gt ', options)
map('n', '<A-o>', '9gt ', options)
map('n', '<A-p>', '10gt', options)

-- Telescope
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], options)
map("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], options)
map("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], options)
map("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], options)
map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], options)

-- Autocomplete
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- Autopairs
map("i", "<CR>", "v:lua.completions()", {expr = true})

-----------------------
-- Basic Config: ------
-----------------------

o.hidden = true
o.ignorecase = true

-- Split defaults
o.splitbelow = true
o.splitright = true

-- Enable colors
o.termguicolors = true

-- Display relative line numbers
wo.number = true
wo.relativenumber = true
o.numberwidth = 2

-- Enable mouse
o.mouse = 'a'

-- Rows below the statusline and cursorline
o.cmdheight = 2
wo.cursorline = true

-- Shorter updatetime
o.updatetime = 250

-- Tab (key) settings
bo.tabstop = 8
bo.expandtab = true
bo.shiftwidth = 4
bo.softtabstop = 0
o.smarttab = true

-- Highlight column 100 to easily maintain line length
wo.colorcolumn='80'

-- Autocomplete menu
o.completeopt = "menuone,noselect"

-- enable syntax and set the colorscheme
cmd "syntax enable"
cmd "syntax on"
cmd "colorscheme one"

cmd "autocmd BufWinEnter * :DetectIndent"
cmd "autocmd BufWritePost plugins.lua PackerCompile"
