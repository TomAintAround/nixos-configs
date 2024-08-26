# System Configuration

## ⚠️ WARNING ⚠️ 

Please try to understand this configuration before actually installing it (I suggest starting by reading the [`flake.nix` file](https://github.com/TomAintAround/nixos-configs/blob/main/home-manager/flake.nix)).

## How to update

Updating the `flake.lock` means that you'll have different versions for your packages compared to me. Therefore, you might have problems that I won't have. This repository is more an example for others anyway, so don't let this demotivate you.
```sh
$ nix flake update ~/.config/home-manager
$ home-manager switch --option eval-cache false --flake ~/.config/home-manager
```

## How to install

(This guide assumes you are installing this through the NixOS ISO.)

1. Download this repository:
```sh
$ nix-shell -p git --run 'git clone https://github.com/TomAintAround/nixos-configs /tmp/nixos-config'
$ cd /tmp/nixos-config
```

2. Modify it to your will. I recommend modifying the [`flake.nix` output's variables](https://github.com/TomAintAround/nixos-configs/blob/main/home-manager/flake.nix).

3. Move the system configuration to `~/.config/home-manager`.
```sh
$ rm -rI ~/.config/home-manager/
$ cp -r home-manager ~/.config/
```

4. Add a `secrets.nix` file to `~/.config/home-manager` with the following format. If you actually tried to understand this configuration, you might already know what it does.
```nix
{
    email = "Insert email here";
}
```

6. Install.
```sh
$ home-manager switch --option eval-cache false --flake ~/.config/home-manager
```
