# Changing Directories
setopt AUTO_CD              # Unknown commands are treated as 'cd command'
setopt AUTO_PUSHD           # cd pushes old directory onto stack
setopt NO_CHASE_DOTS        # Resolve path to physical directory when using '..'
setopt PUSHD_IGNORE_DUPS    # Don't push dupes onto the stack

# Completion
setopt COMPLETE_IN_WORD     # Complete inside of words
setopt GLOB_COMPLETE        # Don't insert all matches of pattern, show a menu
setopt HASH_LIST_ALL        # Always hash entire command paths

# Expansion and Globbing
setopt BRACE_CCL            # Advanced expansion in brackets
setopt EXTENDED_GLOB        # '#', '~' and '^' are part of globbing patterns

# History
setopt EXTENDED_HISTORY     # Use timestamps in $HISTFILE
setopt HIST_IGNORE_ALL_DUPS # Remove all duplicate commands from history
setopt HIST_IGNORE_SPACE    # Don't save ' command' to $HISTFILE
setopt HIST_NO_STORE        # Don't save 'fc -l' in $HISTFILE
setopt HIST_REDUCE_BLANKS   # Remove superfluos blanks from commands
setopt HIST_VERIFY          # Never run a command with history expansions directly
setopt INC_APPEND_HISTORY   # Incrementaly update histpry
setopt SHARE_HISTORY        # Share history between two sessions

# Jobs
setopt BG_NICE              # Run background jobs at lower priority

# Input/Output
setopt HASH_CMDS            # Hash location of each command
setopt INTERACTIVE_COMMENTS # Honor comments in interactive mode
setopt NO_CLOBBER           # Secure pipe handling
setopt NO_CORRECT           # Correct spelling of commands
setopt NO_CORRECT_ALL       # Correct spelling of arguments
setopt RM_STAR_WAIT         # Wait 10 secs, when issuing e.g. 'rm *'

# Prompting
setopt PROMPT_SUBST         # Substitions in a prompt are performed
setopt TRANSIENT_RPROMPT    # Hide RPROMPT when the current command is too long

# Set history options
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
export HISTSIZE=12000
export SAVEHIST=10000
