{ pkgs, inputs, ... }: {
    imports = [
        ./wayland.nix
        ./wm.nix
    ];

    programs.hyprland = {
        enable = true;
        package = pkgs.hyprland.overrideAttrs {
            version = "0.45.1";
        };
        xwayland.enable = true;
    };
}
