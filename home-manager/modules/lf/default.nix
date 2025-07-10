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
} // lib.mkIf (config.fileManager == "lf") {
	xdg.configFile = {
		"lf/colors".source = ./colors;
		"lf/icons".source = ./icons;
	};

	programs.lf = {
		enable = true;
		extraConfig = "on-cd";
	};
}
