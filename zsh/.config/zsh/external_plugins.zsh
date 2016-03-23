export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

if [[ ! -d "${ZPLUG_HOME}" ]]; then
	ZPLUG_FIRST_RUN=1

	curl -fLo "${ZPLUG_HOME}/zplug" --create-dirs "https://git.io/zplug"
fi

if [[ -d "${ZPLUG_HOME}" ]]; then
	source "${ZPLUG_HOME}/zplug"

	if [[ -n "${ZPLUG_FIRST_RUN}" ]]; then
		unset ZPLUG_FIRST_RUN
		zplug update --self
	fi

	zplug "hlissner/zsh-autopair"
	zplug "zsh-users/zsh-completions"
	zplug "zsh-users/zsh-syntax-highlighting"

	if ! zplug check; then
		zplug install
	fi

	zplug load
fi

unset TMPDIR

# Include external additions provided by packages
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/bin/virtualenvwrapper.sh" &>|/dev/null
