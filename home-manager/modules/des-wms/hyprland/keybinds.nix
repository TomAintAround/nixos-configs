{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        # Hyprland keybinds
        "SUPER SHIFT, Q, killactive,"
        "SUPER SHIFT, BackSpace, exit,"
        "SUPER, V, togglefloating,"
        "SUPER, P, pseudo," # dwindle
        "SUPER, G, layoutmsg, addmaster"
        "SUPER, Y, layoutmsg, removemaster"
        "SUPER, F, fullscreen, 0"
        "SUPER, M, fullscreen, 1"
        (let
          changeLayout = pkgs.writeShellScriptBin "changeLayout.bash" ''
            ###################################################################################################################
            # https://github.com/arcolinux/arcolinux-hyprland/blob/main/etc/skel/.config/hypr/scripts/changeLayout (modified) #
            ###################################################################################################################

            LAYOUT=$(${pkgs.hyprland}/bin/hyprctl -j getoption general:layout | ${pkgs.jq}/bin/jq '.str' | sed 's/"//g')

            case "$LAYOUT" in
            "master")
            	${pkgs.hyprland}/bin/hyprctl keyword general:layout dwindle
            	${pkgs.libnotify}/bin/notify-send --app-name="Layout change" "Dwindle Layout"
            ;;
            "dwindle")
            	${pkgs.hyprland}/bin/hyprctl keyword general:layout master
            	${pkgs.libnotify}/bin/notify-send --app-name="Layout change" "Master Layout"
            ;;
            *) ;;
            esac
          '';
        in "SUPER, S, exec, ${lib.getExe changeLayout}")

        # Apps keybinds
        "${
          if (config.terminal == "alacritty")
          then "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
          else "SUPER, Return, exec,"
        }"
        "${
          if (config.terminal == "kitty")
          then "SUPER, Return, exec, ${pkgs.kitty}/bin/kitty"
          else "SUPER, Return, exec,"
        }"
        "SUPER, C, exec, ${pkgs.clipman}/bin/clipman pick -t rofi -T'-theme ${config.xdg.configHome}/rofi/clipboard.rasi'"
        "SUPER, Space, exec, ${pkgs.rofi}/bin/rofi -show drun -modi drun,window -theme ~/.config/rofi/launcher.rasi -show-icons -icon-theme Papirus-Dark"
        "SUPER, F1, exec, ${pkgs.librewolf}/bin/librewolf"
        "SUPER, F2, exec, ${pkgs.vesktop}/bin/vesktop"
        "SUPER, F3, exec, ${pkgs.obsidian}/bin/obsidian"
        "SUPER, F4, exec, ${pkgs.thunderbird}/bin/thunderbird"
        "SUPER, F5, exec, ${pkgs.newsflash}/bin/io.gitlab.news_flash.NewsFlash"
        "${
          if config.gaming.enable
          then "SUPER, F6, exec, ${pkgs.lutris}/bin/lutris"
          else "SUPER, F6, exec,"
        }"
        "SUPER, F10, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
        "${
          if (config.terminal == "alacritty")
          then "SUPER, F11, exec, ${pkgs.alacritty}/bin/alacritty --class music -e ncmpcpp"
          else "SUPER, F11, exec,"
        }"
        "${
          if (config.terminal == "alacritty")
          then "SUPER, F12, exec, ${pkgs.alacritty}/bin/alacritty --class btop -e btop"
          else "SUPER, F12, exec,"
        }"
        "${
          if (config.terminal == "kitty")
          then "SUPER, F11, exec, ${pkgs.kitty}/bin/kitty --app-id music ncmpcpp"
          else "SUPER, F11, exec,"
        }"
        "${
          if (config.terminal == "kitty")
          then "SUPER, F12, exec, ${pkgs.kitty}/bin/kitty --app-id btop btop"
          else "SUPER, F12, exec,"
        }"
        ",Print, exec, ${pkgs.flameshot.override {enableWlrSupport = true;}}/bin/flameshot gui"

        # Move focus
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # Move windows
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"

        # Scroll through existing workspaces
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # OBS
        "CTRL SHIFT, Home, pass, class:^(com\.obsproject\.Studio)$"
        "CTRL SHIFT, End, pass, class:^(com\.obsproject\.Studio)$"
        "CTRL SHIFT, Insert, pass, class:^(com\.obsproject\.Studio)$"
        "CTRL SHIFT, Delete, pass, class:^(com\.obsproject\.Studio)$"
      ]
      ++ (
        let
          cfg = config.wayland.windowManager.hyprland;
        in
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "SUPER, code:1${toString i}, workspace, ${toString ws}"
                "SUPER SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            cfg.numOfWorkspaces)
      )
      ++
      # I know what you're thinking: "What the hell am I reading? What kind of spaguetti mess is this?".
      # You think this sucks? THEN MAKE IT BETTER YOURSELF AND MAKE A PULL REQUEST. Let's see if you can
      # (please do it I beg you).
      # Update: I've managed to make it better. I was very inexperienced the first time I did this.
      (let
        enabledMonitors = builtins.filter (m: m.enable) config.monitors;

        length = builtins.length enabledMonitors;

        sameXCoord = (builtins.map (m: m.x) enabledMonitors) == (builtins.genList (x: (builtins.elemAt enabledMonitors 0).x) length);
        coordinates_x = builtins.sort builtins.lessThan (builtins.map (m: m.x) enabledMonitors);
        coordinates_y = builtins.sort builtins.lessThan (builtins.map (m: m.y) enabledMonitors);
        coordinates =
          if sameXCoord
          then coordinates_y
          else coordinates_x;

        monSelector = n: (builtins.elemAt coordinates (n - 1)).name;
      in
        if coordinates != (lib.lists.unique coordinates)
        then throw "If your monitors are vertically distributed, each one must have a unique ordinate. If not, each one must have a unique abscissa"
        else if length == 1
        then []
        else if length == 2
        then [
          "SUPER ALT, H, focusmonitor, ${monSelector 1}"
          "SUPER ALT, L, focusmonitor, ${monSelector 2}"
          "SUPER ALT SHIFT, H, movewindow, mon:${monSelector 1}"
          "SUPER ALT SHIFT, L, movewindow, mon:${monSelector 2}"
        ]
        else if length == 3
        then [
          "SUPER ALT, H, focusmonitor, ${monSelector 1}"
          "SUPER ALT, K, focusmonitor, ${monSelector 2}"
          "SUPER ALT, L, focusmonitor, ${monSelector 3}"
          "SUPER ALT SHIFT, H, movewindow, mon:${monSelector 1}"
          "SUPER ALT SHIFT, K, movewindow, mon:${monSelector 2}"
          "SUPER ALT SHIFT, L, movewindow, mon:${monSelector 3}"
        ]
        else if length == 4
        then [
          "SUPER ALT, H, focusmonitor, ${monSelector 1}"
          "SUPER ALT, J, focusmonitor, ${monSelector 2}"
          "SUPER ALT, K, focusmonitor, ${monSelector 3}"
          "SUPER ALT, L, focusmonitor, ${monSelector 4}"
          "SUPER ALT SHIFT, H, movewindow, mon:${monSelector 1}"
          "SUPER ALT SHIFT, J, movewindow, mon:${monSelector 2}"
          "SUPER ALT SHIFT, K, movewindow, mon:${monSelector 3}"
          "SUPER ALT SHIFT, L, movewindow, mon:${monSelector 4}"
        ]
        else throw "WHAT THE HELL ARE YOU DOING WITH 5+ MONITORS???????");

    # Audio keybinds
    bindel = [
      ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      "${
        if config.brightness.enable
        then ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 2%+"
        else ",XF86MonBrightnessUp, exec,"
      }"
      "${
        if config.brightness.enable
        then ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 2%-"
        else ",XF86MonBrightnessDown, exec,"
      }"
    ];
    bindl = [
      ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ",XF86AudioNext, exec, ${pkgs.wireplumber}/bin/playerctl next"
      ",XF86AudioPrev, exec, ${pkgs.wireplumber}/bin/playerctl previous"
      ",XF86AudioStop, exec, ${pkgs.wireplumber}/bin/playerctl stop"
    ];

    # Resize windows
    binde = [
      "SUPER CTRL, H, resizeactive, -10 0"
      "SUPER CTRL, L, resizeactive, 10 0"
      "SUPER CTRL, K, resizeactive, 0 -10"
      "SUPER CTRL, J, resizeactive, 0 10"
    ];

    # Move/resize windows
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    gesture = [
      "3, vertical, mod: SUPER, workspace"
      "3, swipe, resize"
    ];
  };
}
