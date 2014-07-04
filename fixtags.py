#!/usr/bin/env python

import sys
import tempfile

if __name__ == '__main__':
    t = tempfile.TemporaryFile()
    with open(sys.argv[1], 'r') as fh:
        for line in fh:
            if line.find('\t') != -1:
                t.write(line)
    with open(sys.argv[1], 'w') as fh:
        t.seek(0)
        fh.write(t.read())
