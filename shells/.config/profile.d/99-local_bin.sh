#!/bin/bash
# Add some directories to path

local_bin="${XDG_DATA_HOME:-${HOME}/.local/share}/../bin"
local_bin="$(readlink -f "${local_bin}")"

if [[ -d "${local_bin}" ]]; then
	export PATH="${local_bin}:${PATH}"
fi

unset local_bin
