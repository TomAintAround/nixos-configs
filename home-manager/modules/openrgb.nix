{ pkgs, lib, config, ... }: {
	home = lib.mkIf config.openrgb.enable {
		packages = with pkgs; [
			openrgb-plugin-effects
			openrgb-plugin-hardwaresync
		];
		activation.setup-openrgb-plugins = lib.mkBefore (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			run ln -sf ${pkgs.openrgb-plugin-effects}/lib/libOpenRGBEffectsPlugin.so ${config.xdg.configHome}/OpenRGB/plugins/libOpenRGBEffectsPlugin.so
			run ln -sf ${pkgs.openrgb-plugin-hardwaresync}/lib/libOpenRGBHardwareSyncPlugin.so ${config.xdg.configHome}/OpenRGB/plugins/libOpenRGBHardwareSyncPlugin.so
		'');
	};
}
