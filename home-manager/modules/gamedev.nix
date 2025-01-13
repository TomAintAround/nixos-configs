{ pkgs, ... }: {
	home.packages = with pkgs; [
		ardour
		gimp
		godot_4-mono
		krita
		tenacity
	];
}
