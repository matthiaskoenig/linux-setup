#!/bin/bash
############################################################
# Install COMBINE simulation stack for kinetic modeling.
#
# This builds all the libraries from the c++ source
# and installs the respective python SWIG interfaces.
############################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

# directory for log files
LOGS_DIR=${DIR}/logs
if ! [ -d "${LOGS_DIR}" ]; then
	mkdir ${LOGS_DIR}
fi

./libsbml.sh 2>&1 | tee ${LOGS_DIR}/libsbml.log
# ./libcellml.sh 2>&1 | tee ${LOGS_DIR}/libcellml.log
./libsedml.sh 2>&1 | tee ${LOGS_DIR}/libsedml.log

./roadrunner-deps.sh 2>&1 | tee ${LOGS_DIR}/roadrunner-deps.log
./roadrunner.sh 2>&1 | tee ${LOGS_DIR}/roadrunner.log
./antimony.sh 2>&1 | tee ${LOGS_DIR}/antimony.log
./phrasedml.sh 2>&1 | tee ${LOGS_DIR}/phrasedml.log

./zipper.sh 2>&1 | tee ${LOGS_DIR}/zipper.log
./libCombine.sh 2>&1 | tee ${LOGS_DIR}/libCombine.log

./sbml2matlab.sh 2>&1 | tee ${LOGS_DIR}/sbml2matlab.log
./tellurium.sh 2>&1 | tee ${LOGS_DIR}/tellurium.log
./spyder.sh 2>&1 | tee ${LOGS_DIR}/spyder.log
