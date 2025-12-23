{lib, ...}: {
  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "modesetting"];

  nixpkgs.config.rocmSupport = true;

  hardware = {
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };
}
