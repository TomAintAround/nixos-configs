local options = {
	number = true,
	relativenumber = true,
	numberwidth = 1,
	cmdheight = 1,
	autoindent = true,
	smartindent = true,
	tabstop = 4,
	softtabstop = 4,
	smarttab = true,
	shiftwidth = 4,
	expandtab = false,
	wrap = false,
	linebreak = true,
	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	termguicolors = true,
	swapfile = false,
	backup = false,
	writebackup = false,
	undodir = os.getenv("XDG_STATE_HOME") .. "/undodir",
	undofile = true,
	scrolloff = 8,
	sidescrolloff = 8,
	signcolumn = "yes",
	updatetime = 50,
	conceallevel = 0,
	mouse = "a",
	completeopt = { "menuone", "preview" },
	clipboard = "unnamedplus",
	pumheight = 10,
	pumblend = 10,
	showtabline = 1,
	smartcase = true,
	splitbelow = true,
	splitright = true,
	timeoutlen = 1000,
	cursorline = true,
	fileencoding = "utf-8",
	showmode = true,
	title = true,
	titlestring = "Neovim: %f%r%m",
	icon = true,
	iconstring = "",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = " "
local keymaps = {
	{"n", "J", "mzJ'z"},
	{"n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]},
	{"n", "<leader>t", "<cmd>%retab!<CR>"},
	{"n", "<C-u>", "<C-u>zz"},
	{"n", "<C-d>", "<C-d>zz"},

	{"v", "<leader>p", [["_dP]]},
	{{"n", "v"}, "<leader>d", "\"_d"},

	{"v", "K", ":m '<-2<CR>gv=gv"},
	{"v", "J", ":m '>+1<CR>gv=gv"},
	{"v", "<", "<gv^"},
	{"v", ">", ">gv^"},
}



for _, keymap in pairs(keymaps) do
	vim.keymap.set(keymap[1], keymap[2], keymap[3])
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
	end,
})

autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage", "typst", "plaintext", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

autocmd('FileType', {
	pattern = { 'blame', 'checkhealth', 'dbout', 'fugitive', 'fugitiveblame',
		'gitsigns-blame', 'grug-far', 'help', 'httpResult', 'lspinfo',
		'neotest-output', 'neotest-output-panel', 'neotest-summary', 'notify',
		'PlenaryTestPopup', 'qf', 'spectre_panel', 'startuptime', 'tsplayground',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set('n', 'q', function()
				vim.cmd('close')
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
			})
		end)
	end,
})
