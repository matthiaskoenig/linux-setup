#!/usr/bin/python
############################################################
# Test libsbml installation/python bindings
#
# Usage: 
# 	./libsbml_test.sh 2>&1 | tee ./logs/libsbml_test.log
#
# @author: Matthias Koenig
# @date: 2016-01-08
############################################################
from __future__ import print_function, division
import libsbml

print('libsbml', libsbml.getLibSBMLDottedVersion())

