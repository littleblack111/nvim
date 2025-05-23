-- Initialize Snacks global variable
if package.loaded["snacks"] then
  Snacks = require "snacks"
end

-- Enable the LSP features from LunarVim
local g = vim.g
g.lsp_document_highlight_enable = true
g.lsp_inlay_hint_enable = true
g.lsp_codelens_enable = false
g.lsp_refresh_time = 1000

