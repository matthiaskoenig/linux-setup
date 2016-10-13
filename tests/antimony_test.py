#!/usr/bin/python
############################################################
# Test antimony python bindings
############################################################
from __future__ import print_function, division
import sys
import traceback

if __name__ == "__main__":
    try:
        import antimony
        print(antimony.__version__)
        sys.exit(0)

    except Exception:
        traceback.print_exc()
        sys.exit(1)
