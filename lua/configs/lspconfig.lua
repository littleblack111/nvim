local nvchad_lsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

-- LSP tab key handling
local original_on_attach = nvchad_lsp.on_attach

nvchad_lsp.on_attach = function(client, bufnr)
  if original_on_attach then
    original_on_attach(client, bufnr)
  end

end
nvchad_lsp.defaults()

-- Server setup
nvchad_lsp.defaults()

local servers = {
  "html", "cssls", "pyright",
  "clangd", "gopls", "jsonls", "yamlls", "lua_ls"
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = nvchad_lsp.on_attach,
    capabilities = nvchad_lsp.capabilities,
  })
end

-- TypeScript language server
lspconfig.ts_ls.setup({
  on_attach = nvchad_lsp.on_attach,
  capabilities = nvchad_lsp.capabilities,
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
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
      }
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
      }
    }
  }
})

lspconfig.lua_ls.setup({
  on_attach = nvchad_lsp.on_attach,
  capabilities = nvchad_lsp.capabilities,
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		require("lsp_signature").on_attach({
			hint_prefix = false,
			handler_opts = {
				border = "rounded",
			},
			hint_enable = true,
		}, bufnr)
		 require("lsp_lines").setup()
	end,
})
