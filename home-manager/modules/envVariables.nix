{config, ...}: {
  home.sessionVariables = {
    # Default Apps
    OPENER = "xdg-open";
    VISUAl = "nvim";
    EDITOR = "nvim";
    PAGER = "bat --paging=always";
    TERMINAL = config.terminal;
    READER = "libreoffice --draw";
    BROWSER = "librewolf";
    IMAGE_EDITOR = "gimp";
    AUDIO_PLAYER = "vlc";
    VIDEO_PLAYER = "vlc";
    FILE_MANAGER = config.fileManager;

    # Paths
    GOPATH = "${config.xdg.dataHome}/go";
    WINEPREFIX = "${config.xdg.dataHome}/wine";

    # Fixes
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
