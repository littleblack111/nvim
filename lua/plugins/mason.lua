return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "pyright",
        "clangd",
        "gopls",
        "json-lsp",
        "yaml-language-server",

        -- Formatters
        "stylua",
        "prettier",
        "prettierd",
        "clang-format",
        "black",
        "isort",
        "gofmt",
        "goimports",
        "google-java-format",
        "shfmt",
        "rustfmt",
        "clang_format",

        -- Linters
        "eslint_d",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local ensure_installed = opts.ensure_installed or {}
      local registry = require "mason-registry"

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
        "tsserver",
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

