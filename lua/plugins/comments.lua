-------------------------
-- Comments: ------------
-------------------------

local M = {}

function M.configure()
  vim.g.kommentary_create_default_mappings = false

  require("kommentary.config").configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true,
  })
  vim.api.nvim_set_keymap("n", "<leader>zz", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("n", "<leader>z", "<Plug>kommentary_motion_default", {})
  vim.api.nvim_set_keymap("x", "<leader>z", "<Plug>kommentary_visual_default<C-c>", {})
end

return M
