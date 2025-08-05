{
  services = {
    xserver = {
      enable = true;
      displayManager.setupCommands = ''
        xrandr --auto
      '';
      xkb.layout = "pt";
    };
  };
}
