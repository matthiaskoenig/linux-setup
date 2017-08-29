#!/usr/bin/python
############################################################
# Test libnuml python bindings
############################################################
from __future__ import print_function
import sys
import traceback

if __name__ == "__main__":
    try:
        import libnuml
        print('libnuml', libnuml.getLibNUMLDottedVersion())

        sys.exit(0)
    except Exception:
        traceback.print_exc()
        sys.exit(1)
