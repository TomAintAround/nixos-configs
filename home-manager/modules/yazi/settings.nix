{ lib, config, ... }: lib.mkIf (config.fileManager == "yazi") {
	programs.yazi.settings = {
		mgr = {
			ratio = [ 1 2 3 ];
			sort_by = "natural";
			sort_reverse = false;
			sort_dir_first = true;
			sort_translit = true;
			linemode = "size";
			show_hidden = true;
			show_symlink = true;
			scrolloff = 8;
			title_format = "{cwd}";
		};
		preview = {
			wrap = "no";
			max_width = 1920;
			max_height = 1080;
			tab_size = 4;
		};
		opener.play = [
			{ run = "$VIDEO_PLAYER \"$@\""; orphan = true; desc = "Play"; }
		];
		input.cursor_blink = true;
		plugin = {
			prepend_previewers = [
				{ name = "*.csv"; run = "rich-preview"; }
				{ name = "*.md"; run = "rich-preview"; }
				{ name = "*.rst"; run = "rich-preview"; }
				{ name = "*.ipynb"; run = "rich-preview"; }
				{ name = "*.json"; run = "rich-preview"; }
				{ mime = "audio/*"; run = "exifaudio"; }
			];
			prepend_fetchers = [
				{ id = "git"; name = "*"; run = "git"; }
				{ id = "git"; name = "*/"; run = "git"; }
			];
		};
	};
}
