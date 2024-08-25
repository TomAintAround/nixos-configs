{ config, lib, userVars, ... }: {
    imports = [
	./customOptions/brightness.nix
	./customOptions/gaming.nix
        ./customOptions/monitors.nix
	./customOptions/openrgb.nix
        ./des-wms/hyprland
        ./fish
        ./lf
        ./themes
        ./alacritty.nix
        ./bat.nix
        ./btop.nix
        ./easyeffects.nix
        ./envVariables.nix
        ./extraPkgs.nix
        ./fd.nix
        ./firefox.nix
        ./fzf.nix
	./gaming.nix
        ./git.nix
        ./locales.nix
        ./music.nix
	./openrgb.nix
	./scripts.nix
        ./tmux.nix
        ./trash-cli.nix
        ./udiskie.nix
        ./zoxide.nix
    ];

    programs.home-manager.enable = true;

    nix.gc = {
        frequency = "daily";
        automatic = true;
        options = "--delete-older-than 14d";
    };

    nixpkgs.config.allowUnfree = true;

    home = {
        username = "${userVars.username}";
        homeDirectory = "/home/${userVars.username}";
        stateVersion = "24.05";
        preferXdgDirectories = true;
    };

    xdg = {
        enable = true;
        userDirs = {
            enable = true;
            createDirectories = true;
        };
    };
}