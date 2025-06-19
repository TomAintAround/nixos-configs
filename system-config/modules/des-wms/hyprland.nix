{
	imports = [
		./wayland.nix
		./wm.nix
	];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
}
