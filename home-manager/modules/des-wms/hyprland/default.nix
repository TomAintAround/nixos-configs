{ pkgs, inputs, lib, ... }:
let
    inherit (lib) mkOption types;
in {
    imports = [
        ../wm
        ../wayland
        ../wayland/wm.nix

	./environment.nix
	./general.nix
	./keybinds.nix
	./plugins.nix
	./startup.nix
	./window-rules.nix
    ];

    options.wayland.windowManager.hyprland.numOfWorkspaces = mkOption {
    	type = types.int;
	description = "The ammount of workspaces you want to have";
	default = " ";
	example = 10;
    };

    config.wayland.windowManager.hyprland = {
	enable = true;
	numOfWorkspaces = 10;
    };
}
