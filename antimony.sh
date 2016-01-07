#!/bin/bash
############################################################
# Build antimony from latest source
#   http://svn.code.sf.net/p/antimony/code/
#
# Usage: 
# 	./antimony.sh 2>&1 | tee ./logs/antimony.log
#
# @author: Matthias Koenig
# @date: 2016-01-06
############################################################

CODE=antimony
ANTIMONY=antimony

SVN_DIR=$HOME/svn
TMP_DIR=$HOME/tmp
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

echo "---------------------------------------"
echo "install dependencies"
echo "---------------------------------------"
sudo apt-get -y install libqt4-core libqt4-dev

echo "--------------------------------------"
echo "pull repository"
echo "--------------------------------------"
if [ -d "${SVN_DIR}/$CODE" ]; then
	cd ${SVN_DIR}/$CODE
	svn update
else
	cd $SVN_DIR
	svn checkout http://svn.code.sf.net/p/antimony/code/ $CODE
	cd ${SVN_DIR}/$CODE
fi

echo "--------------------------------------"
echo "build antimony"
echo "--------------------------------------"
ANTIMONY_BUILD=$TMP_DIR/antimony_build
rm -rf $ANTIMONY_BUILD
mkdir $ANTIMONY_BUILD
echo "Build directory:" $ANTIMONY_BUILD

# cmake build
# if build with -fPIC is necessary, toggle advanced in cmake-gui and set
# CMAKE_CXX_FLAGS = -fPIC
cd $ANTIMONY_BUILD
cmake -DWITH_CELLML=OFF -DWITH_PYTHON=ON ${SVN_DIR}/$CODE/antimony

make
sudo make install

