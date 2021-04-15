-- Source the main config
require 'config'

-- Set the colorscheme
vim.cmd 'colorscheme NeoSolarized'

-- Set the statusline colorscheme
_G.statuslinecolors = {
  bg =      '#EEE8D5',
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
