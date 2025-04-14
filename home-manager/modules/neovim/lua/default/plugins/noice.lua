return {
	{
		"folke/noice.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			---@diagnostic disable-next-line
			require("noice").setup({
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
					{
						view = "mini",
						filter = {
							event = "msg_showcmd",
							any = {
								{ find = "[mq]$" },
							},
						},
					},
				},
			})
			local macroGroup =
				vim.api.nvim_create_augroup("MacroRecording", { clear = true })
			vim.api.nvim_create_autocmd("RecordingLeave", {
				group = macroGroup,
				callback = function()
					-- Display a message when macro recording stops
					print("Macro recording stopped")
				end,
			})
		end,
	},
}
