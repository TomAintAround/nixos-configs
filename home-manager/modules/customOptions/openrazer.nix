{ lib, config, ... }:
let
    inherit (lib) mkOption types;
in {
    options.openrazer.enable = mkOption {
	type = types.bool;
	description = "Enables Openrazer related settings";
	default = false;
    };
}
