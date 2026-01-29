{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot
    ./networking.nix
  ];

  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      git
      home-manager
      nix-update
      libnotify
      libsecret
    ];
  };

  programs.nix-ld.enable = true;

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
    polkit.enable = true;
  };

  virtualisation.docker.enable = true;
}
