return {
	{
		"catppuccin/nvim",
		enabled = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
			require("catppuccin").setup({ flavour = "mocha" })
		end,
	},
}
