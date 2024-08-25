{ pkgs, ... }: {
    programs.bat = {
        enable = true;
        config = {
            color = "always";
            italic-text = "always";
            wrap = "never";
            style = "default";
        };
        extraPackages = with pkgs.bat-extras; [
            batpipe
            batgrep
            batman
        ];
    };
}
