-------------------------
-- Init default: ----
-------------------------
-- Set the colorscheme
vim.cmd 'colorscheme one'

-- Set the statusline colorscheme
_G.statuslinecolors = {
  bg =      '#292D38',
  fg =      '#bbc2cf',
  yellow =  '#DCDCAA',
  cyan =    '#4EC9B0',
  green =   '#608B4E',
  orange =  '#FF8800',
  violet =  '#C586C0',
  magenta = '#D16D9E',
  blue =    '#569CD6',
  red =     '#D16969',
}
require 'statuslines_settings'

-- Source the main config
require 'config'

