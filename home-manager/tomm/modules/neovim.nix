{
  pkgs,
  lib,
  config,
  ...
}: let
in {
  # I'm absolutely not configuring neovim through nix,
  # so the actual config is it's own repo:
  # https://github.com/TomAintAround/neovim-config

  xdg.configFile = {
    "nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home-manager/tomm/modules/neovim/lua";
    "nvim/ftplugin".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home-manager/tomm/modules/neovim/ftplugin";
    "nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home-manager/tomm/modules/neovim/lazy-lock.json";
    "nvim/init.lua".text = ''
      require("default")
    '';
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withRuby = false;

    extraPackages = with pkgs; [
      imagemagick
    ];
    extraLuaPackages = ps:
      with ps; [
        magick
      ];
    extraPython3Packages = ps:
      with ps; [
        pynvim
        jupyter-client
        cairosvg # for image rendering
        pnglatex # for image rendering
        plotly # for image rendering
        pyperclip
      ];
  };

  home = {
    packages = with pkgs; [
      # Requirements
      tree-sitter
      curl
      fd
      gcc
      gnumake
      man-pages
      ripgrep
      lua51Packages.lua
      luajitPackages.luarocks

      # LSPs
      arduino-language-server
      basedpyright
      bash-language-server
      clang-tools
      fish-lsp
      lua-language-server
      jdt-language-server
      marksman
      nixd
      kdePackages.qtdeclarative
      sqls
      taplo # TOML
      vscode-langservers-extracted
      yaml-language-server
      lemminx # xml
      cmake-language-server

      # Formatters
      jq
      prettierd
      black # Python
      stylua
      yamlfmt
      alejandra # Nix
      libxml2
      cmake-format
      sql-formatter

      # Debuggers
      # bashdb
      # completely # dependency of bashdb
      nodejs # required for lua debugger
      vscode-extensions.ms-vscode.cpptools
      vscode-js-debug
      vscode-extensions.vscjava.vscode-java-debug
    ];

    sessionVariables.NVIM_APPNAME = "nvim";

    activation.link-neovim-helpers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      neovimState=${config.xdg.stateHome}/"$NVIM_APPNAME"
      debuggersLocation="$neovimState"/debuggers

      mkdir -p "$debuggersLocation"
      ln -sf ${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js "$debuggersLocation"
      ln -sf ${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7 "$debuggersLocation"
      ln -sf ${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/* "$debuggersLocation"/com.microsoft.java.debug.plugin.jar
    '';
  };
}
