#!/bin/bash
# Fix some issues if no DE is used
if [[ -z ${DESKTOP_SESSION} ]]; then
	export DE='xfce'
	export DESKTOP_SESSION='xfce'
	export XDG_CURRENT_DESKTOP='XFCE'
fi
