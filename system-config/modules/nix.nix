{
	nix = {
		gc = {
			automatic = true;
			dates = "daily";
			options = "--delete-older-than 14d";
		};
		optimise.automatic = true;
		settings = {
			auto-optimise-store = true;
			experimental-features = [ "nix-command" "flakes" ];
		};
	};

	nixpkgs.config.allowUnfree = true;
}
