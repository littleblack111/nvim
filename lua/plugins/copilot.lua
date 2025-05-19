return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    -- Enable Copilot for all filetypes
    vim.g.copilot_enabled = true
    
    -- Disable default tab mapping to allow our custom handling
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    
    -- Define explicit mapping for Copilot accept
    vim.api.nvim_set_keymap('i', '<Plug>(copilot-accept)', 'copilot#Accept("")', { expr = true, silent = true })
    
    -- Filetypes to disable copilot
    vim.g.copilot_filetypes = {
      ["TelescopePrompt"] = false,
      ["DressingInput"] = false,
      ["help"] = false,
      [""] = false,  -- Disable for empty filetypes
    }
    
    -- Fix copilot suggestion ghost text display
    vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])
  end,
}
