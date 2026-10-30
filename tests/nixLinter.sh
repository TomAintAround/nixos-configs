#!/usr/bin/env bash

nix run --extra-experimental-features 'nix-command flakes' nixpkgs#statix -- \
	check . -i "$(bash util/getSubmodulesPaths.sh)"
