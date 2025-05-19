require "nvchad.options"

local o = vim.o
local g = vim.g

o.tabstop = 4
o.shiftwidth = 4
o.ignorecase = true
o.smartcase = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.expandtab = false       -- Don't expand tabs to spaces
o.timeoutlen = 100
o.linebreak = true
o.swapfile = false
o.softtabstop = 0        -- Disable soft tabs to ensure Tab inserts a real tab
o.smarttab = false       -- Disable smart tab behavior but allow AI completions

g.lsp_document_highlight_enable = true
g.lsp_inlay_hint_enable = true
g.lsp_codelens_enable = false
g.lsp_refresh_time = 1000

-- Enable syntax highlighting
vim.cmd('syntax enable')
vim.cmd('syntax on')

-- Ensure proper highlighting with Treesitter
o.termguicolors = true     -- Enable 24-bit RGB color in the TUI
