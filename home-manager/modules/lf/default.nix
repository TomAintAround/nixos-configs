{
	imports = [
		./commands.nix
		./keybinds.nix
		./opener.nix
		./previewer.nix
		./settings.nix

		./lfimg.nix
		./vidthumb.nix
	];

	xdg.configFile = {
		"lf/colors".source = ./colors;
		"lf/icons".source = ./icons;
	};

	programs.lf = {
		enable = true;
		extraConfig = "on-cd";
	};
}
