{ pkgs, lib, config, ... }: {
	home.packages = with pkgs; lib.mkIf config.gaming.enable [
		heroic
		lutris
		prismlauncher
		protonup
		steam
	];
}
