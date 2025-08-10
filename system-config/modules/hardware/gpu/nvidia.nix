{
  lib,
  config,
  ...
}: {
  boot = {
    extraModprobeConfig = ''
      options nvidia-drm modeset=1 fbdev=1
    '';
  };

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      gsp.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      powerManagement.enable = true;
      videoAcceleration = true;
    };
  };

  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  nixpkgs.config.cudaSupport = true;

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
}
