{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.neovim.enable = true;

  home = {
    packages = with pkgs; [
      # Requirements
      curl
      fd
      gcc
      gnumake
      man-pages
      ripgrep
      python3
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
      vscode-langservers-extracted
      taplo # TOML
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

      # Debuggers
      # bashdb
      # completely # dependency of bashdb
      nodejs # required for lua debugger
      vscode-extensions.ms-vscode.cpptools
      vscode-js-debug
      vscode-extensions.vscjava.vscode-java-debug
    ];

    # I'm absolutely not configuring neovim through nix,
    # so here's my solution that doesn't rely on sourcing
    # (which makes the configuration read-only)
    sessionVariables = {
      NVIM_APPNAME = "home-manager/modules/neovim";
    };

    activation.link-debuggers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      LOCATION=${config.xdg.stateHome}/"$NVIM_APPNAME"/debuggers
      mkdir -p "$LOCATION"
      ln -sf ${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js "$LOCATION"
      ln -sf ${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7 "$LOCATION"
      ln -sf ${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/* "$LOCATION"/com.microsoft.java.debug.plugin.jar
    '';
  };
}
