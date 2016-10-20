#!/usr/bin/env bash
######################################################
#
# Build cellml API from repository.
#
# Usage:
# 	./cellml-api.sh 2>&1 | tee ./logs/cellml-api.log
######################################################
date
echo "--------------------------------------"
echo "cellml-api requirements"
echo "--------------------------------------"
sudo apt-get install -y doxygen omniidl bison flex

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=cellml-api
REPO=https://github.com/cellmlapi/cellml-api.git

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "${GIT_DIR}" ]; then
	mkdir ${GIT_DIR}
fi
if ! [ -d "${TMP_DIR}" ]; then
	mkdir ${TMP_DIR}
fi

echo "--------------------------------------"
echo "pull cellml-api repository"
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
echo "build cellml-api"
echo "--------------------------------------"
BUILD=$TMP_DIR/cellml-api_build
if [ -d "${BUILD}" ]; then
	sudo rm -rf ${BUILD}
fi
mkdir ${BUILD}

# here are the cmake files
cd ${BUILD}

# cmake
# use CMAKE_INSTALL_PREFIX=$INSTALL_DIR to install in other directory
cmake -DBUILD_TESTING=OFF -DENABLE_ANNOTOOLS=ON -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON \
-DENABLE_CEVAS=ON -DENABLE_CUSES=ON -DENABLE_MALAES=ON -DENABLE_TELICEMS=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON \
-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++0x $HOME/git/cellml-api

make CXX_HEADERS_FOR_INTERFACES
make -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "--------------------------------------"
echo "install libCombine"
echo "--------------------------------------"
# remove old files

sudo make install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi