#!/bin/bash

# Set default encrypted session via rsync to ssh
if which ssh >/dev/null 2>&1; then
	export RSYNC_RSH='ssh'
fi
