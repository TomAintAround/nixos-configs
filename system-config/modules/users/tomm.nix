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

  system.activationScripts.setPermissionsTomm = {
    deps = ["setPermissions"];
    text = ''
      chown -R tomm:users /etc/nixos/home-manager/tomm
      chmod -R g+s /etc/nixos/home-manager/tomm
      ${pkgs.acl}/bin/setfacl -d -m u::rwx,g::rx,o::rx /etc/nixos/home-manager/tomm
      find /etc/nixos/home-manager/tomm -type d -exec chmod 755 {} +
      find /etc/nixos/home-manager/tomm -type f -perm /u=x,g=x,o=x -exec chmod 755 {} +
      find /etc/nixos/home-manager/tomm -type f ! -perm /u=x,g=x,o=x -exec chmod 644 {} +
    '';
  };
}
