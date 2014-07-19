#!/bin/env python3
"""
Copyright (C) 2014 by Raphael Scholer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

"""
import argparse
import configparser
import os.path
import sys

import obmenu as obm
import moc


def parse_arguments(argv=None):
    """ Parse arguments.

    Keyword arguments:
        argv -- list containing commandline arguments.
                If None use current sys.argv. (default: None)

    Return values:
        argparse.Namespace

    """
    argv = argv or sys.argv

    # Set up parsing of argv
    desc = 'Generate an openbox pipe menu for controling MOC'
    epilog = ('Report bugs to '
              '<https://github.com/rscholer/dotfiles/issues/>\n'
              '%(prog)s home page: '
              '<https://github.com/rscholer/dotfiles/>')
    usage = '%(prog)s [OPTIONS]...'
    version = ('%(prog)s 1.0\n'
               'Copyright (C) 2014 by Raphael Scholer\n\n'
               'Permission is hereby granted, free of charge, '
               'to any person obtaining a copy\n'
               'of this software and associated documentation files '
               '(the "Software"), to deal\n'
               'in the Software without restriction, '
               'including without limitation the rights\n'
               'to use, copy, modify, merge, publish, distribute, '
               'sublicense, and/or sell\n'
               'copies of the Software, and to permit persons '
               'to whom the Software is\n'
               'furnished to do so, subject to the following conditions:\n\n'
               'The above copyright notice and this permission notice '
               'shall be included in\n'
               'all copies or substantial portions of the Software.\n\n'
               'THE SOFTWARE IS PROVIDED "AS IS", '
               'WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n'
               'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES '
               'OF MERCHANTABILITY,\n'
               'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. '
               'IN NO EVENT SHALL THE\n'
               'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, '
               'DAMAGES OR OTHER\n'
               'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, '
               'TORT OR OTHERWISE, ARISING FROM,\n'
               'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE '
               'OR OTHER DEALINGS IN\n'
               'THE SOFTWARE.')

    formatter = argparse.RawTextHelpFormatter

    parser = argparse.ArgumentParser(add_help=False,
                                     description=desc,
                                     epilog=epilog,
                                     formatter_class=formatter,
                                     usage=usage)

    parser.add_argument('--debug',
                        action='store_true',
                        default=False,
                        help='debug output')
    parser.add_argument('--help',
                        action='help',
                        help='display this help and exit')
    parser.add_argument('--version',
                        action='version',
                        help='output version information and exit',
                        version=version)

    return parser.parse_args(argv[1:])

def commands(parent, state):
    if state != moc.STATES['NOT RUNNING']:
        obm.create_separator(parent, 'Commands')
        if state == moc.STATES['PLAY']:
            obm.create_action(parent, 'Pause', 'mocp --toggle-pause')
        else:
            obm.create_action(parent, 'Play', 'mocp --toggle-pause')

        if not state == moc.STATES['STOP']:
            obm.create_action(parent, 'Previous', 'mocp --prev')
            obm.create_action(parent, 'Next', 'mocp --next')
            obm.create_action(parent, 'Stop', 'mocp --stop')

        obm.create_separator(parent)

    if state != moc.STATES['NOT RUNNING']:
        obm.create_action(parent, "Show Music On Console", "termopen mocp")
        obm.create_action(parent, "Exit", "mocp --exit")
    else:
        obm.create_action(parent, "Start Music On Console", "termopen mocp")



def song_info():
    track = moc.playlist_get()[0][0]
    artist = track.partition(' - ')[0]
    album = track.rpartition(' (')[2][:-1]
    songtitle = track.partition(' - ')[2].rpartition(' (')[0]
    return {'artist': artist, 'album': album, 'songtitle': songtitle}

def header(parent, info):
    state = info['state']


    if state == moc.STATES['NOT RUNNING']:
        obm.create_separator(parent, 'Not running')
        return
    elif state == moc.STATES['PLAY']:
        obm.create_separator(parent, 'Playing')
    elif state == moc.STATES['PAUSE']:
        obm.create_separator(parent, 'Paused')
    elif state == moc.STATES['STOP']:
        obm.create_separator(parent, 'Stopped')

    try:
        artist = info['artist']
        album = info['album']
        songtitle = info['songtitle']
    except KeyError:
        artist = song_info()['artist']
        album = song_info()['album']
        songtitle = song_info()['songtitle']
    finally:
        obm.create_action(parent, 'Artist: {}'.format(artist), None)
        obm.create_action(parent, 'Title: {}'.format(songtitle), None)
        obm.create_action(parent, 'Album: {}'.format(album), None)

def main(argv=None):
    """ Main function

    Keyword arguments:
        argv -- list containing commandline arguments.
                If None use current sys.argv. (default: None)

    Return value (int):
        int -- On Failure >= 1
               On Success == 0 (default)

    """
    # Parse argv
    args = parse_arguments(argv)

    info = moc.info()
    state = info['state']
    root = obm.create_root()


    header(root, info)
    commands(root, state)

    # Print XML
    if args.debug:
        obm.prettyprint(root)
    else:
        obm.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())
