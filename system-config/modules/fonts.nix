{ pkgs, ... }: {
    fonts = {
        packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk
            noto-fonts-emoji
            source-han-sans
            source-han-sans-japanese
            source-han-serif-japanese
            ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )
        ];
        fontconfig = {
            enable = true;
            defaultFonts = {
                monospace = [ "JetBrainsMono Regular Nerd Font" ];
                serif = [ "Noto Serif" "Source Han Serif" ];
                sansSerif = [ "Noto Sans" "Source Han Sans" ];
            };
        };
        fontDir.enable = true;
    };
}
