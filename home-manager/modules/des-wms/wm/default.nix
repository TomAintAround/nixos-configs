{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./dunst.nix
  ];

  home.packages = with pkgs; [
    (lib.mkIf config.brightness.enable brightnessctl)
    ags
    gnome-disk-utility
    pavucontrol
    polkit_gnome
    rofi # Will be replace by ags in the future
  ];

  services.network-manager-applet.enable = true;
}
