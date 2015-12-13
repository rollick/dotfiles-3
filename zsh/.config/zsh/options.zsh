# Changing Directories
setopt AUTO_CD				# Unknown commands are treated as 'cd command'
setopt AUTO_PUSHD			# cd pushes old directory onto stack
setopt PUSHD_IGNORE_DUPS	# Don't push dupes onto the stack

# Completion
setopt COMPLETE_IN_WORD		# Complete inside of words
setopt GLOB_COMPLETE		# Don't insert all matches of pattern, show a menu
setopt HASH_LIST_ALL		# Always hash entire command paths

# Expansion and Globbing
setopt EXTENDED_GLOB		# '#', '~' and '^' are part of globbing patterns
setopt BRACE_CCL			# Advanced expansion in brackets

# History
setopt EXTENDED_HISTORY		# Use timestamps in $HISTFILE
setopt HIST_IGNORE_ALL_DUPS	# Remove all duplicate commands from history
setopt HIST_IGNORE_SPACE	# Don't save ' command' to $HISTFILE
setopt HIST_NO_STORE		# Don't save 'fc -l' in $HISTFILE
setopt HIST_REDUCE_BLANKS	# Remove superfluos blanks from commands
setopt HIST_VERIFY			# Never run a command with history expansions directly
setopt INC_APPEND_HISTORY	# Incrementaly update histpry
setopt SHARE_HISTORY		# Share history between two sessions

# Jobs
setopt BG_NICE				# Run background jobs at lower priority

# Input/Output
setopt CORRECT				# Correct spelling of commands
setopt HASH_CMDS			# Hash location of each command
setopt INTERACTIVE_COMMENTS	# Honor comments in interactive mode
setopt NO_CLOBBER			# Secure pipe handling
setopt RM_STAR_WAIT			# Wait 10 secs, when issuing e.g. 'rm *'

# Prompting
setopt PROMPT_SUBST			# Substitions in a prompt are performed
setopt TRANSIENT_RPROMPT	# Hide RPROMPT when the current command is too long