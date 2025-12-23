{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    act
    brave
    cpu-x
    exiftool
    eza
    ffmpeg
    (flameshot.override {enableWlrSupport = true;}) # Screenshot utility
    gimp
    imagemagick
    jq
    killall
    libreoffice
    newsflash
    nh
    nix-tree # View all package dependencies
    nurl # Query data from a Github repo
    obsidian
    p7zip
    parallel
    popsicle
    ripdrag # Drag-and-drop for the terminal
    ripgrep # Grep but better
    inputs.stremioDowngrade.legacyPackages.${stdenv.hostPlatform.system}.stremio
    thunderbird
    unar
    unrar-wrapper # Extrach RAR files
    unzip
    zip
    vesktop
    virt-manager
    vlc
    vscode
    wget
  ];
}
