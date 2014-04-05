#!/usr/bin/env python

import sys
import json

print json.dumps(json.loads(''.join(sys.stdin)), sort_keys=True,
                                                 indent=4,
                                                 separators=(',', ': '))
