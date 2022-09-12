-------------------------
-- Lualine: -------------
-------------------------

local M = {}

-- Custom functions
local function debug()
  local debug_status = require 'dap'.status()
  if debug_status ~= '' then
    return 'DEBUG: ' .. debug_status
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
      return 'LSP: ' .. client.name
    end
  end
  return ''
end

local function projector()
  local projector_status = require 'projector'.status()
  if projector_status ~= '' then
    return 'TASKS: ' .. projector_status
  end
  return ''
end

function M.configure()

  require('lualine').setup {
    options = {
      theme = 'onedark',
      component_separators = '',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        'NvimTree',
        'vista',
        'dbui',
        'packer',
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '', right = '' },
        },
      },
      lualine_b = {
        {
          'diagnostics',
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
      },
      lualine_c = {
        debug,
        lsp,
        projector,
      },

      lualine_x = {
        {
          'buffers',
          mode = 2,
        }
      },
      lualine_y = {
        'branch',
        {
          'diff',
          symbols = {
            added = '+',
            modified = '~',
            removed = '-',
          },
        },
      },
      lualine_z = {
        {
          'location',
          separator = { left = '', right = '' },
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

  local map_options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap('n', '<leader>b', ':LualineBuffersJump! ', map_options)

end

return M
