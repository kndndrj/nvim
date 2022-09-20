-------------------------
-- Tmux navigation: -----
-------------------------
-- Create a keymap layer with libmodal
-- Enter that mode with tmux prefix
-- Exit the mode imediately for one-shot keymaps
-- Exit the mode after a timeout for repeat keymaps
--
-- examples:
--     swithc panes with: <tmuxprefix>h
--     resize panes with: <tmuxprefix>HHHHHHHHHHHHHH

local M = {}

-- Helper functions

local timer = nil

-- return to normal mode if no key presssed for a while
local function layer_timeout()
	if timer == nil then
		timer = vim.loop.new_timer()
	end
	timer:start(400, 0, vim.schedule_wrap(function()
		vim.api.nvim_input("<esc>")
		timer:close()
		timer = nil
	end))
end

-- return to normal mode
local function layer_exit()
	vim.api.nvim_input("<esc>")
end

local function enter_tmux_layer()
	-- return to normal mode
	vim.api.nvim_input("<C-\\><C-N>")

	require 'libmodal'.layer.enter(
		{
			n = {
				-- moving
				h = {
					rhs = function() layer_exit(); require("tmux").move_left() end,
					noremap = true,
				},
				j = {
					rhs = function() layer_exit(); require("tmux").move_bottom() end,
					noremap = true,
				},
				k = {
					rhs = function() layer_exit(); require("tmux").move_top() end,
					noremap = true,
				},
				l = {
					rhs = function() layer_exit(); require("tmux").move_right() end,
					noremap = true,
				},

				-- resizing
				H = {
					rhs = function() layer_timeout(); require("tmux").resize_left() end,
					noremap = true,
				},
				J = {
					rhs = function() layer_timeout(); require("tmux").resize_bottom() end,
					noremap = true,
				},
				K = {
					rhs = function() layer_timeout(); require("tmux").resize_top() end,
					noremap = true,
				},
				L = {
					rhs = function() layer_timeout(); require("tmux").resize_right() end,
					noremap = true,
				},
			}
		},
		-- exit layer with:
		'<Esc>'
	)
end

-- Configuration
function M.configure()

	require("tmux").setup {
		resize = {
			resize_step_x = 4,
			resize_step_y = 4,
		},
	}

	local map_options = { noremap = true, silent = true }

	-- enter the layer with tmux prefix
	vim.keymap.set('n', '<C-a>', enter_tmux_layer, map_options)
	vim.keymap.set('i', '<C-a>', enter_tmux_layer, map_options)
	vim.keymap.set('t', '<C-a>', enter_tmux_layer, map_options)

end

return M
