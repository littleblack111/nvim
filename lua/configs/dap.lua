local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  }

  dap.configurations.c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      args = function()
        local args_str = vim.fn.input "Arguments: "
        return vim.split(args_str, " ", { trimempty = true })
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
    {
      name = "Select and attach to process",
      type = "gdb",
      request = "attach",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      pid = function()
        local name = vim.fn.input "Executable name (filter): "
        return require("dap.utils").pick_process { filter = name }
      end,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Attach to gdbserver :1234",
      type = "gdb",
      request = "attach",
      target = "localhost:1234",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
  }

  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.cpp

  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        local venv_path = os.getenv "VIRTUAL_ENV"
        if venv_path then
          return venv_path .. "/bin/python"
        end
        return "/usr/bin/python3"
      end,
    },
  }

  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
  }

  dap.configurations.javascript = {
    {
      name = "Launch",
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }

  dap.configurations.typescript = dap.configurations.javascript

  return dap
end

return M
