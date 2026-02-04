{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox-addons = {
    #   url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # This file is ignored by .gitignore, so this is the only way to use it without exposing it
    secrets = {
      url = "/etc/nixos/home-manager/tomm/secrets.nix";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    userVars = {
      username = "tomm";
      gitUsername = "TomAintAround";
      email = let
        secrets = import inputs.secrets;
      in
        secrets.email;
    };
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import ./overlays/customPkgs.nix)];
    };
    extraSpecialArgs = {inherit inputs system userVars;};

    mkHome = initialModule:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [initialModule];
      };
  in {
    homeConfigurations = {
      "${userVars.username}@desktop" = mkHome ./hosts/desktop.nix;
      "${userVars.username}@laptop" = mkHome ./hosts/laptop.nix;
    };
  };
}
