#!/bin/bash
############################################################
# Build zipper from latest source
# https://github.com/fbergmann/zipper.git
#
# Usage: 
# 	./zipper.sh 2>&1 | tee ./logs/zipper.log
#
############################################################
date
echo "--------------------------------------"
echo "zipper installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=zipper
REPO=https://github.com/fbergmann/zipper.git
MINIZP_REPO=https://github.com/sebastiandev/minizip.git

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "${GIT_DIR}" ]; then
	mkdir ${GIT_DIR}
fi
if ! [ -d "${TMP_DIR}" ]; then
	mkdir ${TMP_DIR}
fi

echo "--------------------------------------"
echo "pull zipper repository"
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
	# project contains submodules
	# https://git-scm.com/book/en/v2/Git-Tools-Submodules
	git submodule init
	git submodule update
fi
echo "*commit*"
git rev-parse HEAD
echo


echo "--------------------------------------"
echo "build zipper"
echo "--------------------------------------"
BUILD=$TMP_DIR/zipper_build
if [ -d "${BUILD}" ]; then
	sudo rm -rf ${BUILD}
fi
mkdir ${BUILD}

# here are the cmake files
cd ${BUILD}
cmake -DWITH_QT_FILESYSTEM=ON ${GIT_DIR}/$CODE
make -j8

echo "--------------------------------------"
echo "install zipper"
echo "--------------------------------------"
# remove old files
sudo rm -rf /usr/local/include/zipper
sudo rm  /usr/local/lib/libZipper-static.a

# installation
sudo make -j8 install
