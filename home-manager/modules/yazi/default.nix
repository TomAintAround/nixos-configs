{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./settings.nix
    ./keymaps.nix
  ];

  home.packages = with pkgs;
    lib.mkIf (config.fileManager == "yazi") [
      ffmpeg-full # for video thumbnails
      atool
      unzip
      zip # for archive extraction and preview
      jq # for JSON preview
      poppler # for PDF preview
      fd # for file searching
      ripgrep # for file content searching
      fzf # for quick file subtree navigation, >= 0.53.0
      zoxide # for historical directories navigation, requires fzf
      resvg # for SVG preview
      imagemagick # for Font, HEIC, and JPEG XL preview
      ripdrag # for drag and drop

      # Plugin dependencies
      rich-cli
    ];

  programs.yazi = {
    enable = config.fileManager == "yazi";
    plugins = with pkgs.yaziPlugins; {
      inherit chmod full-border git relative-motions rich-preview compress;
    };
    initLua = ./init.lua;
  };
}
