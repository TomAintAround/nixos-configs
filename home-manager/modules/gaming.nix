{ pkgs, lib, config, ... }: {
	home.packages = with pkgs; lib.mkIf config.gaming.enable [
		bottles
		heroic
		lutris
		prismlauncher
		protonup
		steam
	];
}
