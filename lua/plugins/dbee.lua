-------------------------
-- Dbee settings: -------
-------------------------
local api_ui = require("dbee").api.ui
local utils = require("dbee.utils")
local tools = require("dbee.layouts.tools")

local M = {}

-- Slayout is a layout that slays.
-- I DON'T KNOW WHY I PICKED THIS STUPID NAME, BUT I DID, OKAY!
---@class Slayout: Layout
---@field private egg? layout_egg
---@field private windows integer[]
---@field private is_opened boolean
local Slayout = {}

---Create a default layout.
---@return Slayout
function Slayout:new()
  ---@type Slayout
  local o = {
    egg = nil,
    is_opened = false,
    windows = {},
  }
  setmetatable(o, self)
  self.__index = self

  vim.keymap.set("n", "<leader>cc", function()
    ---@diagnostic disable-next-line
    o:open_popup(api_ui.drawer_show)
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>cl", function()
    ---@diagnostic disable-next-line
    o:open_popup(api_ui.call_log_show)
  end, { noremap = true, silent = true })

  return o
end

---Action taken when another (inapropriate) buffer is open in the window.
---@package
---@param on_switch "immutable"|"close"
---@param winid integer
---@param open_fn fun(winid: integer)
---@param is_editor? boolean special care needs to be taken with editor - it uses multiple buffers.
function Slayout:configure_window_on_switch(on_switch, winid, open_fn, is_editor)
  local action
  if on_switch == "close" then
    action = function(_, buf, file)
      if is_editor then
        local note, _ = api_ui.editor_search_note_with_file(file)
        if note then
          -- do nothing
          return
        end
        note, _ = api_ui.editor_search_note_with_buf(buf)
        if note then
          -- do nothing
          return
        end
      end
      -- close dbee and open buffer
      self:close()
      vim.api.nvim_win_set_buf(0, buf)
    end
  else
    action = function(win, _, _)
      open_fn(win)
    end
  end

  utils.create_singleton_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
    window = winid,
    callback = function(event)
      action(winid, event.buf, event.file)
    end,
  })
end

---Close all other windows when one is closed.
---@package
---@param winid integer
function Slayout:configure_window_on_quit(winid)
  utils.create_singleton_autocmd({ "QuitPre" }, {
    window = winid,
    callback = function()
      self:close()
    end,
  })
end

---Open call dbee popup
---@private
---@param show_fn fun(winid: integer) function to open a dbee view.
function Slayout:open_popup(show_fn)
  local ui_spec = vim.api.nvim_list_uis()[1]
  local win_width = 60
  local win_height = 30
  local x = 15
  local y = math.floor((ui_spec["height"] - win_height) / 2)

  -- create new dummy buffer
  local tmp_buf = vim.api.nvim_create_buf(false, true)

  -- open window
  local winid = vim.api.nvim_open_win(tmp_buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = x,
    row = y,
    border = "rounded",
    title = "",
    title_pos = "center",
    style = "minimal",
  })
  table.insert(self.windows, winid)

  -- open the dbee view in this window
  show_fn(winid)

  -- remove temp buffer
  pcall(vim.api.nvim_buf_delete, tmp_buf, { force = true })

  -- set exit strategies
  local bufnr = vim.api.nvim_win_get_buf(winid)
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    buffer = bufnr,
    callback = function()
      pcall(vim.api.nvim_win_close, winid, true)
    end,
  })
  vim.keymap.set("n", "<ESC>", function()
    vim.api.nvim_win_close(winid, true)
  end, { silent = true, buffer = bufnr })
end

---@return boolean
function Slayout:is_open()
  return self.is_opened
end

---Open drawer popup
function Slayout:open_drawer()
  self:open_popup(api_ui.drawer_show)
end

---Open call log popup
function Slayout:open_call_log()
  self:open_popup(api_ui.call_log_show)
end

---This function just opens result and editor views in a split.
function Slayout:open()
  -- save layout before opening ui
  self.egg = tools.save()

  self.windows = {}

  -- editor
  tools.make_only(0)
  local editor_win = vim.api.nvim_get_current_win()
  table.insert(self.windows, editor_win)
  api_ui.editor_show(editor_win)
  self:configure_window_on_switch("close", editor_win, api_ui.editor_show, true)
  self:configure_window_on_quit(editor_win)

  -- result
  vim.cmd("bo split")
  local win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  api_ui.result_show(win)
  self:configure_window_on_switch("close", win, api_ui.result_show)
  self:configure_window_on_quit(win)

  -- set cursor to editor
  vim.api.nvim_set_current_win(editor_win)

  self.is_opened = true
end

function Slayout:close()
  -- close all windows
  for _, win in ipairs(self.windows) do
    pcall(vim.api.nvim_win_close, win, false)
  end

  -- restore layout
  tools.restore(self.egg)
  self.egg = nil
  self.is_opened = false
end

--
-- Configuration function
--
function M.configure(conns)
  -- configure in-memory sources if any
  local sources
  if conns and not vim.tbl_isempty(conns) then
    sources =
      vim.list_extend(require("dbee.config").default.sources, { require("dbee.sources").MemorySource:new(conns) })
  else
    sources = require("dbee.config").default.sources
  end

  -- add extra mappings to all dbee views
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

  local default = require("dbee.config").default

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
