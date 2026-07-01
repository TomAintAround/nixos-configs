{
  modulesPath,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disko.nix {
      inherit inputs;
      device = "/dev/nvme0n1";
    })
    (import ../../modules/secrets {
      inherit pkgs inputs;
      defaultSopsFile = ../../modules/secrets/laptop.yaml;
    })

    ../../modules/default-no-server.nix
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
    # ../../modules/hardware/fingerprint.nix
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
  system.stateVersion = "25.11";
  services.tlp.settings = {
    TLP_AUTO_SWITCH = 2;

    TLP_PROFILE_BAT = "SAV";

    # TODO: Remove in 1.10
    TLP_DEFAULT_MODE = "BAL";

    # TODO: Switch to TLP_PROFILE_DEFAULT in 1.10
    TLP_PERSISTENT_DEFAULT = 0;

    # My battery only allows for charge control
    STOP_CHARGE_THRESH_BAT0 = 1;

    # TODO: Remove in 1.10
    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "balanced";

    CPU_DRIVER_OPMODE_ON_AC = "active";
    CPU_DRIVER_OPMODE_ON_BAT = "active";
    CPU_DRIVER_OPMODE_ON_SAV = "active";

    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    CPU_BOOST_ON_SAV = 0;

    DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

    DEVICES_TO_ENABLE_ON_STARTUP = "wifi";

    DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
    DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
    DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";

    DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
  };
}
