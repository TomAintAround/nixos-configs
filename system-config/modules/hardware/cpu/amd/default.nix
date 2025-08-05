{
  lib,
  config,
  ...
}: {
  boot = {
    kernelModules = lib.mkIf config.virtualisation.libvirtd.enable ["kvm-amd"];
    kernelParams = ["iommu=pt" "amd_iommu=on"];
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
