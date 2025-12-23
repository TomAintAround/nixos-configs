{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disko.nix {device = "/dev/nvme0n1";})
    ../../modules/base.nix
    ../../modules/des-wms/awesome.nix
    ../../modules/des-wms/hyprland.nix
    ../../modules/hardware/cpu/amd
    ../../modules/hardware/cpu/amd/pstate.nix
    ../../modules/hardware/cpu/amd/zenpower.nix
    ../../modules/hardware/gpu/amd.nix
    ../../modules/hardware/laptop
    ../../modules/hardware/laptop/acpiCall.nix
    ../../modules/hardware/bluetooth.nix
    #../../modules/hardware/fringerprint.nix
    ../../modules/hardware/ssd.nix
    ../../modules/users/root.nix
    ../../modules/users/tomm.nix
    ../../modules/virt
    # ../../modules/ai.nix
    ../../modules/docker.nix
  ];

  networking.hostName = "laptop";
}
