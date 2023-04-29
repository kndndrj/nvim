-----------------------
-- Init.lua -----------
-----------------------
-- Macros
local cmd = vim.cmd
local g = vim.g
local map = vim.keymap.set
local o = vim.o
local wo = vim.wo

-- dadbod config (doesn't work otherwise)
g.db_ui_execute_on_save = 0
g.db_ui_use_nerd_fonts = 1
g.db_ui_tmp_query_location = "~/.cache/nvim/dadbod-ui/"
g.db_ui_auto_execute_table_helpers = 1

-----------------------
-- Basic Config: ------
-----------------------
o.hidden = true

-- Split defaults
o.splitbelow = true
o.splitright = true

-- Display line numbers
wo.number = true
o.numberwidth = 2

-- Enable mouse
o.mouse = "a"

-- Rows below the statusline
o.cmdheight = 1
-- Cursorline
wo.cursorline = true
-- Don't display mode
o.showmode = false

-- Shorter updatetime
o.updatetime = 250

-- Always show the signcolumn
wo.signcolumn = "yes"

-- Tab (key) settings
o.tabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.smarttab = true

-- Highlight a column to easily maintain line length
wo.colorcolumn = "100"

-- any combination of 'wq' works
cmd(":command! WQ wq")
cmd(":command! Wq wq")
cmd(":command! Wqa wqa")
cmd(":command! W w")
cmd(":command! Q q")

-- Autocommands
cmd('autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}')
cmd("autocmd BufNewFile,BufRead *.groff set filetype=groff")
cmd("autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy")

-----------------------
-- Key Bindings: ------
-----------------------
-- Binding options
local map_options = { noremap = true, silent = true }

-- Map leader to space
g.mapleader = " "

-- <leader>Escape key functions
map("n", "<leader><esc>", ":cclose<CR>", map_options)

-- Cycle quickfix lists
map("n", "<leader>j", ":cnext<CR>", map_options)
map("n", "<leader>k", ":cprev<CR>", map_options)
map("n", "<leader>o", ":copen<CR>", map_options)

-- Cycle buffers
map("n", "<leader>n", ":bnext<CR>", map_options)
map("n", "<leader>N", ":bprev<CR>", map_options)

-- Fixes for the US layout
map("", "š", "[", map_options)
map("", "đ", "]", map_options)
map("", "Š", "{", map_options)
map("", "Đ", "}", map_options)

-- Search highlighted text
map("v", "//", 'y/\\V<C-R>=escape(@","/")<CR><CR>', map_options)

-- Esc to quit terminal
map("t", "<Esc>", "<C-\\><C-n>", map_options)

-- Clipboard
-- y
map("", "<leader>y", '"+y', map_options)
map("n", "<leader>yy", '"+yy', map_options)
map("n", "<leader>Y", '"+y$', map_options)
map("n", "<leader>yi", '"+yi', map_options)
map("n", "<leader>ya", '"+ya', map_options)
-- d
map("v", "<leader>d", '"+d', map_options)
map("n", "<leader>dd", '"+dd', map_options)
map("n", "<leader>D", '"+d$', map_options)
map("n", "<leader>di", '"+di', map_options)
map("n", "<leader>da", '"+da', map_options)
-- p
map("", "<leader>p", '"+p', map_options)

-- Source plugins
require("plugins").configure()
