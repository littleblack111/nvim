require "nvchad.mappings"

local map = vim.keymap.set

-- Only unmap Tab key related bindings, keep leader key mappings
local unmap = vim.keymap.del

-- List of keymappings to disable - only Tab related ones
local default_mappings_to_disable = {
  { mode = "n", key = "<Tab>" },      -- Unmap default Tab behavior
  { mode = "i", key = "<Tab>" }       -- Unmap default Tab behavior in insert mode
  -- Add any other Tab-related mappings you want to disable
}

-- Disable only the Tab-related mappings
for _, mapping in ipairs(default_mappings_to_disable) do
  pcall(unmap, mapping.mode, mapping.key)
end

-- Restore common leader key mappings that NvChad might have
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit with confirmation" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>x", "<cmd>confirm bd<CR>", { desc = "Close buffer with confirmation" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "j", "gj")
map("n", "k", "gk")
map("i", "<S-Tab>", "<C-d>")

-- Key mappings from lunarvim config
map("n", "<leader>r", "<cmd>RunFile<CR>", { desc = "Run File" })
map("n", "<leader>sr", "<cmd>'<,'>SnipRun<CR>", { desc = "Snip Run" })
map("n", "<leader>nn", "<cmd>Noice dismiss<CR>", { desc = "Dismiss Notifications" })
map("n", "<leader>,", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
map("i", "<C-BS>", "<C-w>", { desc = "Delete Word" })

-- BufferLine tabs
map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
map("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
map("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
map("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
map("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
map("n", "<leader>0", "<cmd>BufferLineGoToBuffer 10<CR>", { desc = "Go to buffer 10" })

-- Use snacks picker
if Snacks then
  map("n", "<leader>f", function()
    Snacks.picker.smart()
  end, { desc = "Smart Find Files" })
end

-- LSP related mappings
map("n", "<leader>li", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

map("n", "<leader>ls", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
map("n", "<leader>lR", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
