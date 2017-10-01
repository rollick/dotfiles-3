#!/bin/bash
# Set terminal information, which is used by some programs

terminals=(
	'st'
	'xfce4-terminal'
)

for terminal in ${terminals}; do
	if which "${terminal}" >/dev/null 2>&1; then
		export COLORTERM="${terminal}"
		export TERMCMD="${terminal}"
		export TERMINAL="${terminal}"

		break
	fi
done

unset terminal
unset terminals
