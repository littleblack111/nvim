return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Treesitter configuration moved to plugins/treesitter.lua

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion source
      "hrsh7th/cmp-buffer", -- Buffer completion source
      "hrsh7th/cmp-path", -- Path completion source
      "saadparwaiz1/cmp_luasnip", -- Snippet completion source
    },
    opts = require("configs.cmp").cmp,
  },

  -- Import all plugin modules
  { import = "plugins.transparent" },
  { import = "plugins.syntax-highlight" }, -- Add syntax highlighting enhancements
  { import = "plugins.treesitter" }, -- TreeSitter must be loaded early
  { import = "plugins.luasnip" }, -- Load LuaSnip and nvim-cmp configuration
  { import = "plugins.mason" }, -- LSP server management
  { import = "plugins.dap" }, -- Debug Adapter Protocol
  { import = "plugins.copilot" },
  { import = "plugins.code_runner" },
  { import = "plugins.wakatime" },
  { import = "plugins.snacks" },
  { import = "plugins.noice" },
  { import = "plugins.git-conflict" },
  { import = "plugins.avante" },
  { import = "plugins.mini-sessions" },
  { import = "plugins.render-markdown" },
  { import = "plugins.ts-autotag" },
  { import = "plugins.oil" },
  { import = "plugins.lsp-signature" },
  { import = "plugins.namu" },
  { import = "plugins.better-escape" },
  { import = "plugins.kitty-scrollback" },
  { import = "plugins.inlay-hints" },
  { import = "plugins.lsp_lines" },
}
