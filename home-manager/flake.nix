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
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-index-database,
    catppuccin,
    ...
  } @ inputs: let
    userVars = {
      username = "tomm";
      gitUsername = "TomAintAround";
      email = let
        secrets = import ./secrets.nix;
      in
        secrets.email;
    };
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import ./overlays/customPkgs.nix)];
    };
    extraSpecialArgs = {inherit inputs system userVars;};
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (nix-index-database.homeModules) nix-index;
    catppuccinModule = catppuccin.homeModules.catppuccin;
  in {
    homeConfigurations = {
      "tomm@desktop" = homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./hosts/desktop.nix
          nix-index
          catppuccinModule
        ];
      };

      "tomm@laptop" = homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./hosts/laptop.nix
          nix-index
          catppuccinModule
        ];
      };
    };
  };
}
