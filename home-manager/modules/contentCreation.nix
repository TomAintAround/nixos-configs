{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.contentCreation.enable {
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {cudaSupport = true;};
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  home.packages = with pkgs; [davinci-resolve];
}
