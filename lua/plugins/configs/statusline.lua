-------------------------
-- Lualine: -------------
-------------------------

local M = {}

-- Custom functions
local function debug()
  local debug_status = require 'dap'.status()
  if debug_status ~= '' then
    return 'Debug: ' .. debug_status
  end
  return ''
end

local function lsp()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ''
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return 'Lsp: ' .. client.name
    end
  end
  return ''
end

local function projector()
  local projector_status = require 'projector'.status()
  if projector_status ~= '' then
    return 'Tasks: ' .. projector_status
  end
  return ''
end

function M.configure()

  require('lualine').setup {
    options = {
      theme = 'onedark',
      component_separators = '|',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'NvimTree',
        'vista',
        'dbui',
        'packer',
        'dap-repl',
        'dapui_scopes',
        'dapui_breakpoints',
        'dapui_stacks',
        'dapui_watches',
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '' },
          right_padding = 2
        },
      },
      lualine_b = {
        'filename'
      },
      lualine_c = {
        debug,
        lsp,
        projector,
        {
          'diagnostics',
          diagnostics_color = {
            error = { fg = '#e67e80' },
            warn = { fg = '#dbbc7f' },
            info = { fg = '#7fbbb3' },
            hint = { fg = '#a7c080' },
          },
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
      },

      lualine_x = {
        'filetype',
        'filesize',
        'encoding',
        'fileformat',
      },
      lualine_y = {
        'branch',
        {
          'diff',
          diff_color = {
            added = { fg = '#a7c080' },
            modified = { fg = '#7fbbb3' },
            removed = { fg = '#e67e80' },
          },
          symbols = {
            added = ' ',
            modified = 'ﰣ ',
            removed = ' ',
          },
        },
      },
      lualine_z = {
        {
          'location',
          separator = { right = '' },
          left_padding = 2
        },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }

end

return M
