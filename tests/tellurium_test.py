#!/usr/bin/python
############################################################
# Test tellurium python bindings
############################################################
from __future__ import print_function, division
import sys
import traceback

if __name__ == "__main__":
    try:
        import tellurium as te
        print('tellurium', te.getVersionInfo())
        sys.exit(0)

    except:
        traceback.print_exc()
        sys.exit(1)
