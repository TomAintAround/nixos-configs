{ lib, ... }: {
	boot.initrd.postDeviceCommands = lib.mkAfter ''
		mkdir /btrfs_tmp
		mount /dev/mapper/cryptedroot /btrfs_tmp
		if [[ -e /btrfs_tmp/@ ]]; then
			mkdir -p /btrfs_tmp/old_roots
			timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@)" "+%Y-%m-%-d_%H:%M:%S")
			mv /btrfs_tmp/@ "/btrfs_tmp/old_roots/$timestamp"
		fi
		
		delete_subvolume_recursively() {
			IFS=$'\n'
			for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
				delete_subvolume_recursively "/btrfs_tmp/$i"
			done
			btrfs subvolume delete "$1"
		}

		for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +14); do
			delete_subvolume_recursively "$i"
		done

		btrfs subvolume create /btrfs_tmp/@
		umount /btrfs_tmp
	'';

	fileSystems."/persist".neededForBoot = true;
	environment.persistence."/persist/system" = {
		hideMounts = true;
		directories = [
			"/etc/libvirt"
			"/etc/NetworkManager/system-connections"
			"/etc/nixos"
			"/var/lib/bluetooth"
			"/var/lib/docker"
			"/var/lib/flatpak"
			"/var/lib/fprint"
			"/var/lib/libvirt"
			"/var/lib/nixos"
			"/var/lib/systemd/coredump"
			"/var/log"
			{
				directory = "/var/lib/colord";
				user = "colord";
				group = "colord";
				mode = "u=rwx,g=rw,o=";
			}
		];
		files = [
			"/etc/machine-id"
			{
				file = "/var/keys/secret_file";
				parentDirectory = { mode = "u=rwx,g=,o="; };
			}
		];
	};
}
