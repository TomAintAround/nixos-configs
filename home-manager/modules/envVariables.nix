{ config, ... }: {
    home.sessionVariables = {
        # Default Apps
        OPENER = "xdg-open";
        VISUAl = "nvim";
        EDITOR = "nvim";
        PAGER = "bat --paging=always";
	TERMINAL = "alacritty";
        READER = "libreoffice --draw";
        BROWSER = "firefox";
	IMAGE_EDITOR = "gimp";
	AUDIO_PLAYER = "vlc";
	VIDEO_PLAYER = "vlc";

        # Paths
        GOPATH = "${config.xdg.dataHome}/go";
        WINEPREFIX = "${config.xdg.dataHome}/wine";
    };
}
