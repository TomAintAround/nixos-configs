{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./wm
    ./wayland
    ./wayland/wm.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        # Toolkit Backend
        "GDK_BACKEND=wayland,x11,*"
        "QT_QPA_PLATFORM=wayland;xcb"
        "SDL_VIDEODRIVER=wayland" # if experiencing issues, replace with "x11"
        "SDL_VIDEO_DRIVER=wayland" # if experiencing issues, replace with "x11"
        "CLUTTER_BACKEND=wayland"

        # XDG Variables
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # Hyprland
        "HYPRLAND_TRACE,1"
      ];

      monitorv2 = map (m: let
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
        ))
      config.monitors;

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
        rounding = 15;
        rounding_power = 4.0;
        dim_inactive = true;
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
          "layersIn, 1, 3, winIn, slide"
          "layersOut, 1, 5, winOut, fade"
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
            if config.programs.alacritty.enable
            then "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
            else "SUPER, F14, exec,"
          }"
          "${
            if config.programs.kitty.enable
            then "SUPER, Return, exec, ${pkgs.kitty}/bin/kitty"
            else "SUPER, F14, exec,"
          }"
          "SUPER, C, exec, ${pkgs.clipman}/bin/clipman pick -t rofi -T'-theme ${config.xdg.configHome}/rofi/clipboard.rasi'"
          "SUPER, Space, exec, ${pkgs.rofi}/bin/rofi -show drun -modi drun,window -theme ~/.config/rofi/launcher.rasi -show-icons -icon-theme Papirus-Dark"
          "SUPER, F1, exec, ${pkgs.librewolf}/bin/librewolf"
          "SUPER, F2, exec, ${pkgs.vesktop}/bin/vesktop"
          "SUPER, F3, exec, ${pkgs.obsidian}/bin/obsidian"
          "SUPER, F4, exec, ${pkgs.thunderbird}/bin/thunderbird"
          "SUPER, F5, exec, ${pkgs.newsflash}/bin/io.gitlab.news_flash.NewsFlash"
          "${
            if config.programs.lutris.enable
            then "SUPER, F6, exec, ${pkgs.lutris}/bin/lutris"
            else "SUPER, F14, exec,"
          }"
          "SUPER, F10, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
          "${
            if config.programs.alacritty.enable
            then "SUPER, F11, exec, ${pkgs.alacritty}/bin/alacritty --class music -e ncmpcpp"
            else "SUPER, F14, exec,"
          }"
          "${
            if config.programs.alacritty.enable
            then "SUPER, F12, exec, ${pkgs.alacritty}/bin/alacritty --class btop -e btop"
            else "SUPER, F14, exec,"
          }"
          "${
            if config.programs.kitty.enable
            then "SUPER, F11, exec, ${pkgs.kitty}/bin/kitty --app-id music ncmpcpp"
            else "SUPER, F14, exec,"
          }"
          "${
            if config.programs.kitty.enable
            then "SUPER, F12, exec, ${pkgs.kitty}/bin/kitty --app-id btop btop"
            else "SUPER, F14, exec,"
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
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "SUPER, code:1${toString i}, workspace, ${toString ws}"
                "SUPER SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            10)
        )
        ++
        # I know what you're thinking: "What the hell am I reading? What kind of spaguetti mess is this?".
        # You think this sucks? THEN MAKE IT BETTER YOURSELF AND MAKE A PULL REQUEST. Let's see if you can
        # (please do it I beg you).
        # Update: I've managed to make it better. I was very inexperienced the first time I did this.
        (let
          inherit (builtins) filter genList sort lessThan elemAt length;

          enabledMonitors = filter (m: m.enable) config.monitors;

          size = length enabledMonitors;

          sameXCoord = (map (m: m.x) enabledMonitors) == (genList (_: (elemAt enabledMonitors 0).x) size);
          coordinates_x = sort lessThan (map (m: m.x) enabledMonitors);
          coordinates_y = sort lessThan (map (m: m.y) enabledMonitors);
          coordinates =
            if sameXCoord
            then coordinates_y
            else coordinates_x;

          monSelector = n: (elemAt coordinates (n - 1)).name;
        in
          if coordinates != (lib.lists.unique coordinates)
          then throw "If your monitors are vertically distributed, each one must have a unique ordinate. If not, each one must have a unique abscissa"
          else if size == 1
          then []
          else if size == 2
          then [
            "SUPER ALT, H, focusmonitor, ${monSelector 1}"
            "SUPER ALT, L, focusmonitor, ${monSelector 2}"
            "SUPER ALT SHIFT, H, movewindow, mon:${monSelector 1}"
            "SUPER ALT SHIFT, L, movewindow, mon:${monSelector 2}"
          ]
          else if size == 3
          then [
            "SUPER ALT, H, focusmonitor, ${monSelector 1}"
            "SUPER ALT, K, focusmonitor, ${monSelector 2}"
            "SUPER ALT, L, focusmonitor, ${monSelector 3}"
            "SUPER ALT SHIFT, H, movewindow, mon:${monSelector 1}"
            "SUPER ALT SHIFT, K, movewindow, mon:${monSelector 2}"
            "SUPER ALT SHIFT, L, movewindow, mon:${monSelector 3}"
          ]
          else if size == 4
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

      "\$scriptsDir" = "${config.xdg.dataHome}/scripts";
      exec-once = [
        # Screensharing
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Portals
        (let
          portal = pkgs.writeShellScriptBin "portal.bash" ''
            #######################################################################
            # https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/ #
            #######################################################################

            sleep 1
            killall -e xdg-desktop-portal-hyprland
            killall xdg-desktop-portal
            ${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland &
            sleep 2
            ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal &
          '';
        in "${lib.getExe portal}")

        # Polkit
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

        # Notification Daemon
        "${pkgs.systemd}/bin/systemctl --user start dunst.service"

        # Set wallpaper
        "${pkgs.swww}/bin/swww-daemon"
        "wallpaper-change random"

        # Generate Album Arts
        "\$scriptsDir/albumart.bash"

        # MPD Playerctl Compatibility
        "${pkgs.mpd-mpris}/bin/mpd-mpris"

        # Clipboard Manager
        "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch clipman store --no-persist"

        # Screenshot tool
        "${pkgs.flameshot.override {enableWlrSupport = true;}}/bin/flameshot"

        # Software for Peripherals
        "${
          if config.openrazer.enable
          then "${pkgs.polychromatic}/bin/polychromatic-tray-applet}"
          else "echo no"
        }"
        "${
          if config.openrgb.enable
          then "${pkgs.openrgb-with-all-plugins}/bin/openrgb --startminimized"
          else "echo no"
        }"

        # Easyeffects
        "${pkgs.systemd}/bin/systemctl --user start easyeffects.service"

        # KDE Connect Indicator
        "${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator"
      ];

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
  };
}
