{pkgs, ...}: {
  home.packages = with pkgs; [
    clipman # Clipboard manager
    (flameshot.override {enableWlrSupport = true;}) # Screenshot utility
    swww # Wallpaper manager
    wl-clipboard # Copy/Paste
  ];
}
