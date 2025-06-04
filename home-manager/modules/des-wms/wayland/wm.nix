{ pkgs, ... }: {
	home.packages = with pkgs; [
		clipman # Clipboard manager
		grimblast # Screenshot utility
		swww # Wallpaper manager
		wl-clipboard # Copy/Paste
	];
}
