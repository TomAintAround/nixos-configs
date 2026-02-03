{
  pkgs,
  lib,
  config,
  ...
}: {
  services.dunst = lib.mkIf config.wm.enable {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        follow = "none";
        indicate_hidden = true;
        notification_limit = 20;
        sort = true;
        show_age_threshold = 60;
        show_indicators = true;
        dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst";
        browser = "/run/current-system/sw/bin/xdg-open";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        ignore_dbusclose = false;

        stack_duplicates = true;
        hide_duplicate_count = false;

        width = "(100, 400)";
        height = "300";
        origin = "top-right";
        offset = "40x10";
        scale = 0;
        transparency = 0;
        padding = 15;
        horizontal_padding = 15;
        text_icon_padding = 20;
        frame_width = 0;
        separator_height = 2;
        gap_size = 30;
        line_height = 0;

        corner_radius = 10;
        corners = "all";

        progress_bar = true;
        progress_bar_height = 15;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 290;
        progress_bar_corner_radius = 5;
        progress_bar_corners = "all";

        icon_corner_radius = 10;
        icon_corners = "all";
        enable_recursive_icon_lookup = true;
        icon_theme = "Papirus-Dark";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 128;

        font = "Inter 13";
        markup = "full";
        format = "<b>%a</b>\\n%s\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        ignore_newline = false;
        ellipsize = "middle";

        sticky_history = true;
        history_length = 20;

        force_xwayland = false;
        force_xinerama = false;

        mouse_left_click = "close_current";
        mouse_right_click = "do_action, close_current";
        mouse_middle_click = "close_all";

        per_monitor_dpi = false;
      };

      urgency_low = {
        #background = "#222222";
        #foreground = "#888888";
        timeout = 10;
        #default_icon = "/path/to/icon";
      };

      urgency_normal = {
        #background = "#285577";
        #foreground = "#ffffff";
        timeout = 10;
        override_pause_level = 30;
        #default_icon = "/path/to/icon";
      };

      urgency_critical = {
        #background = "#900000";
        #foreground = "#ffffff";
        #frame_color = "#ff0000";
        timeout = 0;
        override_pause_level = 60;
        #default_icon = "/path/to/icon";
      };
    };
  };

  systemd.user.services."dunst" = {
    Service.ExecStart = lib.mkForce "${pkgs.dunst}/bin/dunst --config ~/.config/dunst/dunstrc";
  };
}
