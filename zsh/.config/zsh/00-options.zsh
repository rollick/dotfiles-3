#!/bin/zsh
() {
	local option
	local options

	options=(
		# Changing Directories
		'AUTO_CD'              # Unknown commands are treated as 'cd command'
		'AUTO_PUSHD'           # cd pushes old directory onto stack
		'NO_CHASE_DOTS'        # Resolve path to physical directory when
		                       # using '..'
		'PUSHD_IGNORE_DUPS'    # Don't push dupes onto the stack

		# Completion
		'COMPLETE_IN_WORD'     # Complete inside of words
		'GLOB_COMPLETE'        # Don't insert all matches of pattern, show a
		                       # menu
		'HASH_LIST_ALL'        # Always hash entire command paths

		# Expansion and Globbing
		'BRACE_CCL'            # Advanced expansion in brackets
		'EXTENDED_GLOB'        # '#', '~' and '^' are part of globbing patterns

		# History
		'EXTENDED_HISTORY'     # Use timestamps in $HISTFILE
		'HIST_IGNORE_ALL_DUPS' # Remove all duplicate commands from history
		'HIST_IGNORE_SPACE'    # Don't save ' command' to $HISTFILE
		'HIST_NO_STORE'        # Don't save 'fc -l' in $HISTFILE
		'HIST_REDUCE_BLANKS'   # Remove superfluos blanks from commands
		'HIST_VERIFY'          # Never run a command with history expansions
		                     # directly
		'INC_APPEND_HISTORY'   # Incrementaly update histpry
		'SHARE_HISTORY'        # Share history between two sessions

		# Jobs
		'BG_NICE'              # Run background jobs at lower priority

		# Input/Output
		'HASH_CMDS'            # Hash location of each command
		'INTERACTIVE_COMMENTS' # Honor comments in interactive mode
		'NO_CLOBBER'           # Secure pipe handling
		'NO_CORRECT'           # Correct spelling of commands
		'NO_CORRECT_ALL'       # Correct spelling of arguments
		'RM_STAR_WAIT'         # Wait 10 secs, when issuing e.g. 'rm *'

		# Prompting
		'PROMPT_SUBST'         # Substitions in a prompt are performed
		'TRANSIENT_RPROMPT'    # Hide RPROMPT when the current command is too
		                     # long
	)

	for option in "${(@)options}"; do
		setopt "${option}"
	done
}

# Set history options
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
export HISTSIZE=12000
export SAVEHIST=10000

# Create needed directories
() {
	local cache_dir

	cache_dir="$(dirname "${HISTFILE}")"

	if [[ ! -d "${cache_dir}" ]]; then
		mkdir --parent "${cache_dir}"
	fi
}
