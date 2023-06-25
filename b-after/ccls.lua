--require("lspconfig")["ccls"].setup(
--    {
--        init_options = {
--            cache = {
--                directory = "/tmp/ccls_cache",
--            },
--        },
--        lsp = {
--            use_defaults = true
--        },
--    }
--)

require("ccls").setup(
    {
        lsp = {
            use_defaults = true
        },
    }
)
