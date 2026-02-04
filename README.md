# NixOS config

## What is this?

This repository has the [NixOS](https://nixos.org/) configurations for my systems (desktop PC and laptop) and the [Home Manager](https://nix-community.github.io/home-manager/) configurations for my user. They are made specifically for me, and I very rarely take into account other systems.

Unless your hardware is the exact same as one of my systems, you **should absolutely not** simply copy everything without making any changes whatsoever. Even if somehow your hardware coincides with one of my systems, **you should still read my configurations and try to understand them**. To do that, I recommend reading the rest of this README.

I'm absolutely not an expert at Nix, so there will be mistakes. This configuration might not be very optimized, and its structure might be weird.

## Philosophy

I want my systems to be multi-host and multi-user compatible. This means that it can be applied to multiple machines, which can contain multiple users and that the system configurations and each users' home-manager configurations are separate, each containing their own flakes. So while one user can update their packages every other nanosecond, the other can update them every 10 years.
This repo is situated in `/etc/nixos`, with ownership set to nobody:wheel and permissions set to 775. This means that the only ones who can edit the configurations are part of the wheel group. The only exception are the directories in `home-manager`, whose ownerships are set to <username>:users and permissions are set to 755, meaning only the user can edit their home-manager files.
This is all done through activation scripts.

## How to install?

If you read everything I said above, take at least 10 seconds to look at my configurations and have no idea how to install this, then you should absolutely learn about Nix first. There are a lot of YouTube videos teaching everything about Nix. I recommend starting there.
