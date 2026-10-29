#!/usr/bin/env bash

TESTS_DIR="./tests"
EXIT_CODE=0

printf "\033[0;36m-=-=-=-=-=-=-=-=-\033[0m\n"
for test in "$TESTS_DIR"/*.sh; do
	[[ -f "$test" ]] || continue

	printf "\033[0;33mRunning: %s\033[0m\n" "$test"
	if bash "$test"; then
		printf "\033[0;33m%s:\033[0m \033[0;32msuccessful  \033[0m\n" "$test"
	else
		printf "\033[0;33m%s:\033[0m \033[0;31mfailed  \033[0m\n" "$test"
		((EXIT_CODE++))
	fi

	printf "\033[0;36m-=-=-=-=-=-=-=-=-\033[0m\n"
done

exit "$EXIT_CODE"
