-------------------------
-- Dbee settings: -------
-------------------------
local Slayout = require("plugins.dbee.layout")
local dbee = require("dbee")
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

  vim.keymap.set("n", "<leader>l", function()
    if not dbee.is_open() then
      dbee.open()
    end
    slayout:open_popup()
  end, { noremap = true })

  -- setup function
  require("dbee").setup {
    sources = sources,
    drawer = {
      disable_help = true,
    },

    window_layout = slayout,
  }
end

return M
