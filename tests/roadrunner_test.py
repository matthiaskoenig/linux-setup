#!/usr/bin/python
############################################################
# Test the roadrunner installation/python bindings
#
# Usage: 
# 	./roadrunner_test.sh 2>&1 | tee ./logs/roadrunner_test.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
#
# @author: Matthias Koenig
# @date: 2016-01-06
############################################################
import roadrunner
print roadrunner.getVersionStr()

import roadrunner.testing
roadrunner.testing.runTester()

