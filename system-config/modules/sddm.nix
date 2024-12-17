{ pkgs, ... }: {
	services = {
		displayManager = {
			sddm = {
				enable = true;
				autoNumlock = true;
			};
		};
	};

	environment.systemPackages = with pkgs.libsForQt5.qt5; [
		qtquickcontrols2
		qtgraphicaleffects
	];
}
