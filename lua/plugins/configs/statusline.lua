-------------------------
-- Lualine: -------------
-------------------------

local M = {}

-- Custom functions
local function debug()
  local debug_status = require("dap").status()
  if debug_status ~= "" then
    return "DEBUG: " .. debug_status
  end
  return ""
end

local function lsp()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ""
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return "LSP: " .. client.name
    end
  end
  return ""
end

local function projector()
  local projector_status = require("projector").status()
  if projector_status ~= "" then
    return "TASKS: " .. projector_status
  end
  return ""
end

-- Theme
local function configure_theme()
  local theme = require("lualine.themes.onedark")

  -- buffers theme
  theme.buffers = {
    active = { fg = theme.normal.a.bg, bg = theme.normal.b.bg, gui = "bold" },
    inactive = { fg = theme.inactive.b.fg, bg = theme.normal.b.bg },
  }

  -- transparent background
  for _, mode in pairs(theme) do
    if mode.c then
      mode.c.bg = nil
    end
  end

  return theme
end

function M.configure()
  require("lualine").setup {
    options = {
      theme = configure_theme(),
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        "NvimTree",
        "vista",
        "dbui",
        "packer",
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
        debug,
        lsp,
        projector,
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
    tabline = {
      lualine_a = {
        {
          "buffers",
          mode = 2,
          separator = { left = "", right = "" },
          buffers_color = {
            active = "lualine_active_buffers",
            inactive = "lualine_inactive_buffers",
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "tabs" },
    },
    winbar = {},
    extensions = {},
  }

  local map_options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap("n", "<leader>b", ":LualineBuffersJump! ", map_options)
end

return M
