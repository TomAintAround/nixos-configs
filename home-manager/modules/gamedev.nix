{ pkgs, lib, config, ... }: {
	home.packages = with pkgs; lib.mkIf config.gamedev.enable [
		ardour
		aseprite
		famistudio
		gimp
		godot_4
		krita
		tenacity
	];
}
