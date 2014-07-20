#!/bin/env python3
# Copyright (C) 2014 by Raphael Scholer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
""" Python 3.x bindings for MusicOnConsole.

Constants:
    MOC_BIN -- MOC binary.
    STATES -- MOC states.

Exceptions:
    MocError -- Undefined MOC error.
    MocNotInstalled -- Moc binary (mocp) could not be found.
    MocNotRunning -- Server is not running.

Functions:
    _exec_command -- Execute MOC commands
    _generate_info -- Convert text to dict.
    info --  Retrieve information about the current track.
    playlist_get -- Get all playlist entries
"""
import os
import subprocess


MOC_BIN = 'mocp'

STATES = {'NOT RUNNING': -1,
          'STOP': 0,
          'PAUSE': 1,
          'PLAY': 2}


class MocError(Exception):
    """ Base class for exceptions. """


class MocNotFound(MocError):
    """ Moc binary (mocp) could not be found. """


class MocNotRunning(MocError):
    """ Server is not running. """


def _exec_command(cmnds=None):
    """ Execute MOC commands

    Keyword arguments:
        cmds -- Dictionary containing option/argument pairs. If an option has
                 no argument set argument to None. (Default: None)
                 Example: {'play': None, 'config' '/tmp/moc'}

    Raised Exceptions:
        MocNotFound
        MocNotRunning
        ocError

    Return value:
        str -- Standard output of mocp
    """
    cmdline = [MOC_BIN]
    for option, argument in cmnds.items():
        cmdline.append('--{}'.format(option))
        if argument is not None:
            if isinstance(argument, (tuple, list)):
                for arg in argument:
                    cmdline.append(arg)
            else:
                cmdline.append(argument)

    # Make sure to only use english language output
    environ = os.environ
    environ.update({'LC_ALL': 'C'})

    try:
        cmd = subprocess.Popen(cmdline,
                               env=environ,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    except FileNotFoundError:
        raise MocNotFound('"{}" could not be found.'.format(MOC_BIN))

    stdout, stderr = cmd.communicate()
    stdout = stdout.decode()
    stderr = stderr.decode()

    if cmd.returncode:
        errmsg = stderr.strip()
        errmsg = errmsg.splitlines()

        # Only print relevant error messages
        errmsg = [x for x in errmsg if not x == ''
                  and not x.startswith('Can\'t')]
        errmsg = ', '.join(errmsg)

        if 'server is not running' in errmsg:
            raise MocNotRunning
        else:
            raise MocError(errmsg)

    return stdout


def _generate_info(text, ignored_keys=None):
    """ Convert text to dict.

        Keyword arguments:
            text -- String containing a key/value pair on each line separated
                    by a colon.
            ignored_keys -- List of keys which will be ignored. (Default: None)

        Return value:
            dict
    """
    dct = {}
    ignored_keys = ignored_keys or []

    # Make sure ignored keys are always lowercase
    ignored_keys = [x.lower() for x in ignored_keys]

    for elem in text.splitlines():
        key, _, value = elem.partition(':')
        key = key.strip()
        key = key.lower()
        value = value.strip()
        if key and key not in ignored_keys:
            dct.update({key: value})

    return dct


def info():
    """  Retrieve information about the current track.

    Return value:
        dict -- Dictionary containing all info
    """
    try:
        output = _exec_command({'info': None})
    except MocNotRunning:
        return {'state': STATES['NOT RUNNING']}

    output = _generate_info(output)
    output.update({'state': STATES[output['state']]})
    return output


def playlist_get(mocdir=None):
    """ Get all playlist entries

    Keyword arguments:
        mocdir -- Path to MOCDIR. (Default: None)

    Return value:
        list -- list containing tuples of the form:
                ('Song info', 'Path').
                Song info is of the form: '<artist> - <title> (<album>)'.
    """
    mocdir = mocdir or os.path.expanduser('~/.moc')
    playlist_path = os.path.join(mocdir, 'playlist.m3u')
    entries = []

    if os.path.exists(playlist_path):
        with open(playlist_path, 'r') as playlist_file:
            # Check header (first two lines)
            header = [next(playlist_file) for line in range(2)]

            if header[0].startswith('#EXTM3U') and \
               header[1].startswith('#MOCSERIAL'):

                for line in playlist_file:
                    title = line.partition(',')[2]
                    path = next(playlist_file)

                    entries.append((title.strip(), path.strip()))

    return entries
