-------------------------
-- Init alternative: ----
-------------------------
-- Enable syntax and set the colorscheme
vim.o.background = 'light'
vim.cmd 'colorscheme solarized8_flat'
vim.cmd 'syntax enable'
vim.cmd 'syntax on'

-- Set the statusline colorscheme
_G.statuslinecolors = {
  bg =      '#FDF6E3',
  fg =      '#073642',
  yellow =  '#B58900',
  cyan =    '#2AA198',
  green =   '#859900',
  orange =  '#CB4B16',
  violet =  '#6C71C4',
  magenta = '#D33682',
  blue =    '#268BD2',
  red =     '#DC322F',
}
require 'statuslines_settings'

-- Source the main config
require 'config'
