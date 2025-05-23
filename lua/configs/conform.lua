local options = {
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
  },

  format_after_save = {
    lsp_fallback = true,
  },

  log_level = vim.log.levels.INFO,
}

return options
