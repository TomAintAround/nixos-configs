#!/usr/bin/env bash

IGNORED_SUBMODULES=()
i=0
while IFS= read -r path; do
	IGNORED_SUBMODULES[i++]="$path"
done < <(git config --file .gitmodules --get-regexp path | awk '{print $2}')
echo "${IGNORED_SUBMODULES[@]}"
