{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1"];
    kernelParams = ["video:efifb=off" "pcie_acs_override=downstream,multifunction"];
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  systemd.services = {
    libvirtd = {
      path = let
        env = pkgs.buildEnv {
          name = "qemu-hook-env";
          paths = with pkgs; [
            bash
            libvirt
            kmod
            systemd
            ripgrep
            sd
          ];
        };
      in [env];
      preStart = ''
        libvirtPath=/var/lib/libvirt

        mkdir -p $libvirtPath/hooks
        mkdir -p $libvirtPath/bin
        mkdir -p $libvirtPath/vgabios

        ln -sf /etc/nixos/modules/virt/qemu $libvirtPath/hooks/qemu
        ln -sf /etc/nixos/modules/virt/vfio-startup.sh $libvirtPath/bin/vfio-startup.sh
        ln -sf /etc/nixos/modules/virt/vfio-teardown.sh $libvirtPath/bin/vfio-teardown.sh
        ln -sf /etc/nixos/hosts/${config.networking.hostName}/patched.rom $libvirtPath/vgabios/patched.rom

        chmod +x $libvirtPath/hooks/qemu
        chmod +x $libvirtPath/bin/vfio-startup.sh
        chmod +x $libvirtPath/bin/vfio-teardown.sh

        ln -sf ${pkgs.pciutils}/bin/lspci $libvirtPath/bin/lspci
        ln -sf ${pkgs.gawk}/bin/gawk $libvirtPath/bin/awk
        ln -sf ${pkgs.lsof}/bin/lsof $libvirtPath/bin/lsof
        ln -sf ${pkgs.procps}/bin/pkill $libvirtPath/bin/pkill
        ln -sf ${pkgs.procps}/bin/pgrep $libvirtPath/bin/pgrep
      '';
    };

    "libvirt-nosleep@" = {
      description = "Preventing sleep while libvirt domain \"%i\" is running";
      serviceConfig = {
        Type = "simple";
        ExecStart = "/usr/bin/systemd-inhibit --what=sleep --why='Libvirt domain \"%i\" is running' --who=%U --mode=block sleep infinity";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    dnsmasq
    libguestfs
    lsof
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
