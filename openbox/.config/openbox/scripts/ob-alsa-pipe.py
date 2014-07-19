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
import os.path
import sys

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + '/../lib')
import obmenu as obm

import alsaaudio as alsa  # http://pyalsaaudio.sourceforge.net/


def calc_volume(cur_vol=None):
    """ Calculate current volume. (Round up or down to 5).

    Keyword arguments:
        cur_vol -- Current volume (Default: None)

    Return values:
        int

    """
    mod = cur_vol % 5
    cur_vol = cur_vol - mod

    if 3 <= mod <= 4:
        cur_vol = cur_vol + 5

    return cur_vol


def create_mixer_menu(parent, control):
    """ Create a menu for controlling the volume.

    Keyword argguments:
        parent -- Parent etree.Element
        control -- Control wich will be affected

    """
    mixer = alsa.Mixer(control)
    cur_vol = calc_volume(mixer.getvolume()[0])

    if mixer.getmute()[0] == 1:
        obm.create_action(parent,
                          'Unmute',
                          'amixer sset {} unmute'.format(control))
    else:
        obm.create_action(parent,
                          'Mute',
                          'amixer sset {} mute'.format(control))

    obm.create_separator(parent)

    for vol in range(0, 101, 5):
        if vol == cur_vol:
            obm.create_separator(parent, '{}%'.format(vol))
        else:
            obm.create_action(parent,
                              '{}%'.format(vol),
                              'amixer sset {} {}%'.format(control, vol))


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
    desc = 'Generate an openbox pipe menu for volume control.'
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
    parser.add_argument('--card',
                        default=None)
    parser.add_argument('--help',
                        action='help',
                        help='display this help and exit')
    parser.add_argument('--version',
                        action='version',
                        help='output version information and exit',
                        version=version)

    return parser.parse_args(argv[1:])


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

    supported_mixers = ['Headphone', 'Speaker', 'Master']
    available_mixers = alsa.mixers()
    mixers = [x for x in supported_mixers if x in available_mixers]

    root = obm.create_root()

    if not args.card:
        obm.create_action(root, 'Open audio mixer', 'termopen alsamixer')
        obm.create_separator(root, 'Mixer')

        for mixer in mixers:
            obm.create_pipe_menu(root,
                                 'alsa',
                                 mixer,
                                 '{} --card {}'.format(sys.argv[0], mixer))
    else:
        if args.card in mixers:
            create_mixer_menu(root, args.card)

    # Print XML
    if args.debug:
        obm.prettyprint(root)
    else:
        obm.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())
