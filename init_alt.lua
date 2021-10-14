-------------------------
-- Init alternative: ----
-------------------------
-- Enable syntax and set the colorscheme
vim.o.background = 'light'
vim.cmd 'colorscheme one'

-- Set the statusline colorscheme
_G.statuslinecolors = {
  bg =      '#f0f0f0',
  fg =      '#282c34',
  yellow =  '#d19a66',
  cyan =    '#56b6c2',
  green =   '#98c379',
  orange =  '#c18401',
  violet =  '#C586C0',
  magenta = '#c678dd',
  blue =    '#61afef',
  red =     '#e06c75',
}
require 'statuslines_settings'

-- Source the main config
require 'config'
