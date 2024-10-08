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

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?rev=9a09eac79b85c846e3a865a9078a3f8ff65a9259&submodules=1";

        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };

        split-monitor-workspaces = {
            url = "github:Duckonaut/split-monitor-workspaces";
            inputs.hyprland.follows = "hyprland";
        };

        hyprfocus = {
            url = "github:pyt0xic/hyprfocus";
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
