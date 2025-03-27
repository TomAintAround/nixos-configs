{ pkgs, ... }: {
	home = {
		packages = with pkgs; [
			hyprpicker # Color picker
		];
		sessionVariables.NIXOS_OZONE_WL = 1;
	};
}
