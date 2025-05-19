return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        -- Custom highlights to improve variable and function visibility
        hl.Identifier = { fg = c.cyan, style = { bold = true } }
        hl.Function = { fg = c.blue, style = { bold = true } }
        hl.Variable = { fg = c.cyan }
        hl.Parameter = { fg = c.cyan, style = { italic = true } }
        hl.Method = { fg = c.blue, style = { bold = true, italic = true } }
        hl.Field = { fg = c.lavender }
        hl.Property = { fg = c.lavender }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },
  
  -- Make Neovim command line a bit better
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Add better command line and enhance error messages
      opts.cmdline = opts.cmdline or {}
      opts.messages = opts.messages or {}
      opts.popupmenu = opts.popupmenu or {}
      
      opts.cmdline.view = "cmdline"
      opts.messages.view_search = false
      opts.popupmenu.enabled = true
    end,
  },
  
  -- Add filetype plugin for better syntax highlighting in various file types
  {
    "nathom/filetype.nvim",
    lazy = false,
    opts = {
      overrides = {
        extensions = {
          h = "cpp",
          hpp = "cpp",
          inl = "cpp",
          ipp = "cpp",
          cs = "cs",
          go = "go",
          rs = "rust",
        },
      },
    },
  }
}
