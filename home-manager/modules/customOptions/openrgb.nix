{ lib, config, ... }:
let
    inherit (lib) mkOption types;
in {
    options.openrgb.enable = mkOption {
	type = types.bool;
	description = "Installs OpenRGB plugins";
	default = false;
    };
}
