#!/bin/zsh
() {
	local hook

	for hook in "${ZDOTDIR}/hooks"/*(.N); do
		hook="${hook:t}"

		if [[ -n "${functions[${hook}]}" ]]; then
			add-zsh-hook "${hook//-*/}" "${hook}"
		fi
	done
}
