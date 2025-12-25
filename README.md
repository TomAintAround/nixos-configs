# NixOS config

## What is this?

This repository has the [NixOS](https://nixos.org/) configurations for my systems (desktop PC and laptop) and the [Home Manager](https://nix-community.github.io/home-manager/) configurations for my user. They are made specifically for me, and I very rarely take into account other systems.

Unless your hardware is the exact same as one of my systems, you **should absolutely not** simply copy everything without making any changes whatsoever. Even if somehow your hardware coincides with one of my systems, **you should still read my configurations and try to understand them**. To do that, I recommend reading the rest of this README.

I'm absolutely not an expert at Nix, so there will be mistakes. This configuration might not be very optimized, and its structure might be weird.

## Philosophy

I want my systems to be multi-host and multi-user compatible. This means that it can be applied to multiple machines, which can contain multiple users. This means that:
- [My system configurations](https://github.com/TomAintAround/nixos-configs/tree/main/system-config) are placed in `/etc/nixos/`. Therefore, to modify and update them, admin privileges are needed. If they were in a user's home directory, they wouldn't be accessible to everyone (who is in the wheel at least). Besides, some things should require admin privileges to be run, especially these configurations.
- [My Home Manager configurations](https://github.com/TomAintAround/nixos-configs/tree/main/home-manager) are placed in `~/.config/home-manager/`. Therefore, they don't need admin privileges to be modified and updated. Also, apart from absolutely necessary packages, all packages are installed through home-manager, giving each user more freedom to define what packages they want.

## How to install?

Even if you just want to copy what I do (like you probably should), I still recommend reading these guides. They can help you understand this configuration.
- [Install system configuration](https://github.com/TomAintAround/nixos-configs/blob/main/system-config/README.md)
- [Install Home Manager Configuration](https://github.com/TomAintAround/nixos-configs/blob/main/home-manager/README.md)
