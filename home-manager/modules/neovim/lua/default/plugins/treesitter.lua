return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			modules = {},
			highlight = {
				enable = true,
				---@diagnostic disable-next-line
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats =
						---@diagnostic disable-next-line
						pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
					return false
				end,
				additional_vim_regex_highlighting = true,
			},
		},
	},
	{
		"tree-sitter-grammars/tree-sitter-hyprlang",
		enabled = true,
		config = function()
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		enabled = true,
	},
}
