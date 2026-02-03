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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  #TODO: add system to specialArgs and make mkHost function
  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    secrets = import ./secrets.nix;
    specialArgs = {inherit inputs secrets;};

    mkHost = initialModule:
      nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [initialModule];
      };
  in {
    nixosConfigurations = {
      desktop = mkHost ./hosts/desktop;
      laptop = mkHost ./hosts/laptop;
    };
  };
}
