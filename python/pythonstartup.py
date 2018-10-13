#!/usr/bin/env python

import atexit
import os
import errno
import readline


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
