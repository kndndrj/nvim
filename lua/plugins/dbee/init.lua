-------------------------
-- Dbee settings: -------
-------------------------
local Slayout = require("plugins.dbee.layout")
local M = {}

--
-- Configuration function
--
function M.configure(conns)
  local default = require("dbee.config").default

  -- configure in-memory sources if any
  local sources
  if conns and not vim.tbl_isempty(conns) then
    sources = vim.list_extend({ require("dbee.sources").MemorySource:new(conns) }, default.sources)
  else
    sources = default.sources
  end

  local slayout = Slayout:new()
  local drawer_keymap = {
    key = "BC",
    mode = "n",
    action = function()
      slayout:open_drawer()
    end,
  }
  local call_log_keymap = {
    key = "BL",
    mode = "n",
    action = function()
      slayout:open_call_log()
    end,
  }

  local expand_mappings = function(defaults)
    table.insert(defaults, drawer_keymap)
    table.insert(defaults, call_log_keymap)
    return defaults
  end

  -- setup function
  require("dbee").setup {
    sources = sources,
    drawer = {
      disable_help = true,
      mappings = expand_mappings(default.drawer.mappings),
    },
    editor = {
      mappings = expand_mappings(default.editor.mappings),
    },
    call_log = {
      mappings = expand_mappings(default.call_log.mappings),
    },
    result = {
      mappings = expand_mappings(default.result.mappings),
    },

    window_layout = slayout,
  }
end

return M
