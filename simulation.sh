#!/bin/bash
############################################################
# Install COMBINE simulation stack
# for kinetic modeling.
# This builds all the libraries from the c++ source
# and installs the respective python SWIG interfaces.
############################################################
./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
./libsbml.sh 2>&1 | tee ./logs/libsbml.log
# ./libcellml.sh 2>&1 | tee ./logs/libcellml.log
./libsedml.sh 2>&1 | tee ./logs/libsedml.log
./roadrunner-deps.sh 2>&1 | tee ./logs/roadrunner-deps.log
./roadrunner.sh 2>&1 | tee ./logs/roadrunner.log
./antimony.sh 2>&1 | tee ./logs/antimony.log
./phrasedml.sh 2>&1 | tee ./logs/phrasedml.log

./zipper.sh 2>&1 | tee ./logs/zipper.log
./libCombine.sh 2>&1 | tee ./logs/libCombine.log

./sbml2matlab.sh 2>&1 | tee ./logs/sbml2matlab.log
./tellurium.sh 2>&1 | tee ./logs/tellurium.log
./spyder.sh 2>&1 | tee ./logs/spyder.log
