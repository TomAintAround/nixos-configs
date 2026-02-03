{
  pkgs,
  config,
  secrets,
  ...
}: {
  users.users.tomm = {
    name = "tomm";
    description = secrets.names.tomm;
    isNormalUser = true;
    createHome = true;
    hashedPasswordFile = config.sops.secrets."hashedPasswords/tomm".path;
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
