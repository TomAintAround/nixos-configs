{ pkgs, ... }: {
	programs.lazygit = {
		enable = true;
		settings = {
			gui = {
				timeFormat = "02 Jan 2006";
				shortTimeFormat = "03:04";
				nerdFontsVersion = "3";
				filterMode = "fuzzy";
			};
			git = {
				paging.pager = "${pkgs.delta}/bin/delta --paging=never --features \"catppuccin-mocha\" --line-numbers --navigate --side-by-side --true-color=always";
				log.showWholeGraph = true;
			};
			update.method = "never";
		};
	};
}
