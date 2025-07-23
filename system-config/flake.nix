{
	description = "System flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs: let
		system = "x86_64-linux";
		secrets = import ./secrets.nix;
		specialArgs = { inherit inputs secrets; };

		nixosSys = inputs.nixpkgs.lib.nixosSystem;

		disko = [ inputs.disko.nixosModules.default ];
	in {
		nixosConfigurations = {
			desktop = nixosSys {
				inherit system specialArgs;
				modules =
					disko ++
					[ ./hosts/desktop ];
			};

			laptop = nixosSys {
				inherit system specialArgs;
				modules =
					disko ++
					[ ./hosts/laptop ];
			};
		};
	};
}
