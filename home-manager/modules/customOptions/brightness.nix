{ lib, ... }:
let
	inherit (lib) mkOption types;
in {
	options.brightness.enable = mkOption {
		type = types.bool;
		description = "Enables monitor brightness control modules";
		default = false;
	};
}
