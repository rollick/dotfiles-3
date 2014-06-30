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
import xml.etree.ElementTree as etree
import xml.dom.minidom as minidom


def create_action(parent, label, cmd):
    """ Create an action element.

    Keyword argguments:
        parent -- Parent etree.Element
        label -- Label
        cmd -- Command to be executed

    """
    item = etree.SubElement(parent, 'item', {'label': label})
    action = etree.SubElement(item, 'action', {'name': 'Execute'})
    command = etree.SubElement(action, 'command')
    command.text = cmd


def create_separator(parent, label=None):
    """ Create an separator element.

    Keyword argguments:
        parent -- Parent etree.Element
        label -- Label

    """
    if label is not None:
        attribs = {'label': label}
    else:
        attribs = {}
    etree.SubElement(parent, 'separator', attribs)


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
              '<https://github.com/rscholer/ob-pipe-menus/issues/>\n'
              '%(prog)s home page: '
              '<https://github.com/rscholer/ob-pipe-menus/>')
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


def prettyprint_xml(parent):
    """ Output etree in a nicely formated way.

    Keyword argguments:
        element -- etree.Element to process

    """
    xml_str = etree.tostring(parent, encoding='utf-8', method='xml')
    xml = minidom.parseString(xml_str)
    print(xml.toprettyxml())


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

    firefox_profile = os.path.expanduser('~/.mozilla/firefox/profiles.ini')
    config = configparser.ConfigParser()
    config.read(firefox_profile)

    root = etree.Element('openbox_pipe_menu')

    for e in config.sections():
        if e.startswith('Profile'):
            profile = config[e]['name']
            create_action(root,
                          profile,
                          'firefox -no-remote -P {}'.format(profile))

    create_separator(root)
    create_action(root,
                  'Profile Manager',
                  'firefox -no-remote -ProfileManager')

    # Print XML
    if args.debug:
        prettyprint_xml(root)
    else:
        etree.dump(root)

    return 0


if __name__ == '__main__':
    sys.exit(main())
