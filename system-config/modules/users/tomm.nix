{
  secrets,
  pkgs,
  lib,
  ...
}: {
  users.users.tomm = {
    name = "tomm";
    description = secrets.names.tomm;
    isNormalUser = true;
    createHome = true;
    hashedPassword = lib.mkDefault (throw "Must set a password");
    home = "/home/tomm";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "openrazer"
      "networkmanager"
      "scanner"
      "lp"
      "kvm"
      "input"
      "libvirtd"
      "gamemode"
      "docker"
    ];
  };

  programs.fish.enable = true;
}
