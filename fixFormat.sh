#!/usr/bin/env bash

nix run --extra-experimental-features 'nix-command flakes' nixpkgs#alejandra -- \
	. --exclude "$(bash util/getSubmodulesPaths.sh)"
nix run --extra-experimental-features 'nix-command flakes' nixpkgs#stylua -- \
	--allow-hidden . --respect-ignores "$(bash util/getSubmodulesPaths.sh)"
