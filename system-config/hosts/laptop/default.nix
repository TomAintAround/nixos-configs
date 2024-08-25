{ modulesPath, pkgs, ... }: {
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
            ( imports ./disko.nix { device = "/dev/nvme0n1"; } )
            ./../../modules/base.nix
            ./../../modules/boot/impermanence.nix
            ./../../modules/des-wms/hyprland.nix
            ./../../modules/hardware/cpu/amd
            ./../../modules/hardware/cpu/amd/pstate.nix
            ./../../modules/hardware/cpu/amd/zenpower.nix
            ./../../modules/hardware/gpu/amd.nix
            ./../../modules/hardware/laptop
            ./../../modules/hardware/laptop/acpiCall.nix
            ./../../modules/hardware/bluetooth.nix
            #./../../modules/hardware/fringerprint.nix
            ./../../modules/hardware/ssd.nix
            ./../../modules/users/root.nix
            ./../../modules/users/tomm.nix
            ./../../modules/virt
        ];

    networking.hostName = "laptop";
}