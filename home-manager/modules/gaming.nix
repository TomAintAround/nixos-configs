{ pkgs, lib, config, ... }: lib.mkIf config.gaming.enable {
	home.packages = with pkgs; [
		(heroic.override {
			extraPkgs = pkgs: [
				gamemode
				gamescope
				egl-wayland
			];
		})
		lutris
		prismlauncher
		protonup
		rpcs3
		steam
		wineWowPackages.stable
	];
}
