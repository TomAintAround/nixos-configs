{ lib, config, ... }: {
	boot = {
		kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
		kernelParams = [ "nvidia-drm.modeset=1" ];
		extraModprobeConfig = ''
			options nvidia-drm modeset=1 fbdev=1
		'';
	};

	hardware = {
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			gsp.enable = true;
			modesetting.enable = true;
			nvidiaSettings = true;
			open = true;
			powerManagement.enable = true;
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
