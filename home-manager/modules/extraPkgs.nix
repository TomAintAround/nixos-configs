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
    ffmpeg-full
    (flameshot.override {enableWlrSupport = true;}) # Screenshot utility
    gimp
    imagemagick
    jq
    killall
    libreoffice
    (mpv.override {
      mpv-unwrapped = pkgs.mpv-unwrapped.override {ffmpeg = pkgs.ffmpeg-full;};
    })
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
    vesktop
    virt-manager
    vscode
    wget
    zenity
    zip
  ];
}
