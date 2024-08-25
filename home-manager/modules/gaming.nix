{ pkgs, lib, config, ... }: {
    home.packages = with pkgs; lib.mkIf config.gaming.enable [
        bottles
        gamescope
        heroic
        lutris
        prismlauncher
        protonup
        steam
    ];
}
