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

		nix-index-database = [ inputs.nix-index-database.homeModules.nix-index ];
		catppuccin = [ inputs.catppuccin.homeModules.catppuccin ];
	in {
		homeConfigurations = {
			"tomm@desktop" = homeManagerConfig {
				inherit pkgs extraSpecialArgs;
				modules =
					nix-index-database ++
					catppuccin ++
					[ ./hosts/desktop.nix ];
			};

			"tomm@laptop" = homeManagerConfig {
				inherit pkgs extraSpecialArgs;
				modules =
					nix-index-database ++
					catppuccin ++
					[ ./hosts/laptop.nix ];
			};
		};
	};
}
