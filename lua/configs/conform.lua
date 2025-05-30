local options = {
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  format_on_save_timeout = 500,
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
    clang_format = {
      prepend_args = function()
        local root = vim.fn.getcwd()
        if vim.fn.filereadable(root .. "/.clang-format") == 1 then
          return { "--style=file" }
        else
          return { "--style", "{IndentWidth: 4, UseTab: Always, TabWidth: 4}" }
        end
      end,
    },
  },

  format_after_save = {
    lsp_fallback = true,
  },

  log_level = vim.log.levels.INFO,
}

return options
