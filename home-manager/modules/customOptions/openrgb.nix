{ lib, config, ... }:
let
	inherit (lib) mkOption types;
in {
	options.openrgb.enable = mkOption {
		type = types.bool;
		description = "Enables OpenRGB related settings";
		default = false;
	};
}
