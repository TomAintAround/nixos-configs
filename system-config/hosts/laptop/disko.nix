{
  inputs,
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}: {
  imports = [inputs.disko.nixosModules.default];

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
              mountOptions = ["umask=0077"];
            };
          };

          root = {
            name = "root";
            size = "100G";
            content = {
              type = "luks";
              name = "cryptedroot";
              settings = {
                allowDiscards = true;
                keyFile = "/tmp/secret.key";
              };
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "20G";
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
              settings = {
                allowDiscards = true;
                keyFile = "/tmp/secret.key";
              };
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
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
