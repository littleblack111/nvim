local function toggle_format_on_save()
  require("conform").setup {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  }
  vim.notify("Format on save enabled", vim.log.levels.INFO)
end

local function format_buffer()
  require("conform").format {
    timeout_ms = 500,
    lsp_fallback = true,
  }
end

