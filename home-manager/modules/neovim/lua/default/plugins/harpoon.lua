return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Opens harpoon list" })
			vim.keymap.set("n", "<leader>hA", function()
				harpoon:list():prepend()
			end, { desc = "Prepends a mark in the list" })
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Appends a mark in the list" })

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-j>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-k>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-l>", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<leader><C-h>", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<leader><C-j>", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<leader><C-k>", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<leader><C-l>", function()
				harpoon:list():replace_at(4)
			end)
		end,
	},
}
