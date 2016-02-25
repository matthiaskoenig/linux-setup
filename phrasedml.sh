#!/bin/bash
############################################################
# Build antimony from latest source
#   svn checkout http://svn.code.sf.net/p/phrasedml/code/trunk phrasedml-code
#
# Usage: 
# 	./phrasedml.sh 2>&1 | tee ./logs/phrasedml.log
#
# @author: Matthias Koenig
# @date: 2016-01-23
############################################################
date
echo "--------------------------------------"
echo "phrasedml installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=phrasedml
PHRASEDML=phrasedml

SVN_DIR=$HOME/svn
TMP_DIR=$HOME/tmp
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

echo "--------------------------------------"
echo "pull repository"
echo "--------------------------------------"
if [ -d "${SVN_DIR}/$CODE" ]; then
	cd ${SVN_DIR}/$CODE
	svn update
else
	cd $SVN_DIR
	svn checkout http://svn.code.sf.net/p/phrasedml/code/trunk $CODE
	cd ${SVN_DIR}/$CODE
fi

echo "--------------------------------------"
echo "build phrasedml"
echo "--------------------------------------"
BUILD_DIR=$TMP_DIR/${PHRASEDML}_build
echo "Build directory:" $BUILD_DIR
if [ -d "$BUILD_DIR" ]; then
	sudo rm -rf $BUILD_DIR
fi
mkdir $BUILD_DIR

# cmake build
# if build with -fPIC is necessary, toggle advanced in cmake-gui and set
# CMAKE_CXX_FLAGS = -fPIC
cd $BUILD_DIR

cmake -DWITH_PYTHON=ON -DCELLML_API_INSTALL_DIR="$HOME/tmp/cellml-sdk-1.13-Linux-x86_64" -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_EXAMPLES=ON ${SVN_DIR}/$CODE
#cmake -DWITH_PYTHON=ON -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_EXAMPLES=ON ${SVN_DIR}/# $CODE

make

echo "--------------------------------------"
echo "install phrasedml"
echo "--------------------------------------"
sudo make install

echo "--------------------------------------"
echo "test installation"
echo "--------------------------------------"
cd $DIR

pip list | grep phrasedml

