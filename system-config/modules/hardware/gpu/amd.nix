{ lib, ... }: {
	services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" "modesetting" ];

	hardware = {
		amdgpu = {
			opencl.enable = true;
			amdvlk = {
				enable = true;
				support32Bit.enable = true;
			};
		};
	};
}
