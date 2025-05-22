return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    hint_enable = false,
    -- hint_prefix = false,
    handler_opts = {
      border = "rounded",
    },
  },
  -- config = function(_, opts)
  --   require("lsp_signature").setup(opts)
  -- end,
}
