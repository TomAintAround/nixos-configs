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

  outputs = {
    nixpkgs,
    disko,
    lanzaboote,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    secrets = import ./secrets.nix;
    specialArgs = {inherit inputs secrets;};
    inherit (nixpkgs.lib) nixosSystem;
    diskoModule = disko.nixosModules.default;
    lanzabooteModule = lanzaboote.nixosModules.lanzaboote;
  in {
    nixosConfigurations = {
      desktop = nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/desktop
          diskoModule
          lanzabooteModule
        ];
      };

      laptop = nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/laptop
          diskoModule
          lanzabooteModule
        ];
      };
    };
  };
}
