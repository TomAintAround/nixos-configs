# System Configuration

## ⚠️ WARNING ⚠️

Please try to understand this configuration before actually installing it (I suggest starting by reading the [`flake.nix` file](https://github.com/TomAintAround/nixos-configs/blob/main/system-config/flake.nix)). In fact, **it might be even better to not install this and just copy bits of what I do**.

## How to update

Updating the `flake.lock` means that you'll have different versions for your packages compared to me. Therefore, you might have problems that I won't have. This repository is more an example for others anyway, so don't let this demotivate you.
```sh
$ sudo nix flake update /etc/nixos
$ sudo nixos-rebuild switch --upgrade --option eval-cache false --flake /etc/nixos/
```

## How to install

(This guide assumes you are installing this through the NixOS ISO.)

1. Download this repository:
```sh
$ nix-shell -p git --run 'git clone https://github.com/TomAintAround/nixos-configs /tmp/nixos-config'
$ cd /tmp/nixos-config
```

2. Modify it to your will. I recommend modifying the [user configurations](https://github.com/TomAintAround/nixos-configs/tree/main/system-config/modules/users). If you want to add hardware specific configurations that are not available here, I recommend looking [here](https://github.com/NixOS/nixos-hardware) and especially [here](https://github.com/NixOS/nixos-hardware/tree/master/common).

3. Move the system configuration to `/etc/nixos/`.
```sh
$ rm -rI /mnt/etc/nixos/
$ cp -r system-config /mnt/etc/nixos
```

4. Add a `secrets.nix` file to `/etc/nixos/` with the following format. If you actually tried to understand this configuration, you might already know what it does. Of course, this step might not apply if you change your user configurations. If you don't want passwords to be stored in files, make sure to remove `users.mutableUsers = false;` [here](https://github.com/TomAintAround/nixos-configs/blob/main/system-config/modules/base.nix). If you don't know how to create hashed password, [look here](https://jasonmurray.org/posts/2020/clipasswd/)
```nix
{
    passwords = {
        root = "Insert hashed password here";
        user = "Insert hashed password here";
    }

    names.user = "Insert real name here";
}
```

5. Unless you changed [Disko](https://github.com/nix-community/disko)'s configurations to not use LUKS disk encryption, create a file in `/tmp/` called `secret.key` with the following format:
```txt
Insert password here. This file must have only 1 line.
```

6. Install. Replace `--no-root-passwd` if you decided to not store passwords in a file and `desktop` with the name of the system you want to install.
```sh
$ nixos-install --root /mnt --no-root-passwd --flake /etc/nixos#desktop
```

7. (OPTIONAL) If you decided not to store passwords in a file, make sure to set a password for root. To set a user password, do the following:
```sh
$ nixos-enter --root /mnt
$ passwd InsertUsernameHere
```

8. Unmount and reboot.
```sh
$ umount -r /mnt
$ reboot
```
