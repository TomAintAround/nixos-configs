{ pkgs, lib, ... }: {
	programs.neovim.enable = true;
	xdg.configFile."nvim".source = lib.cleanSource ./neovim;

	home.packages = with pkgs; [
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
		taplo # TOMvscode-langservers-extractedL
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
}
