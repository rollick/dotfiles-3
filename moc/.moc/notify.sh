#!/bin/sh
export DISPLAY=":0"
notify-send --urgency=low --icon="audio-player" "${1}" "by ${2}\non ${3}"
