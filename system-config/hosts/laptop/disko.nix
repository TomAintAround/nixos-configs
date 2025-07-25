{
	device ? throw "Set this to your disk device, e.g. /dev/sda",
	...
}: {
	disko.devices = {
		disk.main = {
			inherit device;
			type = "disk";
			content = {
				type = "gpt";
				partitions = {
					ESP = {
						name = "ESP";
						size = "512M";
						type = "EF00";
						content = {
							type = "filesystem";
							format = "vfat";
							mountpoint = "/boot";
							mountOptions = [
								"defaults"
							];
						};
					};

					swap = {
						name = "swap";
						size = "20G";
						content = {
							type = "swap";
							randomEncryption = true;
							priority = 100;
						};
					};

					root = {
						name = "root";
						size = "100G";
						content = {
							type = "luks";
							name = "cryptedroot";
							settings.allowDiscards = true;
							passwordFile = "/tmp/secret.key";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ];
								subvolumes = {
									"@" = {
										mountpoint = "/";
										mountOptions = [ "compress=zstd" "noatime" ];
									};

									"@nix" = {
										mountpoint = "/nix";
										mountOptions = [ "compress=zstd" "noatime" ];
									};
								};
							};
						};
					};

					home = {
						name = "home";
						size = "100%";
						content = {
							type = "luks";
							name = "cryptedhome";
							settings.allowDiscards = true;
							passwordFile = "/tmp/secret.key";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ];
								subvolumes = {
									"@home" = {
										mountpoint = "/home";
										mountOptions = [ "compress=zstd" "noatime" ];
									};
								};
							};
						};
					};
				};
			};
		};
	};
}
