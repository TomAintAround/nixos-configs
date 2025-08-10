{pkgs, ...}: {
  home.packages = with pkgs; [
    clipman # Clipboard manager
    swww # Wallpaper manager
    wl-clipboard # Copy/Paste
  ];
}
