local dap_loaded, dap = pcall(require, "dap")
if not dap_loaded then return end

local dapui_loaded, dapui = pcall(require, "dapui") 
if not dapui_loaded then return end

local map = vim.keymap.set

map('n', '<F5>', function() dap.continue() end, { desc = "Debug: Continue/Start" })
map('n', '<F10>', function() dap.step_over() end, { desc = "Debug: Step Over" })
map('n', '<F11>', function() dap.step_into() end, { desc = "Debug: Step Into" })
map('n', '<F12>', function() dap.step_out() end, { desc = "Debug: Step Out" })

map('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Debug: Set Conditional Breakpoint" })
map('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Debug: Set Log Point" })

map('n', '<leader>dr', function() dap.repl.open() end, { desc = "Debug: Open REPL" })
map('n', '<leader>dt', function() dapui.toggle() end, { desc = "Debug: Toggle UI" })

map('n', '<leader>dc', function() dap.run_to_cursor() end, { desc = "Debug: Run to Cursor" })
map('n', '<leader>dC', function() dap.terminate() end, { desc = "Debug: Terminate Session" })
map('n', '<leader>dv', function() dapui.eval(vim.fn.input('Expression: ')) end, { desc = "Debug: Evaluate Expression" })
map('n', '<leader>dR', function() dap.clear_breakpoints() end, { desc = "Debug: Clear Breakpoints" })

map('v', '<leader>dv', function() 
  local start_line, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]
  local end_line, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  
  if #lines == 0 then
    return
  elseif #lines == 1 then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end
  
  local expression = table.concat(lines, "\n")
  dapui.eval(expression)
end, { desc = "Debug: Evaluate Selection" })
