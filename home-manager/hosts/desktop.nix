{
  imports = [
    ../modules/base.nix
  ];

  monitors = [
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 74;
      vrr = false;
      x = 0;
      y = 0;
      scale = 1.0;
      enable = true;
      default = false;
    }
    {
      name = "DVI-D-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      vrr = false;
      x = 1920;
      y = 0;
      scale = 1.0;
      enable = false;
      default = true;
    }
    {
      name = "Unknown-1";
      enable = false;
    }
  ];

  brightness.enable = false;
  contentCreation.enable = true;
  fileManager = "yazi";
  gaming.enable = true;
  gamedev.enable = false;
  openrazer.enable = true;
  openrgb.enable = true;
  terminal = "kitty";
}
