{ lib, ... }:
let
	inherit (lib) mkOption types;
in {
	options = {
		brightness.enable = mkOption {
			type = types.bool;
			description = "Enables monitor brightness control modules";
			default = false;
		};

		contentCreation.enable = mkOption {
			type = types.bool;
			description = "Installs content creation apps";
			default = false;
		};

		fileManager = mkOption {
			type = types.str;
			description = "Chooses which file manager to install";
			default = "yazi";
			example = "All available options: yazi, lf";
		};

		gamedev.enable = mkOption {
			type = types.bool;
			description = "Installs gamedev apps";
			default = false;
		};

		gaming.enable = mkOption {
			type = types.bool;
			description = "Installs gaming apps";
			default = false;
		};

		monitors = mkOption {
			type = types.listOf (types.submodule {
				options = {
					name = mkOption {
						type = types.str;
						description = "Name of the monitor";
						default = " ";
						example = "DP-1";
					};

					width = mkOption {
						type = types.int;
						description = "Width of the monitor";
						default = " ";
						example = "1920";
					};

					height = mkOption {
						type = types.int;
						description = "Height of the monitor";
						default = " ";
						example = "1080";
					};

					refreshRate = mkOption {
						type = types.int;
						description = "Refresh rate of the monitor";
						default = 60;
					};

					vrr = mkOption {
						type = types.bool;
						description = "Enables variable refresh rate (your monitor must support it)";
						default = false;
					};

					x = mkOption {
						type = types.int;
						description = "Abscissa of the monitor";
						default = 0;
					};

					y = mkOption {
						type = types.int;
						description = "Ordinate of the monitor";
						default = 0;
					};

					scale = mkOption {
						type = types.float;
						description = "Scale of the monitor";
						default = 1.0;
					};

					enable = mkOption {
						type = types.bool;
						description = "Whether the monitor is enabled or not";
						default = true;
					};
					default = mkOption {
						type = types.bool;
						description = "Whether the monitor is the default or not";
						default = false;
					};
				};
			});
			description = "List of monitors, with the corresponding name, resolution, coordinates and refresh rate";
			default = [ ];
			example = ''
				[
					name = "DP-1"
					width = 1920;
					height = 1080;
					refreshRate = 60;
					x = 0;
					y = 0;
					enable = true;
				]
			'';
		};

		openrazer.enable = mkOption {
			type = types.bool;
			description = "Enables Openrazer related settings";
			default = false;
		};

		openrgb.enable = mkOption {
			type = types.bool;
			description = "Enables OpenRGB related settings";
			default = false;
		};

		terminal = mkOption {
			type = types.str;
			description = "Chooses which terminal to install";
			default = "kitty";
			example = "All available options: alacritty, kitty";
		};
	};
}
