#!/usr/bin/python
############################################################
# Test libsbml python bindings
############################################################
from __future__ import print_function, division
import sys
import traceback

if __name__ == "__main__":
    try:
        import co
        print('libcombine', libC)
        sys.exit(0)

    except:
        traceback.print_exc()
        sys.exit(1)
