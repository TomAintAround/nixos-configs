{
	imports = [
		./commands.nix
		./keybinds.nix
		./opener.nix
		./previewer.nix
		./settings.nix
	];


	xdg.configFile = {
		"lf/colors".source = ./colors;
		"lf/icons".source = ./icons;
		"lf/lfimg".source = ./lfimg;
	};

	programs.lf = {
		enable = true;
		extraConfig = "on-cd";
	};
}
