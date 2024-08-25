{ pkgs, lib, config, ... }: {
    environment = {
        localBinInPath = true;
        systemPackages = with pkgs; [
            git
            home-manager
            libnotify
            libsecret
        ];
    };

    programs = {
	nix-ld.enable = true;
	appimage.enable = true;
	gamemode.enable = true;
    };
    
    services.flatpak.enable = true;

    xdg.portal.enable = lib.mkIf config.services.flatpak.enable (lib.mkForce true);
}
