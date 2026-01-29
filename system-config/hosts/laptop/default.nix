{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disko.nix {device = "/dev/nvme0n1";})
    ../../modules/base-no-server.nix
    ../../modules/des-wms/awesome.nix
    ../../modules/des-wms/hyprland.nix
    ../../modules/hardware/cpu/amd
    ../../modules/hardware/cpu/amd/pstate.nix
    ../../modules/hardware/cpu/amd/zenpower.nix
    ../../modules/hardware/gpu/amd.nix
    # ../../modules/hardware/gpu/nvidia.nix
    ../../modules/hardware/laptop
    # ../../modules/hardware/laptop/hdd.nix
    ../../modules/hardware/bluetooth.nix
    #../../modules/hardware/fringerprint.nix
    #../../modules/hardware/openrazer.nix
    #../../modules/hardware/openrgb.nix
    # (
    # 	import ../../modules/hardware/printing.nix {
    # 		ensurePrinters = [
    # 		];
    # 		drivers = with pkgs; [];
    # 	}
    # )
    ../../modules/hardware/ssd.nix
    ../../modules/users/root.nix
    ../../modules/users/tomm.nix
    ../../modules/virt
    # ../../modules/ai.nix
  ];

  networking.hostName = "laptop";
  system.stateVersion = "23.11";
}
