#!/bin/env python
"""This file will be executed when running python as an shell."""
import atexit
from imp import reload  # noqa
import os
from pprint import pprint  # noqa
import readline
import sys

HISTFILE = os.path.join(
    os.getenv('XDG_CACHE_HOME') or '~/.cache',
    ''.join(
        (
            'python',
            str(sys.version_info.major),
            '_history'
        )
    )
)

try:
    readline.read_history_file(HISTFILE)
except IOError:
    pass

atexit.register(readline.write_history_file, HISTFILE)

# Cleanup
del HISTFILE
del atexit
del os
del readline
del sys
