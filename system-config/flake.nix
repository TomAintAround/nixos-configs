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

    # This file is ignored by .gitignore, so this is the only way to use it without exposing it
    secrets = {
      url = "/etc/nixos/system-config/secrets.nix";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    secrets = import inputs.secrets;
    specialArgs = {inherit inputs secrets system;};

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
