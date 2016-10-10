#!/usr/bin/python
############################################################
# Test libsedml python bindings
############################################################
from __future__ import print_function, division
import sys
import traceback

if __name__ == "__main__":
    try:
        import libnuml
        import libsedml
        print('libnuml', libnuml.getLibNUMLDottedVersion())
        print('libsedml', libsedml.getLibSEDMLDottedVersion())

        sys.exit(0)
    except Exception:
        traceback.print_exc()
        sys.exit(1)
