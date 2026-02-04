{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./catppuccin.nix];

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      size = 11.0;
      package = pkgs.inter;
    };
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    activation.link-fonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ln -s /run/current-system/sw/share/X11/fonts ${config.xdg.dataHome}/fonts 2>/dev/null
    '';

    sessionVariables = let
      monitor = builtins.elemAt (builtins.filter (m: m.default) config.monitors) 0;
      inherit (monitor) scale;
    in {
      GTK_THEME = config.gtk.theme.name;
      ICON_THEME = config.gtk.iconTheme.name;
      HYPRCURSOR_THEME = config.home.pointerCursor.name;
      HYPRCURSOR_SIZE = 20;
      KRITA_NO_STYLE_OVERRIDE = 1;
      GDK_SCALE = scale;
      QT_AUTO_SCREEN_SCALE_FACTOR = toString (1.0 / scale);
      QT_SCALE_FACTOR = toString (1.0 / scale);
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
    qt6ctSettings = {
      Appearance = {
        style = "kvantum";
        icon_theme = config.gtk.iconTheme.name;
        standar_dialogs = "xdgdesktopportal";
      };
      Fonts = {
        general = "\"${config.gtk.font.name},${toString (builtins.floor config.gtk.font.size)}\"";
        fixed = "\"${config.gtk.font.name},${toString (builtins.floor config.gtk.font.size)}\"";
      };
    };
    qt5ctSettings = config.qt.qt6ctSettings;
  };

  wayland.windowManager.hyprland.settings.plugin.hyprfocus.bar_text_font = config.gtk.font.name;
}
