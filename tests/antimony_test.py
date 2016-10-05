#!/usr/bin/python
############################################################
# Test antimony installation/python bindings
#
# Usage: 
# 	./antimony_test.sh 2>&1 | tee ./logs/antimony_test.log
#
# @author: Matthias Koenig
# @date: 2016-01-07
############################################################
from __future__ import print_function, division
import antimony

print(antimony.__version__)

