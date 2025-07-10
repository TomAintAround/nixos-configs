{ lib, config, ... }: {
	imports = [
		./commands.nix
		./keybinds.nix
		./opener.nix
		./previewer.nix
		./settings.nix

		./lfimg.nix
		./vidthumb.nix
	];

	xdg.configFile = lib.mkIf (config.fileManager == "lf") {
		"lf/colors".source = ./colors;
		"lf/icons".source = ./icons;
	};

	programs.lf = {
		enable = config.fileManager == "lf";
		extraConfig = "on-cd";
	};
}
