{ lib, pkgs, ... }: {
	services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" "modesetting" ];

	hardware = {
		amdgpu = {
			opencl.enable = true;
			initrd.enable = lib.mkDefault true;
			amdvlk = {
				enable = true;
				support32Bit.enable = true;
			};
		};
	};
}
