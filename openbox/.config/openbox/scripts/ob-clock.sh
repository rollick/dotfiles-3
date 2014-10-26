#!/bin/sh
if which lal >/dev/null 2>&1; then
	lal --format "%A" &
	sleep 1
	lal --format "%F" &
	sleep 1
	lal --format "%R" &
fi
