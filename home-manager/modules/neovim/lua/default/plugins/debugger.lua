return {
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			---@diagnostic disable-next-line: missing-fields
			require("nvim-dap-virtual-text").setup({
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if
						name:match("secret")
						or name:match("api")
						or value:match("secret")
						or value:match("api")
					then
						return "*****"
					end

					if #variable.value > 15 then
						return " "
							.. string.sub(variable.value, 1, 15)
							.. "... "
					end

					return " " .. variable.value
				end,
			})
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters = {
				bashdb = {
					type = "executable",
					command = "bashdb",
					name = "bashdb",
				},
				gdb = {
					type = "executable",
					command = "gdb",
					args = {
						"--interpreter=dap",
						"--eval-command",
						"set print pretty on",
					},
				},
				["local-lua"] = {
					type = "executable",
					command = "node",
					args = {
						os.getenv("HOME")
							.. "/.vscode/extensions/tomblind.local-lua-debugger-vscode-0.3.3/extension/debugAdapter.js",
					},
				},
			}
			dap.configurations = {
				c = {
					{
						name = "Launch",
						type = "gdb",
						request = "launch",
						console = "integratedTerminal",
						cwd = "${fileDirname}",
						program = function()
							return vim.fn.input(
								"Path to executable: ",
								vim.fn.getcwd() .. "/",
								"file"
							)
						end,
						stopAtBeginningOfMainSubprogram = false,
					},
					{
						name = "Select and attach to process",
						type = "gdb",
						request = "attach",
						console = "integratedTerminal",
						program = function()
							return vim.fn.input(
								"Path to executable: ",
								vim.fn.getcwd() .. "/",
								"file"
							)
						end,
						pid = function()
							local name =
								vim.fn.input("Executable name (filter): ")
							return require("dap.utils").pick_process({
								filter = name,
							})
						end,
						cwd = "${workspaceFolder}",
					},
				},
				sh = {
					{
						type = "bashdb",
						request = "launch",
						name = "Launch file",
						showDebugOutput = true,
						pathBashdb = vim.fn.exepath("bashdb"),
						pathBashdbLib = vim.fn.fnamemodify(
							vim.fn.resolve(vim.fn.exepath("bashdb")),
							":p:h:h"
						) .. "/share/bashdb",
						trace = true,
						file = "${file}",
						program = "${file}",
						cwd = "${workspaceFolder}",
						pathCat = "cat",
						pathBash = vim.fn.exepath("bash"),
						pathMkfifo = vim.fn.exepath("mkfifo"),
						pathPkill = vim.fn.exepath("pkill"),
						args = {},
						env = {},
						terminalKind = "integrated",
					},
				},
				lua = {
					{
						name = "Current file (local-lua-dbg, lua)",
						type = "local-lua",
						request = "launch",
						cwd = "${workspaceFolder}",
						program = {
							lua = "lua5.2",
							file = "${file}",
						},
						args = {},
					},
				},
			}
			require("dap-python").setup()

			vim.keymap.set("n", "<F5>", function()
				require("dap").restart()
			end, { desc = "Restart debugger" })
			vim.keymap.set("n", "<F6>", function()
				require("dap").continue()
			end, { desc = "Start/continue debugger" })
			vim.keymap.set("n", "<F7>", function()
				require("dap").terminate()
			end, { desc = "Stop debugger" })
			vim.keymap.set("n", "<F9>", function()
				require("dap").step_over()
			end, { desc = "Step over in debugger" })
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_back()
			end, { desc = "Step back in debugger" })
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "Step into in debugger" })
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "Step out in debugger" })
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").set_breakpoint(
					nil,
					nil,
					vim.fn.input("Log point message: ")
				)
			end, { desc = "Set breakpoint with message" })
		end,
	},
}
