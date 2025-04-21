{ pkgs, ... }: {
	programs.neovim.enable = true;

	home = {
		packages = with pkgs; [
			# Requirements
			curl
			fd
			gccgo14
			gnumake
			man-pages
			ripgrep

			# LSPs
			arduino-language-server
			basedpyright
			bash-language-server
			clang-tools
			fish-lsp
			lua-language-server
			marksman
			nixd
			vscode-langservers-extracted
			taplo # TOML
			yaml-language-server

			# Formatters
			jq
			prettierd
			ruff # Python
			stylua
			yamlfmt

			# Debuggers
			bashdb
			completely # dependency of bashdb
			nodejs_23 # required for lua debugger
		];
		# I'm absolutely not configuring neovim through nix,
		# so here's my solution that doesn't rely on sourcing
		# (which makes the configuration read-only)
		sessionVariables = {
			NVIM_APPNAME = "home-manager/modules/neovim";
		};
	};
}
