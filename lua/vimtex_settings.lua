-------------------------
-- Vimtex Settings: -----
-------------------------
local g = vim.g

-- Vimtex Flavor
g.tex_flavor = 'latex'

-- PDF viewer
g.vimtex_view_method = 'zathura'
g.vimtex_view_general_viewer = 'zathura'

-- Ignore annoying warnings
g.vimtex_quickfix_ignore_filters = '[ \
    "Underfull \\hbox (badness [0-9]*) in ", \
    "Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ", \
    "Package hyperref Warning: Token not allowed in a PDF string", \
    "Package typearea Warning: Bad type area settings!" \
    ]'
