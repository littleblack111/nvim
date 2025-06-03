return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged,InsertLeave",
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

      -- Configure custom keybindings for snippets
      local ls = require "luasnip"

      -- Use Ctrl-f to jump forward in snippets (LunarVim style)
      vim.keymap.set({ "i", "s" }, "<C-f>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "Jump forward in snippet" })

      -- Use Shift-Tab to jump backward in snippets
      vim.keymap.set({ "i", "s" }, "<C-S-f>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "Jump backward in snippet" })

      -- Also set a whichkey description for the snippet navigation
      if package.loaded["which-key"] then
        require("which-key").register({
          ["<C-f>"] = { name = "Jump to next snippet placeholder" },
          ["<S-Tab>"] = { name = "Jump to previous snippet placeholder" },
        }, { mode = "i" })
      end
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript", "typescript", "javascriptreact" })
    end,
  },
}
