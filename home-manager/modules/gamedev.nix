{ pkgs, lib, config, ... }: lib.mkIf config.gamedev.enable {
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
