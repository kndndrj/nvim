-------------------------
-- Gitsigns: ------------
-------------------------

local M = {}

function M.configure_gitsigns()
  require("gitsigns").setup {
    keymaps = {},
  }
  local map_options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<leader>hs", '<Cmd>lua require"gitsigns".stage_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap(
    "v",
    "<leader>hs",
    '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    map_options
  )
  vim.api.nvim_set_keymap("n", "<leader>hu", '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hr", '<Cmd>lua require"gitsigns".reset_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap(
    "v",
    "<leader>hr",
    '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    map_options
  )
  vim.api.nvim_set_keymap("n", "<leader>hR", '<Cmd>lua require"gitsigns".reset_buffer()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hp", '<Cmd>lua require"gitsigns".preview_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hb", '<Cmd>lua require"gitsigns".blame_line(true)<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hS", '<Cmd>lua require"gitsigns".stage_buffer()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hU", '<Cmd>lua require"gitsigns".reset_buffer_index()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hi", '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hn", '<Cmd>lua require"gitsigns".next_hunk()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>hN", '<Cmd>lua require"gitsigns".prev_hunk()<CR>', map_options)
end

-------------------------
-- Fugitive: ------------
-------------------------

function M.configure_fugitive()
  local map_options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<leader>vd", ":diffget //2<CR>", map_options)
  vim.api.nvim_set_keymap("n", "<leader>vj", ":diffget //3<CR>", map_options)
end

return M
