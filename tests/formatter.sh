#!/usr/bin/env bash

nix run --extra-experimental-features 'nix-command flakes' nixpkgs#alejandra -- --check .
