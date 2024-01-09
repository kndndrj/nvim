-------------------------
-- Eye Candy: -----------
-------------------------

local M = {}

function M.configure_colorscheme()
  -- colorscheme
  require("tokyonight").setup {
    style = "storm",
    transparent = true,
  }

  vim.cmd.colorscheme("tokyonight")

  -- disable cursorline and colorcolumn when leaving the editor
  vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
    callback = function()
      vim.wo.colorcolumn = ""
      vim.wo.cursorline = false
    end,
  })
  vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
    callback = function()
      vim.wo.colorcolumn = "100"
      vim.wo.cursorline = true
    end,
  })
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
  }
end

function M.configure_notify()
  vim.opt.termguicolors = true
  local notify = require("notify")
  notify.setup {
    background_colour = "#000000",
    render = "wrapped-compact",
  }
  vim.notify = notify

  -- dismiss displayed messages
  vim.keymap.set("n", "<C-l>", function()
    notify.dismiss { silent = true, pending = true }
    vim.cmd("nohlsearch|diffupdate")
  end, { remap = false })
end

return M
