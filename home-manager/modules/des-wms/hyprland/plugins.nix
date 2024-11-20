{ inputs, pkgs, lib, config, ... }: let
    hyprbars = inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars;
    split-monitor-workspaces = inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces;
    hyprfocus = inputs.hyprfocus.packages.${pkgs.system}.hyprfocus;
    hypr-dynamic-cursors = inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors;
in {
    wayland.windowManager.hyprland = {
        plugins = [
            #hyprbars
            split-monitor-workspaces
            hyprfocus
            #hypr-dynamic-cursors
        ];

        settings.plugin = {
            hyprfocus = {
                enabled = true;
                keyboard_focus_animation = "flash";
                mouse_focus_animation = "flash";
                bezier = [
                    "bezIn, 0.5,0.0,1.0,0.5"
                    "bezOut, 0.0,0.5,0.5,1.0"
                ];
                flash = {
                    flash_opacity = 0.9;
                    in_bezier = "bezIn";
                    in_speed = 0.5;
                    out_bezier = "bezOut";
                    out_speed = 1;
                };
                shrink = {
                    shrink_percentage = 0.8;
                    in_bezier = "bezIn";
                    in_speed = 0.5;
                    out_bezier = "bezOut";
                    out_speed = 5;
                };
            };

            hyprbars = {
                bar_height = 30;
                bar_title_enabled = true;
                bar_text_size= 12;
                bar_text_align = "center";
                bar_buttons_alignment = "right";
                bar_part_of_window = true;
                bar_precedence_over_border = true;
                bar_padding = 7;
                bar_button_padding = 7;
            };

            dynamic-cursors = {
                enabled = true;
                mode = "tilt";
                threshold = 2;
                tilt = {
                    limit = 5000;
                    function = "negative_quadratic";
                };
            };

            split-monitor-workspaces.count = let
                cfg = config.wayland.windowManager.hyprland;
            in
                lib.mkIf (builtins.elem split-monitor-workspaces cfg.plugins) (cfg.numOfWorkspaces / 2);
        };
    };
}
