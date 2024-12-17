{
	description = "System flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		impermanence.url = "github:nix-community/impermanence";

		hyprland = {
			type = "github";
			owner = "hyprwm";
			repo = "Hyprland";
			rev = "4520b30d498daca8079365bdb909a8dea38e8d55"; # v0.44.1
		};
	};

	outputs = inputs: let
		system = "x86_64-linux";
		secrets = import ./secrets.nix;
		specialArgs = { inherit inputs secrets; };

		nixosSys = inputs.nixpkgs.lib.nixosSystem;

		disko = [ inputs.disko.nixosModules.default ];
		impermanence = [ inputs.impermanence.nixosModules.impermanence ];
	in {
		nixosConfigurations = {
			desktop = nixosSys {
				inherit system specialArgs;
				modules =
				disko ++
				impermanence ++ [
					./hosts/desktop
				];
			};

			laptop = nixosSys {
				inherit system specialArgs;
				modules =
				disko ++
				impermanence ++ [
					./hosts/laptop
				];
			};
		};
	};
}
