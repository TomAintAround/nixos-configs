return {
	{
		"folke/zen-mode.nvim",
		enabled = true,
		dependencies = { "folke/twilight.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>z", function()
				require("zen-mode").setup({
					twilight = { enabled = true },
					gitsigns = { enabled = true },
					tmux = { enabled = true },
					todo = { enabled = false },
					kitty = {
						enabled = true,
						font = "+4",
					},
					alacritty = {
						enabled = true,
						font = "14",
					},
					wezterm = {
						enabled = true,
						font = "+4",
					},
				})
				require("zen-mode").toggle()
			end, { desc = "Toggle zen-mode" })
		end,
	},
}
