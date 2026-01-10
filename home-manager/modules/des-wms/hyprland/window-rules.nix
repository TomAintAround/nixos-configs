{
  wayland.windowManager.hyprland.settings = {
    windowrule = let
      popup = {
        class,
        width,
        height,
        x,
        y,
      }: {
        name = class;
        "match:class" = class;
        size = "${width} ${height}";
        move = "${x} ${y}";
        animation = "slide windows";
        pin = true;
        suppress_event = "fullscreen";
      };
    in [
      (popup {
        class = "music";
        width = "86%";
        height = "660px";
        x = "7%";
        y = "35";
      })
      (popup {
        class = "btop";
        width = "80%";
        height = "95%";
        x = "10%";
        y = "35";
      })
      {
        name = "ueberzugpp";
        "match:class" = "^ueberzugpp.*";
        no_anim = true;
        no_shadow = true;
        border_size = 0;
      }
    ];
  };
}
