#!/bin/bash
############################################################
# Install the full simulation stack
#
# @author: Matthias Koenig
# @date: 2016-02-16
############################################################
./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
./libsbml.sh 2>&1 | tee ./logs/libsbml.log
./libcellml.sh 2>&1 | tee ./logs/libcellml.log
./libsedml.sh 2>&1 | tee ./logs/libsedml.log
./roadrunner.sh 2>&1 | tee ./logs/roadrunner.log
./antimony.sh 2>&1 | tee ./logs/antimony.log
./phrasedml.sh 2>&1 | tee ./logs/phrasedml.log
./sbml2matlab.sh 2>&1 | tee ./logs/sbml2matlab.log
./tellurium.sh 2>&1 | tee ./logs/tellurium.log
./spyder.sh 2>&1 | tee ./logs/spyder.log
