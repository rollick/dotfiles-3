#!/bin/bash
# Set default browser
browsers=(
	'firefox'
	'chromium'
)

if [[ -z ${BROWSER} ]]; then
	for browser in ${browsers}; do
		if which "${browser}" >/dev/null 2>&1; then
			export BROWSER="${browser}"

			break
		fi
	done
fi

unset browser
unset browsers
