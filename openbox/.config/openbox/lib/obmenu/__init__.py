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
""" Helper function for creating openbox pipe menus.

Functions:
    create_action -- Create an action element.
    create_item -- Create an item element.
    create_menu -- Create a menu.
    create_pipe_menu -- Create a pipe menu.
    create_root -- Create root element.
    create_separator -- Create an separator element.
    dump -- Alias for xml.etree.ElementTree.dump().
    prettyprint -- Output etree in a nicely formatted way.
"""
import xml.etree.ElementTree as etree
import xml.dom.minidom as minidom


def create_action(parent, label, cmd):
    """ Create an action element.

    Keyword argguments:
        parent -- Parent etree.Element
        label -- Label
        cmd -- Command to be executed (default: None)
    """
    item = create_item(parent, label)
    action = etree.SubElement(item, 'action', {'name': 'Execute'})
    command = etree.SubElement(action, 'command')
    command.text = cmd


def create_item(parent, label):
    """ Create an item element.
    Keyword argguments:
        parent -- Parent etree.Element
        label -- Label

    Return value:
        etree.ElementTree
    """
    return etree.SubElement(parent, 'item', {'label': label})


def create_menu(parent, id, label):
    """ Create a menu.

    Keyword arguments:
        parent -- Parent etree.Element
        id -- ID
        label -- Label
    """
    attribs = {'label': label,
               'id': id.lower()}
    return etree.SubElement(parent, 'menu', attribs)


def create_pipe_menu(parent, id, label, script):
    """ Create a pipe menu.

    Keyword arguments:
        parent -- Parent etree.Element
        id -- ID
        label -- Label
        script -- Script to execute
    """
    attribs = {'label': label,
               'id': 'pipe-{}-{}-menu'.format(id.lower(), label.lower()),
               'execute': script}
    etree.SubElement(parent, 'menu', attribs)


def create_root():
    """ Create root element.

    Return value:
        xml.etree.ElementTree.Element
    """
    return etree.Element('openbox_pipe_menu')


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


def prettyprint(parent):
    """ Output etree in a nicely formatted way.

    Keyword arguments:
        element -- etree.Element to process
    """
    xml_str = etree.tostring(parent, encoding='utf-8', method='xml')
    xml = minidom.parseString(xml_str)
    print(xml.toprettyxml())


# Aliases
dump = etree.dump


if __name__ == "__main__":
    print(__doc__)
