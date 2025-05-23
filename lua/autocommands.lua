-- Remember last position in file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local valid_line = vim.fn.line [['"]] >= 1 and vim.fn.line [['"]] < vim.fn.line "$"
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd [[normal! g`"]]
    end
  end,
})

-- Auto close NvimTree when it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "confirm quit"
    end
  end,
})
