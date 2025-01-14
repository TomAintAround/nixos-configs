{ lib, config, pkgs, ... }: {
	boot = {
		kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
		kernelParams = [ "nvidia-drm.modeset=1" ];
		extraModprobeConfig = ''
			options nvidia-drm modeset=1 fbdev=1
		'';
	};

	hardware = {
		nvidia = {
			modesetting.enable = true;
			powerManagement.enable = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			open = true;
			videoAcceleration = true;
		};
	};

	services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

	environment.variables = {
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NVD_BACKEND = "direct";
	};
}
