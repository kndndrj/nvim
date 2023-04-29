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

function M.configure_greeting()
  require("startup").setup {
    header = {
      type = "text",
      oldfiles_directory = false,
      align = "center",
      fold_section = false,
      title = "Header",
      margin = 5,
      content = require("startup.headers").neovim_logo_header,
      highlight = "Statement",
      default_color = "",
      oldfiles_amount = 0,
    },
    body = {
      type = "mapping",
      oldfiles_directory = false,
      align = "center",
      fold_section = false,
      title = "Basic Commands",
      margin = 5,
      content = {
        {
          "  New Buffer",
          [[ lua local b = vim.api.nvim_create_buf(true, false); vim.api.nvim_set_current_buf(b) ]],
          "<leader>nf",
        },
        { "  Find File", "Telescope find_files", "<leader>ff" },
        { "  Recent Files", "Telescope oldfiles", "<leader>fo" },
        { "  Find Word", "Telescope live_grep", "<leader>fg" },
      },
      highlight = "String",
      default_color = "",
      oldfiles_amount = 0,
    },
    footer = {
      type = "text",
      oldfiles_directory = false,
      align = "center",
      fold_section = false,
      title = "Footer",
      margin = 5,
      content = { os.date() },
      highlight = "Number",
      default_color = "",
      oldfiles_amount = 0,
    },

    options = {
      mapping_keys = true,
      cursor_column = 0.5,
      empty_lines_between_mappings = true,
      disable_statuslines = true,
      paddings = { 1, 3, 3, 0 },
    },
    mappings = {
      execute_command = "<CR>",
      open_file = "o",
      open_file_split = "<c-o>",
      open_section = "<TAB>",
      open_help = "?",
    },
    colors = {
      background = "#1f2227",
      folded_section = "#56b6c2",
    },
    parts = { "header", "body", "footer" },
  }
end

return M
