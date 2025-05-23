return {
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 1000, -- Load treesitter early
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Create custom highlight links to improve variable and function highlighting
      local highlights = {
        ["@variable"] = { link = "Identifier" },
        ["@variable.builtin"] = { link = "Special" },
        ["@function"] = { link = "Function", bold = true },
        ["@function.builtin"] = { link = "Special" },
        ["@function.call"] = { link = "Function" },
        ["@method"] = { link = "Function", italic = true },
        ["@method.call"] = { link = "Function" },
        ["@parameter"] = { link = "Identifier", italic = true },
        ["@field"] = { link = "Identifier" },
        ["@property"] = { link = "Identifier" },
        ["@constant"] = { link = "Constant", bold = true },
        ["@constant.builtin"] = { link = "Special", bold = true },
        ["@namespace"] = { link = "Include" },
        ["@symbol"] = { link = "Identifier" },
        ["@text.title"] = { link = "Title", bold = true },
        ["@text.uri"] = { link = "Underlined" },
        ["@text.literal"] = { link = "String" },
        ["@text.reference"] = { link = "Constant" },
        ["@tag"] = { link = "Label" },
        ["@tag.attribute"] = { link = "Identifier" },
      }

      for group, setting in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, setting)
      end

      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          -- Base languages
          "vim",
          "lua",
          "vimdoc",
          -- Web development
          "javascript",
          "typescript",
          "html",
          "css",
          -- Common programming languages
          "c",
          "cpp",
          "python",
          -- Web formats
          "json",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},

        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },

        -- Improved selection based on syntax nodes
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Enhanced textobjects based on syntax nodes
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
}
