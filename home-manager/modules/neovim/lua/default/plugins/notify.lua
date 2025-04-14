return {
	{
		"rcarriga/nvim-notify",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.notify = require("notify")
		end,
	},
}
