{ pkgs, inputs, ... }: {
    imports = [
        ./wayland.nix
        ./wm.nix
    ];

    programs.hyprland = {
        enable = true;
        package = pkgs.hyprland.overrideAttrs {
            version = "0.42.0";
        };
        xwayland.enable = true;
    };
}
