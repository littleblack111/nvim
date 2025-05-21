-- This file contains helpers for installing debug adapters

local M = {}

-- Function to check if a command exists in the system
local function command_exists(cmd)
  local handle = io.popen("command -v " .. cmd .. " > /dev/null 2>&1 && echo 'true' || echo 'false'")
  local result = handle:read("*l")
  handle:close()
  return result == "true"
end

-- Function to check if a path exists
local function path_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end

M.check_debug_adapters = function()
  local missing_adapters = {}
  
  -- Check for GDB (C/C++/Rust debugging)
  if not command_exists("gdb") then
    table.insert(missing_adapters, {
      name = "GDB (for C/C++/Rust debugging)",
      install_cmd = "sudo apt-get install gdb"
    })
  end
  
  -- Check for debugpy (Python debugging)
  local python_cmd = command_exists("python3") and "python3" or "python"
  local handle = io.popen(python_cmd .. " -c \"import debugpy; print('true')\" 2> /dev/null || echo 'false'")
  local debugpy_exists = handle:read("*l") == "true"
  handle:close()
  
  if not debugpy_exists then
    table.insert(missing_adapters, {
      name = "debugpy (for Python debugging)",
      install_cmd = python_cmd .. " -m pip install debugpy"
    })
  end
  
  -- Check for node-debug2-adapter (JavaScript/TypeScript debugging)
  local mason_path = vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter"
  if not path_exists(mason_path) then
    table.insert(missing_adapters, {
      name = "node-debug2-adapter (for JavaScript/TypeScript debugging)",
      install_cmd = "npm install -g node-debug2-adapter || yarn global add node-debug2-adapter"
    })
  end
  
  return missing_adapters
end

M.install_missing_adapters = function()
  local missing = M.check_debug_adapters()
  
  if #missing == 0 then
    print("All required debug adapters are installed!")
    return
  end
  
  print("The following debug adapters are missing:")
  for i, adapter in ipairs(missing) do
    print(i .. ". " .. adapter.name)
    print("   Install command: " .. adapter.install_cmd)
  end
  
  print("\nPlease install the missing adapters to use debugging with those languages.")
end

return M
