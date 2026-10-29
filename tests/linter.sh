#!/usr/bin/env bash

lintFlake() {
	if [ "$#" -ne 1 ]; then
		echo "Invalid number of arguments"
		exit 1
	fi

	echo "Linting $1 flake..."
	nix run --extra-experimental-features 'nix-command flakes' nixpkgs#statix -- check "./$1" || {
		echo "Lint failed, listing $1 flake.lock for debugging:"
		cat ./"$1"/flake.lock
		exit 1
	}
}

lintFlake home-manager/tomm
lintFlake system-config
