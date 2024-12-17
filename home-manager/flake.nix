{
	description = "Home Manager configuration";

	inputs = {
		nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		catppuccin.url = "github:catppuccin/nix";

		hyprland = {
			type = "github";
			owner = "hyprwm";
			repo = "Hyprland";
			rev = "4520b30d498daca8079365bdb909a8dea38e8d55"; # v0.44.1
		};

		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};

		hyprsplit = {
			url = "github:shezdy/hyprsplit";
			inputs.hyprland.follows = "hyprland";
		};

		hyprfocus = {
			url = "github:pyt0xic/hyprfocus";
			inputs.hyprland.follows = "hyprland";
		};

		hypr-dynamic-cursors = {
			url = "github:VirtCode/hypr-dynamic-cursors";
			inputs.hyprland.follows = "hyprland";
		};
	};

	outputs = inputs: let
		username = "tomm";
		gitUsername = "TomAintAround";
		email = let
			secrets = import ./secrets.nix;
		in
			secrets.email;
		userVars = { inherit username gitUsername email; };

		system = "x86_64-linux";
		pkgs = inputs.nixpkgs.legacyPackages.${system};
		extraSpecialArgs = { inherit inputs system userVars; };

		homeManagerConfig = inputs.home-manager.lib.homeManagerConfiguration;

		nix-index-database = [ inputs.nix-index-database.hmModules.nix-index ];
		catppuccin = [ inputs.catppuccin.homeManagerModules.catppuccin ];
	in {
		homeConfigurations = {
			"tomm@desktop" = homeManagerConfig {
				inherit pkgs extraSpecialArgs;
				modules =
				nix-index-database ++
				catppuccin ++ [
					./hosts/desktop.nix
				];
			};

			"tomm@laptop" = homeManagerConfig {
				inherit pkgs extraSpecialArgs;
				modules =
				nix-index-database ++
				catppuccin ++ [
					./hosts/laptop.nix
				];
			};
		};
	};
}
