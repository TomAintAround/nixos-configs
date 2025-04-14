return {
	{
		"CRAG666/code_runner.nvim",
		enabled = true,
		config = function()
			require("code_runner").setup({
				mode = "float",
				focus = true,
				term = {
					position = "bot",
					size = 12,
				},
				float = {
					border = "rounded",
					height = 0.8,
					width = 0.8,
					x = 0.5,
					y = 0.5,
				},
				filetype = {
					c = {
						"cd $dir &&",
						"gcc $fileName -Wall -Wextra -o $fileNameWithoutExt -lm -g &&",
						"$dir/$fileNameWithoutExt",
					},
					fish = "fish",
					-- I'm honestly not sure if this even works or not
					ino = function()
						vim.ui.input({
							prompt = "Format: 'file usb fqnb'",
							default = vim.fn.getcwd() .. " /dev/USB0 ",
						}, function(input)
							local arguments =
								vim.split(input, " ", { trimempty = true })
							require("code_runner.commands").run_from_fn(
								"arduino-cli compile --fqbn "
									.. arguments[3]
									.. " "
									.. arguments[1]
									.. " && arduino-cli upload -p "
									.. arguments[2]
									.. " --fqbn "
									.. arguments[3]
									.. " "
									.. arguments[1]
									.. " && arduino-cli monitor -p "
									.. arguments[2]
									.. " --fqbn "
									.. arguments[3]
							)
						end)
					end,
					lua = "lua",
					python = "python -u",
					sh = "bash",
				},
			})
			vim.keymap.set(
				"n",
				"<leader>rr",
				require("code_runner").run_code,
				{ desc = "Run code" }
			)
			vim.keymap.set(
				"n",
				"<leader>rp",
				require("code_runner").run_project,
				{ desc = "Run project" }
			)
		end,
	},
}
