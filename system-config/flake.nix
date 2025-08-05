{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    system = "x86_64-linux";
    secrets = import ./secrets.nix;
    specialArgs = {inherit inputs secrets;};
    nixosSys = inputs.nixpkgs.lib.nixosSystem;
    disko = [inputs.disko.nixosModules.default];
    lanzaboote = [inputs.lanzaboote.nixosModules.lanzaboote];
  in {
    nixosConfigurations = {
      desktop = nixosSys {
        inherit system specialArgs;
        modules =
          disko
          ++ lanzaboote
          ++ [./hosts/desktop];
      };

      laptop = nixosSys {
        inherit system specialArgs;
        modules =
          disko
          ++ lanzaboote
          ++ [./hosts/laptop];
      };
    };
  };
}
