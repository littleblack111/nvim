local lspconfig = require "lspconfig"

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = { "sumneko_lua", "rust_analyzer" },
}

return require("mason-lspconfig").setup_handlers {
  function(server)
    lspconfig[server].setup {}
  end,
}
