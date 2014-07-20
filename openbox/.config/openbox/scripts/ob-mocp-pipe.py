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
import argparse
import configparser
import os.path
import sys

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + '/../lib')
import obmenu as obm
import moc


def entries(parent):
    """ Set menu entries.

    Keyword arguments:
        parent -- Parent etree.Element
    """
    info = moc.info()
    state = info['state']

    # Set header
    if state == moc.STATES['NOT RUNNING']:
        obm.create_separator(parent, 'Not running')
    elif state == moc.STATES['PLAY']:
        obm.create_separator(parent, 'Playing')
    elif state == moc.STATES['PAUSE']:
        obm.create_separator(parent, 'Paused')
    elif state == moc.STATES['STOP']:
        obm.create_separator(parent, 'Stopped')

    # Song information
    if state != moc.STATES['NOT RUNNING']:
        song_info(parent, info)

    # Controls
    if state != moc.STATES['NOT RUNNING']:
        obm.create_separator(parent, 'Commands')
        if state == moc.STATES['PLAY']:
            obm.create_action(parent,
                              'Pause',
                              '{} --toggle-pause'.format(moc.MOC_BIN))
            obm.create_action(parent,
                              'Previous',
                              '{} --prev'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Next', '{} --next'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Stop', '{} --stop'.format(moc.MOC_BIN))
        elif state == moc.STATES['PAUSE']:
            obm.create_action(parent,
                              'Play',
                              '{} --toggle-pause'.format(moc.MOC_BIN))
            obm.create_action(parent,
                              'Previous',
                              '{} --prev'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Next', '{} --next'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Stop', '{} --stop'.format(moc.MOC_BIN))
        elif state == moc.STATES['STOP']:
            obm.create_action(parent,
                              'Play',
                              '{} --play'.format(moc.MOC_BIN))

    # Server control
    if state == moc.STATES['NOT RUNNING']:
        obm.create_action(parent,
                          'Start Music On Console',
                          'termopen {}'.format(moc.MOC_BIN))
    else:
            obm.create_separator(parent)
            obm.create_action(parent,
                              'Show Music On Console',
                              'termopen {}'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Exit', '{} --exit'.format(moc.MOC_BIN))


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


def song_info(parent):
    """ Set song information entries.

    Keyword arguments:
        parent -- Parent etree.Element
    """
    info = moc.info()
    playlist = moc.playlist_get()
    total_tracks = len(playlist)
    tracknumber = '1'

    try:
        artist = info['artist']
        album = info['album']
        songtitle = info['songtitle']

        for tracknumber, track in enumerate(playlist, start=1):
            if track[1] == info['file']:
                break

        tracknumber = str(tracknumber)
    except KeyError:
        track = moc.playlist_get()[0][0]
        artist = track.partition(' - ')[0]
        album = track.rpartition(' (')[2][:-1]
        songtitle = track.partition(' - ')[2].rpartition(' (')[0]

    obm.create_action(parent, 'Artist: {}'.format(artist), None)
    obm.create_action(parent, 'Title: {}'.format(songtitle), None)
    obm.create_action(parent, 'Album: {}'.format(album), None)
    obm.create_action(parent,
                      'Track: {}/{}'.format(tracknumber, total_tracks),
                      None)


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

    root = obm.create_root()

    entries(root)

    # Print XML
    if args.debug:
        obm.prettyprint(root)
    else:
        obm.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())
