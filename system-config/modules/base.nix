{
  imports = [
    ./boot
    ./boot/plymouth.nix
    ./boot/secure-boot.nix
    ./boot/systemd-boot.nix
    ./hardware/disks.nix
    ./hardware/graphics.nix
    ./hardware/sound.nix
    ./sddm
    ./console.nix
    ./fonts.nix
    ./locales.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./pkgs.nix
    ./security.nix
    ./xserver.nix
  ];

  boot.kernelModules = ["uinput"];

  system.stateVersion = "23.11";

  time.timeZone = "Europe/Lisbon";

  users.mutableUsers = false;
}
