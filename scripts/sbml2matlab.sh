#!/bin/bash
############################################################
# Build sbml2matlab from latest source
#   https://github.com/sys-bio/sbml2matlab.git
#
# Usage: 
# 	./sbml2matlab.sh 2>&1 | tee ./logs/sbml2matlab.log
############################################################
date
echo "--------------------------------------"
echo "sbml2matlab installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=sbml2matlab
SBML2MATLAB=sbml2matlab

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "$GIT_DIR" ]; then
	mkdir $GIT_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi


echo "--------------------------------------"
echo "pull repository"
echo "--------------------------------------"
if [ -d "${GIT_DIR}/$CODE" ]; then
	cd ${GIT_DIR}/$CODE
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/sbml2matlab.git $CODE
	cd ${GIT_DIR}/$CODE
fi

echo "--------------------------------------"
echo "build sbml2matlab"
echo "--------------------------------------"
SBML2MATLAB_BUILD=$TMP_DIR/sbml2matlab_build
echo "Build directory:" $SBML2MATLAB_BUILD
if [ -d "$SBML2MATLAB_BUILD" ]; then
	sudo rm -rf $SBML2MATLAB_BUILD
fi
mkdir $SBML2MATLAB_BUILD

SBML2MATLAB_INSTALL=$TMP_DIR/sbml2matlab_install
echo "Install directory:" $SBML2MATLAB_INSTALL
if [ -d "$SBML2MATLAB_INSTALL" ]; then
	sudo rm -rf $SBML2MATLAB_INSTALL
fi
mkdir $SBML2MATLAB_INSTALL


cd $SBML2MATLAB_BUILD
cmake -DLIBSBML_STATIC_LIBRARY="/usr/local/lib/libsbml-static.a" -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE="/usr/bin/python" -DPYTHON_INCLUDE_DIR="/usr/include/python2.7" -DPYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/libpython2.7.so" -DCMAKE_INSTALL_PREFIX=$SBML2MATLAB_INSTALL ${GIT_DIR}/$CODE
make

echo "--------------------------------------"
echo "install sbml2matlab"
echo "--------------------------------------"
# remove old files
sudo rm -rf /usr/local/lib/python2.7/site-packages/sbml2matlab
sudo rm /usr/local/bin/sbml2matlab
sudo make install

cd $SBML2MATLAB_INSTALL/lib/python2.7/site-packages
sudo python setup.py install
