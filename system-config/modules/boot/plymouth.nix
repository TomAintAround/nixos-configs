{ pkgs, lib, ... }: let
	themeName = "cross_hud";
in {
	boot = {
		plymouth = {
			enable = true;
			theme = themeName;
			themePackages = with pkgs; [
				(adi1090x-plymouth-themes.override {
					selected_themes = [ themeName ];
				})
			];
		};
		consoleLogLevel = lib.mkForce 3;
		initrd = {
			systemd.enable = lib.mkForce true;
			verbose = lib.mkForce false;
		};
		kernelParams = [
			"quiet"
			"splash"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"
		];	
		loader.timeout = lib.mkForce 0;
	};
}
