{
	imports = [
		../modules/base.nix
	];

	monitors = [
		{
			name = "eDP-1";
			width = 1920;
			height = 1080;
			refreshRate = 60;
			vrr = false;
			x = 0;
			y = 0;
			scale = 1.25;
			enable = true;
			default = true;
		}
		{
			name = "Unknown-1";
			enable = false;
		}
	];

	brightness.enable = true;
	contentCreation.enable = false;
	fileManager = "yazi";
	gaming.enable = false;
	gamedev.enable = false;
	openrazer.enable = false;
	openrgb.enable = false;
	terminal = "kitty";
}
