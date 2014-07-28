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
import os.path
import sys

curdir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, curdir + '/../lib')
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
    if state == 'NOT RUNNING':
        obm.create_separator(parent, 'Not running')
        obm.create_action(parent,
                          'Start Music On Console',
                          'termopen {}'.format(moc.MOC_BIN))
    else:
        if state == 'PLAY':
            obm.create_separator(parent, 'Playing')
        elif state == 'PAUSE':
            obm.create_separator(parent, 'Paused')
        elif state == 'STOP':
            obm.create_separator(parent, 'Stopped')

        # Song information
        song_info(parent)

        # Playlist control
        obm.create_separator(parent, 'Playlist')
        obm.create_action(parent, 'Clear', '{} --clear'.format(moc.MOC_BIN))
        obm.create_pipe_menu(parent,
                             'mocp-playlist-pipe',
                             'Edit',
                             'ob-mocp-playlist-pipe.py --start --directory ~/Music')

        # Controls
        obm.create_separator(parent, 'Commands')
        if state == 'PLAY':
            obm.create_action(parent,
                              'Pause',
                              '{} --toggle-pause'.format(moc.MOC_BIN))
            obm.create_action(parent,
                              'Previous',
                              '{} --prev'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Next', '{} --next'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Stop', '{} --stop'.format(moc.MOC_BIN))
        elif state == 'PAUSE':
            obm.create_action(parent,
                              'Play',
                              '{} --toggle-pause'.format(moc.MOC_BIN))
            obm.create_action(parent,
                              'Previous',
                              '{} --prev'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Next', '{} --next'.format(moc.MOC_BIN))
            obm.create_action(parent, 'Stop', '{} --stop'.format(moc.MOC_BIN))
        elif state == 'STOP':
            obm.create_action(parent,
                              'Play',
                              '{} --play'.format(moc.MOC_BIN))

        # Server control
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
    track = moc.info()
    state = track['state']
    playlist = moc.playlist_get()
    totaltracks = str(len(playlist))

    if state == 'PLAY' or state == 'PAUSE':
        index = 0

        for index, entry in enumerate(playlist, start=1):
            if entry['file'] == track['file']:
                break

        track['tracknumber'] = str(index).zfill(len(totaltracks))
        length = '{}/{}'.format(track['currenttime'], track['totaltime'])
    elif state == 'STOP' and playlist:
        track = playlist[0]
        track['tracknumber'] = "1".zfill(len(totaltracks))
        length = '{}'.format(track['totaltime'])
    elif state == 'STOP' and not playlist:
        obm.create_item(parent, 'Empty playlist')
        return
    else:
        return

    obm.create_item(parent, 'Artist: {}'.format(track['artist']))
    obm.create_item(parent, 'Title: {}'.format(track['songtitle']))
    obm.create_item(parent, 'Album: {}'.format(track['album']))
    obm.create_item(parent, 'Length: {}'.format(length))
    obm.create_item(parent,
                    'Track: {}/{}'.format(track['tracknumber'],
                                          totaltracks))


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

    try:
        entries(root)
    except moc.MocNotFound:
        obm.create_separator(root, 'MOC not installed')

    # Print XML
    if args.debug:
        obm.prettyprint(root)
    else:
        obm.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())
