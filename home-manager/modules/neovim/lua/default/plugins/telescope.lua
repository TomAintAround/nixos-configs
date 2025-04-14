return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {},
				},
			})
			require("telescope").load_extension("fzf")

			vim.keymap.set(
				"n",
				"<leader>ff",
				require("telescope.builtin").find_files,
				{ desc = "Find files" }
			)
			vim.keymap.set(
				"n",
				"<leader>fd",
				require("telescope.builtin").diagnostics,
				{ desc = "Find all diagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>fg",
				require("telescope.builtin").live_grep,
				{ desc = "Find text" }
			)
			vim.keymap.set(
				"n",
				"<leader>fh",
				require("telescope.builtin").help_tags,
				{ desc = "Find help pages" }
			)
			vim.keymap.set(
				"n",
				"<leader>fk",
				require("telescope.builtin").keymaps,
				{ desc = "Find keymaps" }
			)
			vim.keymap.set(
				"n",
				"<leader>gc",
				require("telescope.builtin").git_commits,
				{ desc = "Find git commits" }
			)
			vim.keymap.set(
				"n",
				"<leader>gb",
				require("telescope.builtin").git_branches,
				{ desc = "Find git branches" }
			)
			vim.keymap.set(
				"n",
				"<leader>gs",
				require("telescope.builtin").git_status,
				{ desc = "Find changes in repo" }
			)
		end,
	},
}
