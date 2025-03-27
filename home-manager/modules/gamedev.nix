{ pkgs, ... }: {
	home.packages = with pkgs; [
		ardour
		aseprite
		famistudio
		gimp
		godot_4
		krita
		tenacity
	];
}
