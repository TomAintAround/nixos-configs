{ pkgs, config, ... }: {
	imports = [
		./commands.nix
		./keybindings.nix
		./opener.nix
		./previewer.nix
		./settings.nix
	];

	home = {
		packages = with pkgs; [
			atool
			bat
			exiftool
			eza
			ffmpeg
			ffmpegthumbnailer
			file
			fzf
			jq
			lynx
			pandoc
			poppler_utils
			ripdrag
			ripgrep
			tmux
			trash-cli
			ueberzugpp
			zip
			zoxide
		];
	};

	xdg.configFile = {
		"lf/colors".source = ./colors;
		"lf/icons".source = ./icons;
	};

	programs.lf = {
		enable = true;
		extraConfig = "on-cd";
	};
}
