return {
	{
		"bassamsdata/namu.nvim",
		config = function()
			require("namu").setup({
				namu_symbols = {
					enable = true,
					options = {},
				},
				colorscheme = {
					enable = false,
					options = {
						persist = true,
						write_shada = false,
					},
				},
				ui_select = { enable = false },
			})
			
			local namu = require("namu.namu_symbols")
			local colorscheme = require("namu.colorscheme")
			vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
				desc = "Jump to LSP symbol",
				silent = true,
			})
			vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
				desc = "Colorscheme Picker",
				silent = true,
			})
		end,
	},
}
