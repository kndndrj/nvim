-------------------------
-- Init default: ----
-------------------------
-- Set the colorscheme
vim.cmd 'syntax enable'
vim.cmd 'syntax on'
require'onedark'.setup {
  function_style = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
}

local colors = require'onedark.colors'.setup()

-- Set the statusline colorscheme
_G.statuslinecolors = colors

require 'statuslines_settings'

-- Source the main config
require 'config'
