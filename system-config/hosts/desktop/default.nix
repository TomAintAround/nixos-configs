{ modulesPath, pkgs, ... }: {
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
            ( import ./disko.nix { device = "/dev/nvme0n1"; } )
            ../../modules/base.nix
            ../../modules/boot/impermanence.nix
            ../../modules/des-wms/hyprland.nix
            ../../modules/hardware/cpu/amd
            ../../modules/hardware/cpu/amd/pstate.nix
            ../../modules/hardware/cpu/amd/zenpower.nix
            ../../modules/hardware/gpu/nvidia.nix
            ../../modules/hardware/bluetooth.nix
            ../../modules/hardware/openrazer.nix
            ../../modules/hardware/openrgb.nix
            ../../modules/hardware/ssd.nix
            (
                import ../../modules/hardware/printing.nix {
                    ensurePrinters = [
                        {
                            name = "EPSON_XP-335";
                            deviceUri = "usb://EPSON/XP-332%20335%20Series?serial=573238503130333276&interface=1";
                            model = "epson-inkjet-printer-escpr/Epson-XP-332_335_Series-epson-escpr-en.ppd";
                            ppdOptions = {
                                PageSize = "A4";
                            };
                        }
                    ];

                    drivers = with pkgs; [ epson-escpr epsonscan2 ];
                }
            )
            ../../modules/users/root.nix
            ../../modules/users/tomm.nix
            ../../modules/virt
            ../../modules/docker.nix
        ];

    networking.hostName = "desktop";
}
