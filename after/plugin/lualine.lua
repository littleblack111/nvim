local breadcrumb = function()
	local breadcrumb_status_ok, breadcrumb = pcall(require, "breadcrumb")
	if not breadcrumb_status_ok then
		return
	end
	return breadcrumb.get_breadcrumb()
end

local config = {
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { breadcrumb },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { breadcrumb },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}

require('lualine').setup(config)
