-- This file contains functions to help users configure and troubleshoot DAP

local M = {}

-- Print a styled help message about DAP usage
function M.show_help()
  local help_text = [[
  # DAP Debugging Help
  
  ## Available Commands
  - `:DapCheckAdapters`     - Check if all debug adapters are installed
  - `:DapInstallAdapter`    - Install a specific debug adapter
  - `:DapHelp`              - Show this help message
  
  ## Common Keybindings
  - `<F5>`                 - Continue/Start Debugging
  - `<F10>`                - Step Over
  - `<F11>`                - Step Into
  - `<F12>`                - Step Out
  - `<leader>db`           - Toggle Breakpoint
  - `<leader>dB`           - Set Conditional Breakpoint
  - `<leader>dl`           - Set Log Point
  - `<leader>dt`           - Toggle UI
  - `<leader>dr`           - Open REPL
  - `<leader>dc`           - Run to cursor
  - `<leader>dC`           - Terminate debugging
  - `<leader>dv`           - Evaluate expression (use with visual selection too)
  
  ## Language Support
  - C/C++/Rust: GDB is used as the adapter
  - Python: debugpy is used as the adapter
  - JavaScript/TypeScript: node-debug2-adapter is used
  
  ## Common Issues
  1. Make sure debug adapters are installed (use `:DapCheckAdapters`)
  2. For C/C++, make sure the program is compiled with debug symbols
  3. For Python, make sure debugpy is installed in the active environment
  4. For JavaScript, make sure node-debug2-adapter is installed
  
  ## For more help
  - See `:help dap`
  - See `:help dap-ui`
  ]]

  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Set buffer name
  vim.api.nvim_buf_set_name(buf, "DAP Help")

  -- Split the help text by newlines and set lines in buffer
  local lines = {}
  for line in help_text:gmatch "[^\r\n]+" do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Open buffer in a new window
  vim.api.nvim_command "split"
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  -- Set window options
  vim.api.nvim_win_set_option(win, "number", false)
  vim.api.nvim_win_set_option(win, "relativenumber", false)

  -- Define keymapping to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })

  return buf
end

-- Function to register commands
function M.setup()
  vim.api.nvim_create_user_command("DapHelp", function()
    M.show_help()
  end, { desc = "Show DAP help" })
end

return M
