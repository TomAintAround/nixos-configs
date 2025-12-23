{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitorv2 = builtins.map (m: let
      mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
      position = "${toString m.x}x${toString m.y}";
    in
      {
        output = m.name;
      }
      // (
        if m.enable
        then {
          inherit mode position;
          inherit (m) scale;
          transform = 0;
        }
        else {
          disabled = true;
        }
      )) (config.monitors);

    general = {
      border_size = 2;
      gaps_in = 2;
      gaps_out = 5;
      layout = "master";
      resize_on_border = true;
      allow_tearing = true;
      snap.enabled = true;
    };

    decoration = {
      rounding = 10;
      rounding_power = 4.0;
      dim_inactive = false;
      dim_strength = 0.1;
      blur = {
        size = 7;
        passes = 2;
      };
      shadow = {
        color = "rgba(00000080)";
        range = 15;
        render_power = 2;
        offset = "7 7";
      };
    };

    animations = {
      enabled = true;
      bezier = [
        "win, 0.3, 0.9, 0.5, 1.1"
        "winIn, 0.7, 1.1, 0.1, 1.1"
        "winOut, 0.35, -0.3, 0.25, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windowsIn, 1, 3, winIn, gnomed"
        "windowsOut, 1, 5, winOut, gnomed"
        "windowsMove, 1, 5, win, gnomed"
        "layersIn, 1, 3, winIn, gnomed"
        "layersOut, 1, 5, winIn, gnomed"
        "border, 1, 4, liner"
        "borderangle, 1, 30, liner, loop"
        "workspaces, 1, 5, win, slidevert"
      ];
    };

    input = {
      kb_model = "QWERTY";
      kb_layout = "pt,es";
      kb_options = "grp:alt_shift_toggle";
      numlock_by_default = true;
      follow_mouse = 1;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.50;
      };
    };

    gestures.workspace_swipe_distance = 200;

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    binds = {
      workspace_back_and_forth = false;
    };

    xwayland.force_zero_scaling = true;

    cursor = {
      no_hardware_cursors = true;
      default_monitor = let
        monitor = builtins.elemAt (builtins.filter (m: m.default) config.monitors) 0;
      in
        monitor.name;
    };

    ecosystem.no_donation_nag = true;

    master.mfact = 0.5;
  };
}
