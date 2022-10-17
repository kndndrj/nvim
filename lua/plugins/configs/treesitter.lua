-------------------------
-- TreeSitter: ----------
-------------------------

local M = {}

function M.configure()
  require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>vv",
        node_incremental = "<leader>vn",
        node_decremental = "<leader>vm",
        scope_incremental = "<leader>vs",
        scope_decremental = "<leader>vd",
      },
    },
    indent = {
      enable = true,
    },
  }
end

return M
