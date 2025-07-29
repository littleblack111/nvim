local nvchad_lsp = require "nvchad.configs.lspconfig"

-- Set default config for all servers
vim.lsp.config("*", {
  on_attach = nvchad_lsp.on_attach,
  capabilities = nvchad_lsp.capabilities,
})

-- Custom config for lua_ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- -- Custom config for clangd
-- vim.lsp.config("clangd", {
--   cmd = { "clangd", "--background-index", "--all-scopes-completion" },
--   root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
-- })

-- vim.lsp.config("qmlls", {
  --cmd = { "qmlls", "-E" },
--})

-- Custom config for tsserver (typescript-language-server)
vim.lsp.config("tsserver", {
  init_options = { hostInfo = "neovim" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    require("lsp_signature").on_attach({
      hint_enable = false,
      hint_prefix = false,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
    -- require("lsp_lines").setup()
  end,
})
