#!/usr/bin/env bash

nix run --extra-experimental-features 'nix-command flakes' nixpkgs#alejandra -- \
	--check . --exclude "$(bash util/getSubmodulesPaths.sh)" || {
	printf "\033[1;31m FIX:\033[0m Run './fixFormat.sh' to fix formatting\n"
	exit 1
}
