{ pkgs, ... }: {
	home.packages = with pkgs; [
		hyprpicker # Color picker
	];
}
