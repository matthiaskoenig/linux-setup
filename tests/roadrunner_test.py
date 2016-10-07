#!/usr/bin/python
############################################################
# Test the roadrunner python bindings
############################################################
from __future__ import print_function, division
import sys
import traceback

if __name__ == "__main__":
    try:
        import roadrunner
        print(roadrunner.getVersionStr())
        import roadrunner.testing
        roadrunner.testing.runTester()
        sys.exit(0)

    except:
        traceback.print_exc()
        sys.exit(1)
