{
	services = {
		xserver = {
			enable = true;
			displayManager.setupCommands = ''
xrandr --auto
timeshift --check &
			'';
			xkb.layout = "pt";
		};
	};
}
