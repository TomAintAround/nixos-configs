{
  lib,
  config,
  ...
}: {
  programs.hyprlock = lib.mkIf (config.displayServer.wayland.enable && config.wm.enable) {
    enable = true;
    settings = {
      general.hide_cursor = true;

      auth.fingerprint.enabled = true;

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = ["fade, 1, 3, linear" "inputField, 1, 1, linear"];
      };

      background = {
        path = "${config.xdg.cacheHome}/swww/wallpaper";
        blur_passes = 2;
        blur_size = 7;
      };

      input-field = {
        size = "450, 50";
        font_family = "${config.gtk.font.name} Italic";
        fade_on_empty = false;
        placeholder_text = "Password";
        swap_font_color = true;
        position = "0, -200";
        shadow_color = "rgba(00000080)";
        shadow_passes = 2;
        shadow_size = 5;
      };

      label = {
        text = "$TIME";
        font_size = 128;
        font_family = config.gtk.font.name;
        position = "0, 100";
        shadow_color = "rgba(00000080)";
        shadow_passes = 2;
        shadow_size = 5;
      };
    };
  };
}
