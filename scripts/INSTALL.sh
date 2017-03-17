#!/bin/bash
############################################################
# Install COMBINE simulation stack for kinetic modeling.
#
# This builds all the libraries from the c++ source
# and installs the respective python SWIG interfaces.
#
# Usage:
#   ./INSTALL.sh | tee ./logs/INSTALL.log
#
# Logs are written in the logs directory
############################################################
TSTART=`date +%s`

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

# directory for log files
LOGS_DIR=${DIR}/logs
if ! [ -d "${LOGS_DIR}" ]; then
	mkdir ${LOGS_DIR}
fi

./libsbml.sh 2>&1 | tee ${LOGS_DIR}/libsbml.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./libsedml.sh 2>&1 | tee ${LOGS_DIR}/libsedml.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# no cellml support
# ./cellml-api.sh 2>&1 | tee ${LOGS_DIR}/cellml-api.log
# rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./roadrunner-deps.sh 2>&1 | tee ${LOGS_DIR}/roadrunner-deps.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./roadrunner.sh 2>&1 | tee ${LOGS_DIR}/roadrunner.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./antimony.sh 2>&1 | tee ${LOGS_DIR}/antimony.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./phrasedml.sh 2>&1 | tee ${LOGS_DIR}/phrasedml.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./zipper.sh 2>&1 | tee ${LOGS_DIR}/zipper.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./libcombine.sh 2>&1 | tee ${LOGS_DIR}/libcombine.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./sbml2matlab.sh 2>&1 | tee ${LOGS_DIR}/sbml2matlab.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

./spyder.sh 2>&1 | tee ${LOGS_DIR}/spyder.log
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# python installs
# ./tellurium.sh 2>&1 | tee ${LOGS_DIR}/tellurium.log

TEND=`date +%s`
RUNTIME=$((TEND-TSTART))
echo "TOTAL RUNTIME: $RUNTIME [s]"