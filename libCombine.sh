#!/bin/bash
############################################################
# Build libCombine from latest source
# https://github.com/sbmlteam/libCombine.git
#
# Usage: 
# 	./libCombine.sh 2>&1 | tee ./logs/libCombine.log
#
# Depens on Zipper library
############################################################
date
echo "--------------------------------------"
echo "libCombine installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=libCombine
REPO=https://github.com/sbmlteam/libCombine.git

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "${GIT_DIR}" ]; then
	mkdir ${GIT_DIR}
fi
if ! [ -d "${TMP_DIR}" ]; then
	mkdir ${TMP_DIR}
fi

echo "---------------------------------------"
echo "install libCombine dependencies"
echo "---------------------------------------"
sudo apt-get -y install cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libCombine repository"
echo "--------------------------------------"
echo "$GIT_DIR/${CODE}"
if [ -d "$GIT_DIR/${CODE}" ]; then
	cd $GIT_DIR/${CODE}
	git pull
    git checkout master
else
	cd $GIT_DIR
	git clone ${REPO} ${CODE}
	cd $GIT_DIR/${CODE}
fi
echo "*commit*"
git rev-parse HEAD
echo 

echo "--------------------------------------"
echo "build libCombine"
echo "--------------------------------------"
BUILD=$TMP_DIR/libCombine_build
if [ -d "${BUILD}" ]; then
	sudo rm -rf ${BUILD}
fi
mkdir ${BUILD}

# here are the cmake files
cd ${BUILD}

cmake -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_JAVA=ON -DWITH_PYTHON=ON -DWITH_R=ON ${GIT_DIR}/$CODE
make -j8

exit

echo "--------------------------------------"
echo "install libCombine"
echo "--------------------------------------"
# remove old files
# TODO
# sudo rm -rf /usr/local/share/libsedml
# sudo rm -rf /usr/local/include/sedml
# sudo rm -rf /usr/local/lib/libsedml*
# sudo rm /usr/local/share/java/libsedmlj.jar
# sudo rm /usr/local/lib/python2.7/site-packages/libsedml/_libsedml.so
# sudo rm /usr/local/lib/python2.7/site-packages/libsedml.pth
# sudo rm /usr/local/lib/python2.7/site-packages/libsedml/libsedml.py
# sudo rm /etc/profile.d/libnuml.sh
# sudo rm /etc/profile.d/libsedml.sh

# installation
sudo make install

echo "--------------------------------------"
echo "python bindings"
echo "--------------------------------------"
