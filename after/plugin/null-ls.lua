local null_ls = require("null-ls")
null_ls.setup({
    on_init = function(new_client, _)
      new_client.offset_encoding = 'utf-32'
    end,
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})


