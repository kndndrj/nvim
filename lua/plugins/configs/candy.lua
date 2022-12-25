-------------------------
-- Eye Candy: -----------
-------------------------

local M = {}

function M.configure_colorscheme()
  require("onedark").setup {
    code_style = {
      strings = "NONE",
      comments = "italic",
      keywords = "bold,italic",
      functions = "NONE",
      variables = "NONE",
    },
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  }

  vim.cmd("colorscheme onedark")

  -- use terminal's background
  vim.cmd("highlight Normal ctermbg=none guibg=none")
  vim.cmd("highlight EndOfBuffer ctermbg=none guibg=none")
  vim.cmd("highlight SignColumn ctermbg=none guibg=none")
  vim.cmd("highlight FloatBorder ctermbg=none guibg=none")
  vim.cmd("highlight NormalFloat ctermbg=none guibg=none")
end

function M.configure_dressing()
  require("dressing").setup {
    input = {
      insert_only = false,
      start_in_insert = true,
      win_options = {
        winblend = 0,
      },
    },
    select = {
      backend = { "builtin" },
      builtin = {
        win_options = {
          winblend = 0,
          winhighlight = "FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopeBorder",
        },
      },
    },
  }
end

function M.configure_notify()
  vim.opt.termguicolors = true
  require("notify").setup {
    background_colour = "#000000",
  }
  vim.notify = require("notify")
end

return M
