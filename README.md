# NixOS config

## What is this?

This repository has the [NixOS](https://nixos.org/) configurations for my systems (desktop PC and laptop) and the [Home Manager](https://nix-community.github.io/home-manager/) configurations for my user. They are made specifically for me, and I very rarely take into account other systems.

Unless your hardware is the exact same as one of my systems, you **should absolutely not** simply copy everything without making any changes whatsoever. Even if somehow your hardware coincides with one of my systems, **you should still read my configurations and try to understand them**. To do that, I recommend reading the rest of this README.

I'm absolutely not an expert at Nix, so there will be mistakes. This configuration might not be very optimized, and its structure might be weird.

## Philosophy

I want my systems to be multi-host and multi-user compatible. This means that it can be applied to multiple machines, which can contain multiple users. This means that the system configurations and each users' home-manager configurations are separate, each containing their own flakes. So while one user can update their packages every other nanosecond, the other can update them every 10 years.

## How to install?

If you read everything I said above, take at least 10 seconds to look at my configurations and have no idea how to install this, then you should absolutely learn about Nix first. There are a lot of YouTube videos teaching everything about Nix. I recommend starting there.
