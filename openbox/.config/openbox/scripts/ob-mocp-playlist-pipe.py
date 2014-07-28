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
import os
import sys

curdir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, curdir + '/../lib')
import moc
import obmenu as obm


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
    desc = ('Generate an openbox pipe menu for editing MOC\' playlist'
            ' profiles.')
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

    parser.add_argument('--directory',
                        nargs=1,
                        help='directory to inspect')
    parser.add_argument('--debug',
                        action='store_true',
                        default=False,
                        help='debug output')
    parser.add_argument('--start',
                        action='store_true',
                        default=False,
                        help='Categorize content based on first letter')
    parser.add_argument('--help',
                        action='help',
                        help='display this help and exit')
    parser.add_argument('--version',
                        action='version',
                        help='output version information and exit',
                        version=version)

    return parser.parse_args(argv[1:])


def main(argv=None):
    # Parse argv
    args = parse_arguments(argv)

    root = obm.create_root()

    if args.directory:
        directory = os.path.expanduser(args.directory[0])
        dircnt = os.listdir(directory)
        dircnt.sort()
        dircnt = [(d, os.path.join(directory, d)) for d in dircnt]
        dircnt = [d for d in dircnt if os.path.isdir(d[1])]

        if not args.start:
            obm.create_action(root,
                              'Append',
                              '{} --append "{}"'.format(moc.MOC_BIN, directory))
            obm.create_action(root,
                              'Replace',
                              '{} {} "{}" --play'.format(moc.MOC_BIN,
                                                         '--clear --append',
                                                         directory))
            if dircnt:
                obm.create_separator(root)

        last_cat = ""
        parent = root
        for d in dircnt:
            if args.start and not last_cat == d[0][0].lower():
                last_cat = d[0][0].lower()

                # Set category name
                if d[0][0] in ('0','1','2','3','4','5','6','7','8','9'):
                    cat = "0-9"
                else:
                    cat = d[0][0].upper()

                parent = obm.create_menu(root,
                                         'moc-playlist-{}-pipe'.format(cat),
                                         cat)

            obm.create_pipe_menu(parent,
                                 'moc-playlist-{}-pipe'.format(d[1]),
                                 d[0],
                                 '{} --directory "{}"'.format(sys.argv[0],
                                                              d[1]))

    # Print XML
    if args.debug:
        obm.prettyprint(root)
    else:
        obm.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())