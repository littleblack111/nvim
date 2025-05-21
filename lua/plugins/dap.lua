return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap", 
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	lazy = false,
	config = function()
		local dap = require("configs.dap").setup() 
		
		local dapui = require("dapui")
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
			mappings = {
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						"breakpoints",
						"stacks",
						"watches",
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = 0.25,
					position = "bottom",
				},
			},
			controls = {
				enabled = true,
				element = "repl",
			},
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
		})
		
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		
		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
		sign("DapStopped", { text = "→", texthl = "DiagnosticSignHint", linehl = "Visual", numhl = "" })
		sign("DapBreakpointRejected", { text = "○", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		
		pcall(function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				all_frames = true,
				virt_text_pos = 'eol',
				all_references = true,
				display_callback = function(variable, buf, stackframe, node, options)
					if variable.type == nil then
						return ' = ' .. variable.value
					else
						return ' = ' .. variable.value .. ' (' .. variable.type .. ')'
					end
				end,
			})
		end)
		
		vim.api.nvim_create_user_command("DapCheckAdapters", function()
			require("configs.dap-adapters").install_missing_adapters()
		end, { desc = "Check for missing debug adapters" })
		
		vim.api.nvim_create_user_command("DapInstallAdapter", function()
			local input = vim.fn.input("Enter adapter to install: ")
			if input == "node" or input == "js" or input == "javascript" then
				vim.cmd("MasonInstall node-debug2-adapter")
			elseif input == "python" or input == "py" then
				vim.cmd("!pip install debugpy")
			elseif input == "gdb" or input == "c" or input == "cpp" then
				vim.notify("Please install GDB using your system package manager", vim.log.levels.INFO)
			else
				vim.notify("Unknown adapter: " .. input, vim.log.levels.ERROR)
			end
		end, { desc = "Install a debug adapter" })
		
		require("configs.dap-help").setup()
	end,
}
