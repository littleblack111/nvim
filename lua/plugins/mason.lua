return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "html-lsp",
        "css-lsp",
        "typescript-language-server", -- Default Mason package name
        "pyright",
        "clangd",
        "gopls",
        "json-lsp",
        "yaml-language-server",
        
        -- Formatters
        "stylua",
        "prettier",
        "clang-format",
        
        -- Linters
        "eslint_d",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      
      -- Ensure the servers are installed
      local ensure_installed = opts.ensure_installed or {}
      local registry = require("mason-registry")
      
      for _, tool in ipairs(ensure_installed) do
        if not registry.is_installed(tool) then
          local pkg = registry.get_package(tool)
          if pkg then
            pkg:install()
          end
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "tsserver", -- Correct name in mason-lspconfig is tsserver
        "pyright", 
        "clangd",
        "gopls",
        "jsonls",
        "yamlls",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}