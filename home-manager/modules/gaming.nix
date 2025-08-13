{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.gaming.enable {
  home.packages = with pkgs; [
    (heroic.override {
      extraPkgs = pkgs: [
        gamemode
        gamescope
        egl-wayland
      ];
    })
    prismlauncher
    protonup
    rpcs3
    steam
    wineWowPackages.stable
  ];

  programs.lutris = {
    enable = true;
    runners.rpcs3.settings.runner.runner_executable = "${pkgs.rpcs3}/bin/rpcs3";
  };
}
