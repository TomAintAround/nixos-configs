{
  pkgs,
  lib,
  config,
  ...
}: {
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      git
      home-manager
      libnotify
      libsecret
    ];
  };

  programs = {
    nix-ld.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services.flatpak.enable = true;

  xdg.portal.enable = lib.mkIf config.services.flatpak.enable (lib.mkForce true);
  xdg.portal.extraPortals = lib.mkIf config.services.flatpak.enable (lib.mkForce [pkgs.xdg-desktop-portal-gtk]);
}
