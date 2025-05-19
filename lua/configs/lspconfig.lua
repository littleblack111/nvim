-- Get the default lspconfig setup but disable any tab key bindings
local nvchad_lsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

-- Save original defaults
local original_on_attach = nvchad_lsp.on_attach

-- Override the on_attach to disable tab mappings for LSP but allow for AI completions
nvchad_lsp.on_attach = function(client, bufnr)
  -- Call the original on_attach
  if original_on_attach then
    original_on_attach(client, bufnr)
  end
  
  -- Remove any Tab mappings from LSP specifically
  -- But this won't interfere with AI completions
  pcall(vim.keymap.del, "i", "<Tab>", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<Tab>", { buffer = bufnr })
end

-- Apply the custom defaults
nvchad_lsp.defaults()

-- Add LSP servers to be automatically set up when installed
local servers = { 
  "html", "cssls", "pyright", 
  "clangd", "gopls", "jsonls", "yamlls", "lua_ls"
  -- Note: tsserver is NOT deprecated - it's the proper name in lspconfig for the typescript-language-server
}

-- Configure each server
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = nvchad_lsp.on_attach,
    capabilities = nvchad_lsp.capabilities,
  })
end

-- Setup TypeScript language server using ts_ls
-- As per nvim-lspconfig, ts_ls is the newer implementation using typescript-language-server
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
  -- Add custom settings here
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

-- Special configuration for lua_ls
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

-- Setup lsp_signature on LSP attach
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
	end,
}) 
