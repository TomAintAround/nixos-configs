{ pkgs, lib, config, ... }: lib.mkIf config.gaming.enable {
	home.packages = with pkgs; [
		heroic
		lutris
		prismlauncher
		protonup
		steam
	];
}
