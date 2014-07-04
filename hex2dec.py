#!/usr/bin/env python

import sys

def process():
    s = sys.stdin.readline().strip()
    while s != '':
        try:
            d = int(s, 16)
            print "%d\t%d" % (d % 4, d)
        except:
            print "Error on input `%s'" % (s)
        s = sys.stdin.readline().strip()

if __name__ == '__main__':
    process()
