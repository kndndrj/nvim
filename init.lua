require "plugins"
require "telescope_config"
require "indentline"
require "lsp_settings"
require "lspconfig"
require "statuslines_settings"

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
options = { noremap=true, silent=true }

-- Map leader to space
vim.g.mapleader = ' '

-- Basic
map('n', '<leader><esc>', ':nohlsearch<cr>', options)

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

-- Bufferline
map('n', '<leader>n', ':BufferLineCycleNext<CR>', options)
map('n', '<leader>N', ':BufferLineCyclePrev<CR>', options)

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

-- Language server
-- references
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', options)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', options)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', options)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
-- workspace
map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', options)
map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', options)
map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', options)
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
-- diagnostics
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', options)
map('n', 'dN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
map('n', 'dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)
map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', options)
-- formatting
map("n", "<leader>h", "<cmd>lua vim.lsp.buf.formatting()<CR>", options)
map("v", "<leader>h", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", options)

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
o.numberwidth = 2

-- Enable mouse
o.mouse = 'a'

-- Rows below the statusline
o.cmdheight = 1
-- Cursorline
wo.cursorline = true
-- Don't display mode
o.showmode = false

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

-- Autocommands
cmd "autocmd BufWinEnter * :DetectIndent"
cmd "autocmd BufWritePost plugins.lua PackerCompile"

-- Git signs setup
require'gitsigns'.setup()
