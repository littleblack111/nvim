return {
  -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  -- lazy = false,
  -- config = function()
  -- 	require("lsp_lines").setup()
  --
  -- 	vim.diagnostic.config({
  -- 		virtual_text = false,
  -- 		virtual_lines = true,
  -- 	})
  --
  -- 	local function toggle_lsp_lines()
  -- 		local new_value = not vim.diagnostic.config().virtual_lines
  -- 		vim.diagnostic.config({
  -- 			virtual_lines = new_value,
  -- 			virtual_text = not new_value,
  -- 		})
  -- 		print("LSP Lines: " .. (new_value and "enabled" or "disabled"))
  -- 	end
  --
  -- 	-- Add a key binding to toggle lsp_lines
  -- 	vim.keymap.set("n", "<leader>ll", toggle_lsp_lines, { desc = "Toggle LSP Lines" })
  -- end,
}
