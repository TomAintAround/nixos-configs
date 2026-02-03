{
  pkgs,
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
        outer_color = "$accent";
        inner_color = "$base";
        font_color = "$text";
        check_color = "$yellow";
        fail_color = "$red";
        capslock = "$red";
      };

      label = [
        {
          text = "$TIME";
          font_size = 128;
          font_family = config.gtk.font.name;
          position = "0, 100";
          shadow_color = "rgba(00000080)";
          shadow_passes = 2;
          shadow_size = 5;
          color = "$text";
        }
        {
          text = let
            script = pkgs.writeShellScriptBin "getBattery.bash" ''
              #!/usr/bin/env bash

              command -v upower >/dev/null || exit 1

              batteryInfo=$(upower -b)
              percentage=$(grep percentage <<<"$batteryInfo" | awk '{print $2}' | tr -d '%')
              state=$(grep state <<<"$batteryInfo" | awk '{print $2}')

              isCharging() {
              	[[ "$state" == "charging" ]]
              }

              iconsDischarging=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
              iconsCharging=(󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
              index=$(( percentage / 10 ))
              (( index > 9 )) && index=9
              if isCharging; then
              	icon=''${iconsCharging[index]}
              else
              	icon=''${iconsDischarging[index]}
              fi

              echo "$icon $percentage%"
            '';
          in "cmd[update:1000] echo \"$(${lib.getExe script})\"";
          font_size = 16;
          font_family = config.gtk.font.name;
          halign = "right";
          valign = "bottom";
          position = "-10, 10";
          shadow_color = "rgba(00000080)";
          shadow_passes = 2;
          shadow_size = 5;
          color = "$text";
        }
      ];
    };
  };
}
