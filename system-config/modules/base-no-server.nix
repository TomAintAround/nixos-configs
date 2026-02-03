{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./base.nix
    ./hardware/graphics.nix
    ./hardware/sound.nix
    ./sddm
  ];

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services = {
    flatpak.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "pt";
    };
  };

  xdg.portal = {
    enable = lib.mkIf config.services.flatpak.enable (lib.mkForce true);
    extraPortals = lib.mkIf config.services.flatpak.enable (lib.mkForce [pkgs.xdg-desktop-portal-gtk]);
  };

  fonts = {
    packages = with pkgs; [
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      source-han-sans
      source-han-serif
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrainsMono Regular Nerd Font"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
    fontDir.enable = true;
  };

  security.polkit.enable = true;
}
