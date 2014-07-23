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

Exceptions:
    MocError -- Undefined MOC error.
    MocNotInstalled -- Moc binary (mocp) could not be found.

Functions:
    info --  Retrieve information about the current track.
    playlist_get -- Get all playlist entries
"""
import os
import subprocess


MOC_BIN = 'mocp'


class MocError(Exception):
    """ Base class for exceptions. """


class MocNotFound(MocError):
    """ Moc binary (mocp) could not be found. """


def info():
    """  Retrieve information about the current track.

    Return value:
        dict -- Dictionary containing all info
    """
    dct = {}

    # Make sure to only use english language output
    environ = os.environ
    environ.update({'LC_ALL': 'C'})

    try:
        cmd = subprocess.Popen([MOC_BIN, '--info'],
                               env=environ,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    except FileNotFoundError:
        raise MocNotFound('"{}" could not be found.'.format(MOC_BIN))

    stdout, stderr = cmd.communicate()
    stdout = stdout.decode()
    stderr = stderr.decode()

    if cmd.returncode:
        if 'server is not running' in stderr:
            return {'state': 'NOT RUNNING'}
        else:
            raise MocError(errmsg)

    for elem in stdout.splitlines():
        key, _, value = elem.partition(':')
        key = key.strip()
        key = key.lower()
        value = value.strip()
        dct.update({key: value})

    return dct


def playlist_get(mocdir=None):
    """ Get all playlist entries

    Keyword arguments:
        mocdir -- Path to MOCDIR. (Default: None)

    Return value:
        list -- list containing dictionaries
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
                    # Split line in needed parts
                    totalsecs, _, line = line.partition(',')

                    # Artist
                    artist = line.partition(' - ')[0]

                    # Album
                    album = line.rpartition(')')[0].rpartition(' (')[2]

                    # Song title
                    title = line.partition(' - ')[2].rpartition(' (')[0]

                    # Calculate totaltime
                    totalsecs = totalsecs.partition(':')[2]
                    _min, sec = divmod(int(totalsecs), 60)
                    _min = str(_min).zfill(2)
                    sec = str(sec).zfill(2)
                    totaltime = '{}:{}'.format(_min, sec)

                    info = {'artist': artist.strip(),
                            'album': album.strip(),
                            'songtitle': title.strip(),
                            'totalsecs': totalsecs,
                            'totaltime': totaltime,
                            'file': next(playlist_file).strip()}

                    entries.append(info)

    return entries
