{
  modulesPath,
  pkgs,
  inputs,
  secrets,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disko.nix {
      inherit inputs;
      device = "/dev/nvme0n1";
    })
    ../../modules/default-no-server.nix
    ../../modules/des-wms/awesome.nix
    ../../modules/des-wms/hyprland.nix
    ../../modules/hardware/cpu/amd
    ../../modules/hardware/cpu/amd/pstate.nix
    ../../modules/hardware/cpu/amd/zenpower.nix
    # ../../modules/hardware/gpu/amd.nix
    ../../modules/hardware/gpu/nvidia.nix
    # ../../modules/hardware/laptop
    # ../../modules/hardware/laptop/hdd.nix
    # ../../modules/hardware/bluetooth.nix
    #../../modules/hardware/fingerprint.nix
    ../../modules/hardware/openrazer.nix
    ../../modules/hardware/openrgb.nix
    # (
    # 	import ../../modules/hardware/printing.nix {
    # 		ensurePrinters = [
    # 			{
    # 				name = "EPSON_XP-335";
    # 				deviceUri = "usb://EPSON/XP-332%20335%20Series?serial=573238503130333276&interface=1";
    # 				model = "epson-inkjet-printer-escpr/Epson-XP-332_335_Series-epson-escpr-en.ppd";
    # 				ppdOptions = {
    # 					PageSize = "A4";
    # 				};
    # 			}
    # 		];
    #
    # 		drivers = with pkgs; [ epson-escpr epsonscan2 ];
    # 	}
    # )
    ../../modules/hardware/ssd.nix
    ../../modules/users/root.nix
    ../../modules/users/tomm.nix
    ../../modules/virt
    # ../../modules/ai.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "23.11";
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;

  users.users = {
    tomm.hashedPassword = secrets.passwords.desktop.tomm;
    root.hashedPassword = secrets.passwords.desktop.root;
  };
}
