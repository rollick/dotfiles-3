#!/bin/bash
# Set path to Xauthority file
if [[ -z $XDG_GREETER_DATA_DIR ]]; then
	export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
fi
