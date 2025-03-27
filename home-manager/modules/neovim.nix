{ config, ... }: {
	programs.neovim.enable = true;
	xdg.configFile."nvim".source = "${config.xdg.configHome}/home-manager/modules/neovim";
}
