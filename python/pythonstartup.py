#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function

import atexit
import os
import errno
import readline
import sys
#import rlcompleter

from pprint import pprint

import prettyprinter
prettyprinter.install_extras(["python"])
prettyprinter.set_default_style("dark")
from prettyprinter import cpprint


#from tempfile import mkstemp
#from code import InteractiveConsole
#import datetime
#import pdb
from pygments import highlight
from pygments.lexers import PythonLexer
from pygments.formatters import Terminal256Formatter

#if sys.version_info.major == 3:

sys.ps1 = "\001\033[0;38;5;32;48;5;237m\002  \001\033[49;38;5;237m\002\001\033[0m\002 "
sys.ps2 = "\001\033[0;38;5;32;48;5;237m\002 … \001\033[49;38;5;237m\002\001\033[0m\002 "

def my_displayhook(value):
    #if value is not None:
    try:
        import __builtin__
        __builtin__._ = value
    except ImportError:
        __builtins__._ = value
    sys.stdout.write('=> ')
    cpprint( value )
sys.displayhook = my_displayhook

data_dir = os.path.join(os.path.expanduser("~"), ".local/share/python")
try:
    os.makedirs(data_dir)
except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(data_dir):
        pass
    else:
        raise

histfile = os.path.join(data_dir, "history")
try:
    readline.read_history_file(histfile)
    # default history len is -1 (infinite), which may grow unruly
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

readline.parse_and_bind("tab: complete")


atexit.register(readline.write_history_file, histfile)
