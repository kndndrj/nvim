-------------------------
-- Null Ls settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
	local null_ls = require("null-ls")

	-- Generate sources map from sources configs
	local sources_configs = require("plugins.configs.nullls.sources")
	local sources = {}
	for type, configs in pairs(sources_configs) do
		for source, config in pairs(configs) do
			table.insert(sources, null_ls.builtins[type][source].with(config))
		end
	end

	-- call the setup function
	null_ls.setup({
		sources = sources,
	})
end

return M
