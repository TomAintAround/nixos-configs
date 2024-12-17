#!/usr/bin/env bash
set -euf
if [ -n "${FIFO_UEBERZUG-}" ]; then
	printf '{"action":"remove","identifier":"preview"}\n' >"$FIFO_UEBERZUG"
fi
