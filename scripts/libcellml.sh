#!/bin/bash
############################################################
# Make cellml libraries available
#   http://cellml-api.sourceforge.net/download.html
#
# Usage: 
# 	./libcellml.sh 2>&1 | tee ./logs/libcellml.log
############################################################

VERSION=cellml-sdk-1.12-Linux-x86_64

TMP_DIR=$HOME/tmp
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi


CELLML_DIR=${TMP_DIR}/${VERSION}
if ! [ -d "$CELLML_DIR" ]; then
	mkdir $CELLML_DIR
fi

cd TMP_DIR


wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.12/20121031/linux-x86_64/${VERSION}.tar.bz2/download ${VERSION}


