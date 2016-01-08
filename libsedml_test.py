#!/usr/bin/python
############################################################
# Test libsedml installation/python bindings
#
# Usage: 
# 	./libsedml_test.sh
#
# @author: Matthias Koenig
# @date: 2016-01-08
############################################################
from __future__ import print_function, division
import libnuml
import libsedml

print('libnuml', libnuml.getLibNUMLDottedVersion())
print ('libsedml', libsedml.getLibSEDMLDottedVersion())

