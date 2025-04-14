return {
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("todo-comments").setup()
			vim.keymap.set(
				"n",
				"<leader>t",
				vim.cmd.TodoTelescope,
				{ desc = "Fuzzy find todo comments" }
			)
		end,
	},
}
