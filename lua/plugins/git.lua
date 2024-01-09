-------------------------
-- Gitsigns: ------------
-------------------------

local M = {}

function M.configure_gitsigns()
  require("gitsigns").setup {
    on_attach = function(bufnr)
      local map_options = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "<leader>hs", '<Cmd>lua require"gitsigns".stage_hunk()<CR>', map_options)
      vim.keymap.set(
        "v",
        "<leader>hs",
        '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        map_options
      )
      vim.keymap.set("n", "<leader>hu", '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', map_options)
      vim.keymap.set("n", "<leader>hr", '<Cmd>lua require"gitsigns".reset_hunk()<CR>', map_options)
      vim.keymap.set(
        "v",
        "<leader>hr",
        '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        map_options
      )
      vim.keymap.set("n", "<leader>hR", '<Cmd>lua require"gitsigns".reset_buffer()<CR>', map_options)
      vim.keymap.set("n", "<leader>hp", '<Cmd>lua require"gitsigns".preview_hunk()<CR>', map_options)
      vim.keymap.set("n", "<leader>hb", '<Cmd>lua require"gitsigns".blame_line(true)<CR>', map_options)
      vim.keymap.set("n", "<leader>hS", '<Cmd>lua require"gitsigns".stage_buffer()<CR>', map_options)
      vim.keymap.set("n", "<leader>hU", '<Cmd>lua require"gitsigns".reset_buffer_index()<CR>', map_options)
      vim.keymap.set("n", "<leader>hi", '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>', map_options)
      vim.keymap.set("n", "<leader>hn", '<Cmd>lua require"gitsigns".next_hunk()<CR>', map_options)
      vim.keymap.set("n", "<leader>hN", '<Cmd>lua require"gitsigns".prev_hunk()<CR>', map_options)
    end,
  }
end

return M
