{ pkgs, ... }: {
    home.packages = with pkgs; [
        act
        arduino-cli
        arduino-ide
        brave
        cpu-x
        eza
        gimp
        imagemagick
        jq
        killall
        libreoffice
        neovim
        newsflash
        nix-tree # View all package dependencies
        nurl # Query data from a Github repo
        obsidian
        p7zip
        popsicle
        ripdrag # Drag-and-drop for the terminal
        ripgrep # Grep but better
        stremio
        thunderbird
        unar # Extrach RAR files
        unrar-wrapper
        unzip
        vesktop
        virt-manager
        vlc
        vscode
        wget
        zip
    ];
}
