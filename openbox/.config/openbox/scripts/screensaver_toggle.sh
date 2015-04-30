#!/bin/bash
ICON_NAME="screensaver"
TITLE="Screensaver"
if LC_ALL=C xset q |grep "DPMS is Enabled"; then
	TEXT="Disable screensaver?"
	if zenity --question --title="${TITLE}" --default-cancel --text="${TEXT}" --icon-name="${ICON_NAME}"; then
		xset -dpms
		xautolock -disable
	fi
else
	TEXT="Enable screensaver?"
	if zenity --question --title="${TITLE}" --default-cancel --text="${TEXT}" --icon-name="${ICON_NAME}"; then
		xset +dpms
		xautolock -enable
	fi
fi
