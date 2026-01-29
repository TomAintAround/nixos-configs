{
  lib,
  userVars,
  ...
}: {
  imports = [
    ./customOptions.nix
    ./des-wms/hyprland
    ./fish
    ./mpv
    ./themes
    ./tmux
    ./yazi
    ./alacritty.nix
    ./bat.nix
    ./btop.nix
    ./contentCreation.nix
    ./direnv.nix
    ./easyeffects.nix
    ./envVariables.nix
    ./extraPkgs.nix
    ./fd.nix
    ./firefox.nix
    ./fzf.nix
    ./gamedev.nix
    ./gaming.nix
    ./git.nix
    ./kdeconnect.nix
    ./kitty.nix
    ./lazygit.nix
    ./librewolf.nix
    ./locales.nix
    ./music.nix
    ./neovim.nix
    ./scripts.nix
    ./trash-cli.nix
    ./udiskie.nix
    ./zoxide.nix
  ];

  programs.home-manager.enable = true;

  nix.gc = {
    dates = "daily";
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
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = ["librewolf.desktop"];
        "x-scheme-handler/https" = ["librewolf.desktop"];
      };
    };
  };

  programs.man.generateCaches = lib.mkForce false;
}
