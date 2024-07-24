-------------------------
-- Lualine: -------------
-------------------------

local M = {}

local function lsp()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ""
  end

  local names = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(names, client.name)
    end
  end
  return table.concat(names, "|")
end

-- Theme
local function configure_lualine_theme()
  local theme = require("lualine.themes.tokyonight")

  -- buffers theme
  theme.buffers = {
    active = { fg = theme.normal.a.bg, bg = theme.normal.b.bg, gui = "bold" },
    inactive = { bg = theme.normal.b.bg },
  }

  -- transparent background
  for _, mode in pairs(theme) do
    if mode.c then
      mode.c.bg = nil
    end
  end

  return theme
end

function M.configure_lualine()
  require("lualine").setup {
    options = {
      theme = configure_lualine_theme(),
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        "NvimTree",
        "vista",
        "dbui",
        "packer",
        "startup",
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "", right = "" },
        },
      },
      lualine_b = {},
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
      },

      lualine_x = {
        require("dap").status,
        lsp,
        require("projector").status,
      },
      lualine_y = {
        {
          "branch",
          separator = { left = "", right = "" },
        },
        "diff",
      },
      lualine_z = {
        {
          "location",
          separator = { left = "", right = "" },
        },
      },
    },
    winbar = {},
    extensions = {},
  }
end

function M.configure_bufferline()
  require("bufferline").setup {
    options = {
      diagnostics = "nvim_lsp",

      show_buffer_close_icons = false,
    },
  }

  local ns = vim.api.nvim_create_namespace("config.bufferline")
  vim.diagnostic.config({ update_in_insert = true }, ns)

  local map_options = { noremap = true, silent = true }

  vim.keymap.set("n", "<leader>b", ":BufferLinePick<CR>", map_options)
  vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>", map_options)
  vim.keymap.set("n", "<leader>N", ":BufferLineCyclePrev<CR>", map_options)
end

return M
