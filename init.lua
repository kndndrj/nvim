-----------------------
-- Basic Config: ------
-----------------------
-- Split defaults
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable break indent
vim.opt.breakindent = true

-- Display line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- break text with gq at 100 characters
vim.opt.textwidth = 100

-- Enable mouse
vim.opt.mouse = "a"

-- Rows below the statusline
vim.opt.cmdheight = 1
-- Don't display mode (shown in statusline)
vim.opt.showmode = false

-- Shorter updatetime
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Save undo history
vim.opt.undofile = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Tab (key) settings
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- any combination of 'wq' works
vim.cmd(":command! WQ wq")
vim.cmd(":command! Wq wq")
vim.cmd(":command! Wqa wqa")
vim.cmd(":command! W w")
vim.cmd(":command! Q q")

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end,
})

-- filetype fixes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.groff" },
  callback = function()
    vim.opt.filetype = "groff"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Jenkinsfile" },
  callback = function()
    vim.opt.filetype = "groovy"
  end,
})

-----------------------
-- Key Bindings: ------
-----------------------

-- Map leader to space
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Binding options
local map_options = { noremap = true, silent = true }

-- <leader>Escape key functions
vim.keymap.set("n", "<leader><esc>", ":cclose<CR>", map_options)

-- Cycle quickfix lists
vim.keymap.set("n", "<leader>j", ":cnext<CR>", map_options)
vim.keymap.set("n", "<leader>k", ":cprev<CR>", map_options)
vim.keymap.set("n", "<leader>o", ":copen<CR>", map_options)

-- Fixes for the US layout
vim.keymap.set("", "š", "[", map_options)
vim.keymap.set("", "đ", "]", map_options)
vim.keymap.set("", "Š", "{", map_options)
vim.keymap.set("", "Đ", "}", map_options)

-- Search highlighted text
vim.keymap.set("v", "//", 'y/\\V<C-R>=escape(@","/")<CR><CR>', map_options)

-- Esc to quit terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", map_options)

-- Clipboard
-- y
vim.keymap.set("", "<leader>y", '"+y', map_options)
vim.keymap.set("n", "<leader>yy", '"+yy', map_options)
vim.keymap.set("n", "<leader>Y", '"+y$', map_options)
vim.keymap.set("n", "<leader>yi", '"+yi', map_options)
vim.keymap.set("n", "<leader>ya", '"+ya', map_options)
-- d
vim.keymap.set("v", "<leader>d", '"+d', map_options)
vim.keymap.set("n", "<leader>dd", '"+dd', map_options)
vim.keymap.set("n", "<leader>D", '"+d$', map_options)
vim.keymap.set("n", "<leader>di", '"+di', map_options)
vim.keymap.set("n", "<leader>da", '"+da', map_options)
-- p
vim.keymap.set("", "<leader>p", '"+p', map_options)

-- Source plugins
require("plugins").configure()
