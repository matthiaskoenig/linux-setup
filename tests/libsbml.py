#!/usr/bin/python
############################################################
# Test libsbml python bindings
############################################################
from __future__ import print_function, division
import sys


def test():
    """
    Test libsbml import and call of function.
    :return:
    """
    import libsbml
    print('libsbml', libsbml.getLibSBMLDottedVersion())

if __name__ == "__main__":
    try:
        test()
    except:
        sys.exit(1)
