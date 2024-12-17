{ lib, config, ... }:
let
	inherit (lib) mkOption types;
in {
	options.gaming.enable = mkOption {
		type = types.bool;
		description = "Installs gaming apps";
		default = false;
	};
}
