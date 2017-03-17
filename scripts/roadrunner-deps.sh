#!/bin/bash
############################################################
# Build roadrunner dependencies
# github https://github.com/sys-bio/roadrunner
#
# Usage: 
# 	./roadrunner-deps.sh 2>&1 | tee ./logs/roadrunner-deps.log
#
# @author: Matthias Koenig
# @date: 2016-09-08
############################################################
date
echo "--------------------------------------"
echo "roadrunner-deps installation"
echo "--------------------------------------"
echo "Make directories for roadrunner installation"
ROADRUNNER_DEPS=roadrunner-deps

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
GIT_DIR=$HOME/git 
TMP_DIR=$HOME/tmp

# install dependencies
echo "install system dependencies"
sudo apt-get install git libxml2-dev
sudo -E pip install numpy --upgrade
sudo -E pip install scipy --upgrade


echo "install LLVM 3.5.2"
LLVM=llvm
LLVM_VERSION=3.5.2
LLVM_SRC=${TMP_DIR}/${LLVM}-${LLVM_VERSION}.src
LLVM_BUILD=${TMP_DIR}/${LLVM}-${LLVM_VERSION}_build
LLVM_INSTALL=${TMP_DIR}/${LLVM}-${LLVM_VERSION}_install

rm -rf ${LLVM_SRC}
# rm -rf ${LLVM_BUILD}
mkdir ${LLVM_BUILD}
rm -rf ${LLVM_INSTALL}
mkdir ${LLVM_INSTALL}

cd ${TMP_DIR}
wget -nc http://llvm.org/releases/${LLVM_VERSION}/${LLVM}-${LLVM_VERSION}.src.tar.xz
tar xf ${LLVM}-${LLVM_VERSION}.src.tar.xz
rm ${LLVM}-${LLVM_VERSION}.src.tar.xz

cd ${LLVM_BUILD}
pwd
cmake -DCMAKE_INSTALL_PREFIX=${LLVM_INSTALL} ${LLVM_SRC} && make install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


# libroadrunner dependencies
# https://github.com/sys-bio/libroadrunner-deps.git
echo "--------------------------------------"
echo "pull libroadrunner-deps repository"
echo "--------------------------------------"
if [ -d "${GIT_DIR}/$ROADRUNNER_DEPS" ]; then
	cd ${GIT_DIR}/$ROADRUNNER_DEPS
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/libroadrunner-deps.git $ROADRUNNER_DEPS
    cd ${GIT_DIR}/$ROADRUNNER_DEPS
fi
# git checkout d6844db999a6064ec
git checkout master
echo "*commit*"
git rev-parse HEAD

echo "--------------------------------------"
echo "build roadrunner third party deps"
echo "--------------------------------------"
ROADRUNNER_BUILD_THIRDPARTY=$TMP_DIR/roadrunner_build_thirdparty
ROADRUNNER_INSTALL=${TMP_DIR}/roadrunner_install

# rm -rf $ROADRUNNER_BUILD_THIRDPARTY
mkdir $ROADRUNNER_BUILD_THIRDPARTY
rm -rf $ROADRUNNER_INSTALL
mkdir $ROADRUNNER_INSTALL

cd $ROADRUNNER_BUILD_THIRDPARTY
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL ${GIT_DIR}/$ROADRUNNER_DEPS && make -j8 install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

