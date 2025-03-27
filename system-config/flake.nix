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
			rev = "5ee35f914f921e5696030698e74fb5566a804768"; # v0.48.0
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
