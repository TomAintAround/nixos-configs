{ lib, config, ... }: lib.mkIf (config.fileManager == "lf") {
	programs.lf.settings = {
		shell = "bash";
		shellopts = "-eu";
		ifs = "\\n";
		scrolloff = 5;
		icons = true;
		drawbox = true;
		hidden = true;
		mouse = true;
		relativenumber = true;
		number = true;
		info = "size";
		dircounts = true;
		period = 1;
		incsearch = true;
		incfilter = true;
		truncatechar = "...";
		tabstop = 4;
		cleaner = "${config.xdg.configHome}/lf/cleaner.bash";
		previewer = "${config.xdg.configHome}/lf/previewer.bash";
		cursorpreviewfmt = "\\033[4m";
		infotimefmtnew = "01/02 15:04";
		infotimefmtold = "01/02/2006";
		errorfmt = "\\033[1;31m";
		promptfmt = ''
\033[38;2;49;50;68m\033[0m
\033[48;2;49;50;68m\033[38;2;205;214;244m \033[0m
\033[38;2;49;50;68m\033[48;2;69;71;90m\033[0m
\033[48;2;69;71;90m\033[38;2;205;214;244m %w\033[0m
\033[38;2;69;71;90m\033[0m
 \033[38;4;205;214;244m%f\033[0m
		'';
	};
}
