{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./apps/dunst.nix
    ./apps/hyprlock.nix
    ./apps/hyprsunset.nix
  ];

  home = {
    packages = with pkgs;
      lib.optionals config.displayServer.wayland.enable [
        hyprpicker # Color picker
      ]
      ++ lib.optionals (config.displayServer.wayland.enable && config.wm.enable) [
        clipman # Clipboard manager
        swww # Wallpaper manager
        wl-clipboard # Copy/Paste
      ]
      ++ lib.optionals config.wm.enable [
        gnome-disk-utility
        pavucontrol
        polkit_gnome
        rofi
      ]
      ++ lib.optionals config.brightness.enable [
        brightnessctl
      ];
    sessionVariables.NIXOS_OZONE_WL = lib.mkIf config.displayServer.wayland.enable 1;
  };

  services.network-manager-applet.enable = lib.mkDefault config.wm.enable;
}
