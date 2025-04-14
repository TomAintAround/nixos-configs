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
			exiftool
			eza
			ffmpeg
			ffmpegthumbnailer
			file
			jq
			lynx
			pandoc
			poppler_utils
			ripdrag
			ripgrep
			ueberzugpp
			zip
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
