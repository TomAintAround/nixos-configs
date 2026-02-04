{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot
    ./networking.nix
  ];

  environment.localBinInPath = true;

  programs = {
    git = {
      enable = true;
      config.safe.directory = "/etc/nixos";
    };
    nix-ld.enable = true;
  };

  services = {
    openssh.enable = true;
    udisks2 = {
      enable = true;
      settings."mount_options.conf".defaults.umask = "0022";
    };
    fail2ban.enable = true;
  };

  time.timeZone = "Europe/Lisbon";

  users.mutableUsers = false;

  documentation.man.generateCaches = lib.mkForce false;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  console = {
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    keyMap = "pt-latin1";
  };

  i18n = {
    defaultLocale = "pt_PT.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
      "pt_PT.UTF-8/UTF-8"
      "es_ES.UTF-8/UTF-8"
    ];
  };

  security = {
    apparmor.enable = true;
    tpm2.enable = true;
  };

  virtualisation.docker.enable = true;

  system.activationScripts.setPermissions.text = ''
    chown -R nobody:wheel /etc/nixos
    chmod -R g+s /etc/nixos
    ${pkgs.acl}/bin/setfacl -d -m u::rwx,g::rwx,o::rx /etc/nixos
    find /etc/nixos -type d -exec chmod 775 {} +
    find /etc/nixos -type f -perm /u=x,g=x,o=x -exec chmod 775 {} +
    find /etc/nixos -type f ! -perm /u=x,g=x,o=x -exec chmod 664 {} +
  '';
}
