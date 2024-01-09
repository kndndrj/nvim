-------------------------
-- Vimtex Settings: -----
-------------------------

local M = {}

function M.configure()
  local g = vim.g

  -- Vimtex Flavor
  g.tex_flavor = "latex"

  -- PDF viewer
  -- g.vimtex_view_method = "zathura"
  -- g.vimtex_view_general_viewer = "zathura"
end

return M
