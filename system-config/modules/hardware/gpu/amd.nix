{lib, ...}: {
  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "modesetting"];

  nixpkgs.config.rocmSupport = true;

  hardware = {
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };
}
