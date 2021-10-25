-------------------------
-- Init alternative: ----
-------------------------
-- Enable syntax and set the colorscheme
vim.o.background = 'light'
vim.cmd 'colorscheme one'

-- Set the statusline colorscheme
_G.statuslinecolors = {
  bg2 =     '#f0f0f0',
  fg =      '#282c34',
  yellow =  '#d19a66',
  cyan =    '#56b6c2',
  green =   '#98c379',
  orange =  '#c18401',
  purple =  '#C586C0',
  yellow2 = '#c678dd',
  blue =    '#61afef',
  red =     '#e06c75',
}

vim.cmd 'highlight StatusLine guifg=#282c34 guibg=#f0f0f0'
vim.cmd 'highlight StatusLineNC guifg=#282c34 guibg=#f0f0f0'

require 'statuslines_settings'

-- Source the main config
require 'config'
