local function toggle_format_on_save()
  local current = require("conform").get_format_on_save()
  
  if current.timeout_ms then
    require("conform").setup({
      format_on_save = false
    })
    vim.notify("Format on save disabled", vim.log.levels.INFO)
  else
    require("conform").setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    })
    vim.notify("Format on save enabled", vim.log.levels.INFO)
  end
end

local function format_buffer()
  require("conform").format({
    timeout_ms = 500,
    lsp_fallback = true,
  })
end