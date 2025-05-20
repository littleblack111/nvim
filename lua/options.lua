require "nvchad.options"

local o = vim.o
local g = vim.g

o.tabstop = 4
o.shiftwidth = 4
o.ignorecase = true
o.smartcase = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.expandtab = false
o.timeoutlen = 100
o.linebreak = true
o.swapfile = false
o.softtabstop = 0
o.smarttab = false

g.lsp_document_highlight_enable = true
g.lsp_inlay_hint_enable = true
g.lsp_codelens_enable = false
g.lsp_refresh_time = 1000

o.syntax = "on"
o.termguicolors = true

vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
