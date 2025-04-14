return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"b0o/schemastore.nvim",
				ft = "json",
			},
			"saghen/blink.cmp",
			"stevearc/conform.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			local languages = {
				{
					extensions = { "ino" },
					lsp = "arduino_language_server",
					lspExec = "arduino-language-server",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "py" },
					lsp = "basedpyright",
					lspExec = "basedpyright",
					lspSettings = { capabilities = {} },
					formatters = { "ruff" },
				},
				{
					extensions = { "bash", "sh" },
					lsp = "bashls",
					lspExec = "bash-language-server",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "c", "h", "cpp", "hpp" },
					lsp = "clangd",
					lspExec = "clangd",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "css", "scss" },
					lsp = "cssls",
					lspExec = "vscode-css-language-server",
					lspSettings = { capabilities = {} },
					formatters = { "prettierd" },
				},
				{
					extensions = { "fish" },
					lsp = "fish_lsp",
					lspExec = "fish-lsp",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "html" },
					lsp = "html",
					lspExec = "vscode-html-language-server",
					lspSettings = { capabilities = {} },
					formatters = { "prettierd" },
				},
				{
					extensions = { "json" },
					lsp = "jsonls",
					lspExec = "vscode-json-language-server",
					lspSettings = {
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
						capabilities = {},
					},
					formatters = { "jq" },
				},
				{
					extensions = { "lua" },
					lsp = "lua_ls",
					lspExec = "lua-language-server",
					lspSettings = { capabilities = {} },
					formatters = { "stylua" },
				},
				{
					extensions = { "md" },
					lsp = "marksman",
					lspExec = "marksman",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "nix" },
					lsp = "nixd",
					lspExec = "nixd",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "toml" },
					lsp = "taplo",
					lspExec = "taplo",
					lspSettings = { capabilities = {} },
					formatters = {},
				},
				{
					extensions = { "yaml", "yml" },
					lsp = "yamlls",
					lspExec = "yaml-language-server",
					lspSettings = { capabilities = {} },
					formatters = { "yamlfmt" },
				},
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			for _, language in pairs(languages) do
				if vim.fn.executable(language.lspExec) == 1 then
					table.insert(
						language.lspSettings.capabilities,
						capabilities
					)
					require("lspconfig")[language.lsp].setup(
						language.lspSettings
					)
				end
			end

			local conformSetup = {
				formatters_by_ft = {},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_format = "fallback",
				},
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,
				notify_no_formatters = true,
			}
			for _, language in pairs(languages) do
				for _, extension in pairs(language.extensions) do
					conformSetup.formatters_by_ft[extension] =
						language.formatters
				end
			end
			require("conform").setup(conformSetup)

			local lspGroup =
				vim.api.nvim_create_augroup("Lsp", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = lspGroup,
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>lrn",
						vim.lsp.buf.rename,
						{ desc = "Rename" }
					)
					vim.keymap.set(
						"n",
						"<leader>lca",
						vim.lsp.buf.code_action,
						{ desc = "View code actions" }
					)
					vim.keymap.set(
						"n",
						"<leader>lsh",
						vim.lsp.buf.signature_help,
						{ desc = "View signature help" }
					)
					vim.keymap.set(
						"n",
						"<leader>lrf",
						vim.lsp.buf.references,
						{ desc = "View references" }
					)
					vim.keymap.set(
						"n",
						"<leader>ldf",
						vim.lsp.buf.definition,
						{ desc = "View definition" }
					)
					vim.keymap.set(
						"n",
						"<leader>lip",
						vim.lsp.buf.implementation,
						{ desc = "View implementation" }
					)
				end,
			})

			require("fidget").setup({})
		end,
	},
}
