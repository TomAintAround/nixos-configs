#!/usr/bin/env bash

nix run --extra-experimental-features 'nix-command flakes' nixpkgs#alejandra -- .
nix run --extra-experimental-features 'nix-command flakes' nixpkgs#stylua -- \
	--allow-hidden . --respect-ignores "$(bash util/getSubmodulesPaths.sh)"
