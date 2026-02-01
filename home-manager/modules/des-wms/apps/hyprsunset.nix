{
  lib,
  config,
  ...
}: {
  services.hyprsunset = lib.mkIf (config.displayServer.wayland.enable && config.wm.enable) {
    enable = true;
    settings = {
      max-gamma = 100;
      profile = [
        {
          time = "7:30";
          gamma = 1.0;
          identity = true;
        }
        {
          time = "22:00";
          temperature = 4000;
          gamma = 0.8;
        }
      ];
    };
  };
}
