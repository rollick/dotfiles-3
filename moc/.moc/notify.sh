#!/bin/sh
export DISPLAY=":0"
notify-send --urgency=low "${1}\nby ${2}\non ${3}"
