-------------------------
-- Tmux navigation: -----
-------------------------
-- Create a keymap layer with libmodal
-- Enter that mode with tmux prefix
-- Exit the mode imediately for one-shot keymaps
-- Exit the mode after a timeout for repeat keymaps
--
-- examples:
--     switch panes with: <tmuxprefix>h
--     resize panes with: <tmuxprefix>HHHHHHHHHHHHHH

local M = {}


-- globals
local timer
local layer

--
-- Helper functions
--
local function layer_exit()
	if layer:is_active() then
		layer:exit()
	end
end

-- return to normal mode if no key presssed for a while
local function layer_timeout(timeout)
	if not timer then
		timer = vim.loop.new_timer()
	end
	timer:start(timeout, 0, vim.schedule_wrap(function()
		layer_exit()
		if timer then
			timer:stop()
			timer:close()
			timer = nil
		end
	end))
end

local function layer_enter()
	if not layer:is_active() then
		-- exit layer automatically after timeout
		layer_timeout(800)
		layer:enter()
	end
end

-- return to normal mode
local function nm()
	vim.api.nvim_input("<C-\\><C-N>")
end

local function layer_create()
	local tmux = require("tmux")
	local mappings = {
		-- moving
		h = {
			rhs = function() nm(); layer_exit(); tmux.move_left() end,
			noremap = true,
		},
		j = {
			rhs = function() nm(); layer_exit(); tmux.move_bottom() end,
			noremap = true,
		},
		k = {
			rhs = function() nm(); layer_exit(); tmux.move_top() end,
			noremap = true,
		},
		l = {
			rhs = function() nm(); layer_exit(); tmux.move_right() end,
			noremap = true,
		},

		-- resizing
		H = {
			rhs = function() layer_timeout(350); tmux.resize_left() end,
			noremap = true,
		},
		J = {
			rhs = function() layer_timeout(350); tmux.resize_bottom() end,
			noremap = true,
		},
		K = {
			rhs = function() layer_timeout(350); tmux.resize_top() end,
			noremap = true,
		},
		L = {
			rhs = function() layer_timeout(350); tmux.resize_right() end,
			noremap = true,
		},
	}

	local libmodal = require 'libmodal'
	layer = libmodal.layer.new(
		{
			n = mappings,
			i = mappings,
			t = mappings,
			x = mappings,
			o = mappings,
		}
	)

	-- exit layer manually with:
	vim.keymap.set('n', '<esc>', function() layer_exit() end, { noremap = true, silent = true })
end

-- Configuration
function M.configure()

	require("tmux").setup {
		copy_sync = {
			enable = false,
		},
		navigation = {
			enable_default_keybindings = false,
		},
		resize = {
			enable_default_keybindings = false,
			resize_step_x = 4,
			resize_step_y = 4,
		},
	}

	local map_options = { noremap = true, silent = true }

	-- create a layer once
	layer_create()

	-- enter the layer with tmux prefix
	vim.keymap.set('n', '<C-a>', layer_enter, map_options)
	vim.keymap.set('i', '<C-a>', layer_enter, map_options)
	vim.keymap.set('t', '<C-a>', layer_enter, map_options)
	vim.keymap.set('x', '<C-a>', layer_enter, map_options)
	vim.keymap.set('o', '<C-a>', layer_enter, map_options)
end

return M
