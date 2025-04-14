local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	pattern = {
		"gitcommit",
		"markdown",
		"NeogitCommitMessage",
		"typst",
		"plaintext",
		"text",
	},
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

local yankGroup = vim.api.nvim_create_augroup("YankText", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	group = yankGroup,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("FileType", {
	pattern = {
		"blame",
		"checkhealth",
		"dbout",
		"fugitive",
		"fugitiveblame",
		"gitsigns-blame",
		"grug-far",
		"help",
		"httpResult",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"PlenaryTestPopup",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
			})
		end)
	end,
})
