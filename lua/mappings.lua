require "nvchad.mappings"

local map = vim.keymap.set
-- local unmap = vim.keymap.del

map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit with confirmation" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>x", "<cmd>confirm bd<CR>", { desc = "Close buffer with confirmation" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "j", "gj")
map("n", "k", "gk")
map("i", "<S-Tab>", "<C-d>")
map("n", "<leader>r", "<cmd>RunFile<CR>", { desc = "Run File" })
map("n", "<leader>sr", "<cmd>'<,'>SnipRun<CR>", { desc = "Snip Run" })
map("n", "<leader>nn", "<cmd>Noice dismiss<CR>", { desc = "Dismiss Notifications" })
map("n", "<leader>,", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
map("i", "<C-BS>", "<C-w>", { desc = "Delete Word" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "References" })

-- Buffer navigation
local tabufline = require "nvchad.tabufline"

local function safe_goto_buf(index)
  if vim.t.bufs and vim.t.bufs[index] then
    local buf_id = vim.t.bufs[index]
    if vim.api.nvim_buf_is_valid(buf_id) then
      vim.api.nvim_set_current_buf(buf_id)
    end
  end
end

map("n", "<leader>1", function()
  safe_goto_buf(1)
end, { desc = "Go to buffer 1" })
map("n", "<leader>2", function()
  safe_goto_buf(2)
end, { desc = "Go to buffer 2" })
map("n", "<leader>3", function()
  safe_goto_buf(3)
end, { desc = "Go to buffer 3" })
map("n", "<leader>4", function()
  safe_goto_buf(4)
end, { desc = "Go to buffer 4" })
map("n", "<leader>5", function()
  safe_goto_buf(5)
end, { desc = "Go to buffer 5" })
map("n", "<leader>6", function()
  safe_goto_buf(6)
end, { desc = "Go to buffer 6" })
map("n", "<leader>7", function()
  safe_goto_buf(7)
end, { desc = "Go to buffer 7" })
map("n", "<leader>8", function()
  safe_goto_buf(8)
end, { desc = "Go to buffer 8" })
map("n", "<leader>9", function()
  safe_goto_buf(9)
end, { desc = "Go to buffer 9" })
map("n", "<leader>0", function()
  safe_goto_buf(10)
end, { desc = "Go to buffer 10" })

map("n", "<leader>c", function()
  pcall(function()
    tabufline.close_buffer()
  end)
end, { desc = "Close buffer" })

if Snacks then
  map("n", "<leader>f", function()
    Snacks.picker.smart()
  end, { desc = "Smart Find Files" })
end

-- LSP
map("n", "<leader>li", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

map("n", "<leader>ls", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
map("n", "<leader>lR", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
