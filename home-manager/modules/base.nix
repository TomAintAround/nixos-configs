{
  pkgs,
  lib,
  config,
  inputs,
  userVars,
  ...
}: {
  imports = [
    ./customOptions.nix
    ./des-wms/hyprland.nix
    ./mpv
    ./themes
    ./tmux
    ./yazi
    # ./alacritty.nix
    ./btop.nix
    # ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./lazygit.nix
    ./librewolf.nix
    ./music.nix
    ./neovim.nix
    ./scripts.nix
    ./trash-cli.nix
  ];

  nix.gc = {
    dates = "daily";
    automatic = true;
    options = "--delete-older-than 14d";
  };

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "${userVars.username}";
    homeDirectory = "/home/${userVars.username}";
    stateVersion = "24.05";
    preferXdgDirectories = true;

    language = let
      pt = "pt_PT.UTF-8";
      # en = "en_GB.UTF-8";
      es = "es_ES.UTF-8";
    in {
      address = pt;
      base = es;
      collate = es;
      ctype = es;
      measurement = es;
      messages = es;
      monetary = pt;
      name = pt;
      numeric = es;
      paper = pt;
      telephone = pt;
      time = es;
    };

    sessionVariables = {
      # Default Apps
      OPENER = "xdg-open";
      VISUAl = "nvim";
      EDITOR = "nvim";
      PAGER = "bat --paging=always";
      TERMINAL = "kitty";
      READER = "libreoffice --draw";
      BROWSER = "librewolf";
      IMAGE_EDITOR = "gimp";
      AUDIO_PLAYER = "mpv";
      VIDEO_PLAYER = "mpv";
      FILE_MANAGER = "yazi";

      # Paths
      GOPATH = "${config.xdg.dataHome}/go";
      WINEPREFIX = "${config.xdg.dataHome}/wine";

      # Fixes
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    packages = with pkgs; [
      act
      brave
      cpu-x
      exiftool
      eza
      ffmpeg-full
      gimp
      imagemagick
      jq
      killall
      libreoffice
      newsflash
      nh
      nix-tree # View all package dependencies
      nurl # Query data from a Github repo
      obsidian
      p7zip
      parallel
      popsicle
      ripdrag # Drag-and-drop for the terminal
      ripgrep # Grep but better
      inputs.stremioDowngrade.legacyPackages.${stdenv.hostPlatform.system}.stremio
      thunderbird
      unar
      unrar-wrapper # Extrach RAR files
      unzip
      vesktop
      virt-manager
      vscode
      wget
      zip
    ];
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = ["librewolf.desktop"];
        "x-scheme-handler/https" = ["librewolf.desktop"];
      };
    };
  };

  programs = {
    home-manager.enable = true;
    man.generateCaches = lib.mkForce false;

    bat = {
      enable = true;
      config = {
        color = "always";
        italic-text = "always";
        wrap = "never";
        style = "default";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fd = {
      enable = true;
      hidden = true;
      extraOptions = ["--color='always'"];
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  services = {
    easyeffects = {
      enable = true;
      preset = "Default";
    };

    flameshot = {
      enable = true;
      package = pkgs.flameshot.override {enableWlrSupport = true;};
      settings.General = {
        drawColor = "#ff0000";
        showDesktopNotification = false;
        showStartupLaunchMessage = false;
        useGrimAdapter = true;
      };
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    udiskie = {
      enable = true;
      tray = "auto";
    };
  };
}
