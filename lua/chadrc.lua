-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyonight",
	transparency = true,
	extended_integrations = { "notify", "nvimtree", "whichkey" },
	theme_toggle = { "tokyonight", "gruvchad" },
	hl_override = {
		-- Override default highlight groups to make variables and functions stand out
		Comment = { italic = true },
		Identifier = { fg = "#88c0d0" },
		Function = { fg = "#81a1c1", bold = true },
		Type = { fg = "#8fbcbb" },
		Statement = { fg = "#a3be8c", bold = true },
		Special = { fg = "#b48ead" },
	},
}

M.ui = {
	tabufline = {
		lazyload = false,
		show_numbers = true,
	},
	telescope = { enabled = false },
	statusline = { 
		theme = "default",
		separator_style = "default",
		overriden_modules = function()
			return {}
		end,
	},
	nvdash = {
		load_on_startup = false,
	},
}

return M
