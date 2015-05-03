#!/bin/sh
export DISPLAY=":0"


albumart="$(dirname "${4}")/folder.jpg"
if [[ -f "${albumart}" ]]; then
	icon="${albumart}"
else
	icon="audio-x-generic"
fi

notify-send --urgency=low --icon="${icon}" "${1}" "by ${2}\non ${3}"
