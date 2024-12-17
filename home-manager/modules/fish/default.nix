{
	imports = [
		./aliases.nix
		./init.nix
		./plugins.nix
	];

	programs.fish = {
		enable = true;
	};
}
