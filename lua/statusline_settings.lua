-------------------------
-- Galaxyline: ----------
-------------------------
local gl = require'galaxyline'
local condition = require'galaxyline.condition'
local gls = gl.section
gl.short_line_list = {
  'NvimTree',
  'vista',
  'dbui',
  'packer',
  'dap-repl',
  'dapui_scopes',
  'dapui_breakpoints',
  'dapui_stacks',
  'dapui_watches',
}

-- Get the colors from the colorscheme
local colors = require'onedark.colors'.setup()

gls.left[1] = {
  ViMode = {
    provider = function()
      local vi_mode = vim.fn.mode()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.yellow2,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.purple,
        Rv = colors.purple,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!']  = colors.red,
        t = colors.red,
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vi_mode])
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        v = 'VISUAL',
        [''] = 'VISUAL BLOCK',
        V = 'VISUAL LINE',
        c = 'COMMAND',
        s = 'SELECT',
        S = 'SELECT LINE',
        R = 'REPLACE',
        t = 'TERMINAL',
      }
      if alias[vi_mode] ~= nil then
        return '█ '..alias[vi_mode]..' '
      end
      return '█ '..vi_mode..' '
    end,
    highlight = {colors.red,colors.bg2,'bold'},
  },
}

gls.left[2] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg2},
  },
}

gls.left[3] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.yellow2,colors.bg2,'bold'}
  }
}

gls.left[4] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.hide_in_width,
    highlight = {colors.fg,colors.bg2}
  }
}

gls.left[5] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg2}
  }
}

gls.left[6] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.yellow,colors.bg2},
  }
}

gls.left[7] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.cyan,colors.bg2},
  }
}

gls.left[8] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.blue,colors.bg2}
  }
}



gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = condition.hide_in_width,
    icon = '   ',
    highlight = {colors.cyan,colors.bg2,'bold'}
  }
}

gls.mid[2] = {
  Debug = {
    provider = function ()
      local debug_status = require'dap'.status()
      if debug_status ~= '' then
        return debug_status
      end
      return 'No Active DAP'
    end,
    condition = condition.hide_in_width,
    separator = ' |',
    separator_highlight = {'NONE',colors.bg2},
    icon = '   ',
    highlight = {colors.orange,colors.bg2,'bold'}
  }
}



gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.green,colors.bg2,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.green,colors.bg2,'bold'}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.orange,colors.bg2,'bold'},
  }
}

gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.hide_in_width,
    highlight = {colors.purple,colors.bg2,'bold'},
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    separator = ' |',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.green,colors.bg2},
  }
}

gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg2},
  }
}

gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg2},
  }
}

gls.right[8] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.fg,colors.bg2},
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg2},
    highlight = {colors.blue,colors.bg2,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg2,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg2}
  }
}
