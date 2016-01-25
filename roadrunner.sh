#!/bin/bash
############################################################
# Build roadrunner directly from the release files on
# github https://github.com/sys-bio/roadrunner
#
# Usage: 
# 	./roadrunner.sh 2>&1 | tee ./logs/roadrunner.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
#
# @author: Matthias Koenig
# @date: 2016-01-06
############################################################
date
echo "--------------------------------------"
echo "roadrunner installation"
echo "--------------------------------------"
echo "Make directories for roadrunner installation"
ROADRUNNER=roadrunner
ROADRUNNER_DEPS=roadrunner-deps

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
GIT_DIR=$HOME/git 
TMP_DIR=$HOME/tmp
if ! [ -d "$GIT_DIR" ]; then
	mkdir $GIT_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

# install dependencies
echo "install roadrunner dependencies"
sudo apt-get -y install llvm llvm-dev git libxml2-dev
sudo -E pip install numpy --upgrade
sudo -E pip install scipy --upgrade

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
git checkout master

# pull the develop repository
echo "--------------------------------------"
echo "pull roadrunner repository"
echo "--------------------------------------"
if [ -d "${GIT_DIR}/$ROADRUNNER" ]; then
	cd ${GIT_DIR}/$ROADRUNNER
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/roadrunner.git $ROADRUNNER	
fi
# checkout release tag or version to build
# git tag -l
cd ${GIT_DIR}/$ROADRUNNER
# git checkout tags/1.4.1
git checkout develop

# read -rsp $'Press any key to continue...\n' -n1 key

# create build folders
echo "--------------------------------------"
echo "build roadrunner third party deps"
echo "--------------------------------------"
ROADRUNNER_BUILD_THIRDPARTY=$TMP_DIR/roadrunner_build_thirdparty
ROADRUNNER_BUILD=$TMP_DIR/roadrunner_build
ROADRUNNER_INSTALL=$TMP_DIR/roadrunner_install
sudo rm -rf $ROADRUNNER_INSTALL
mkdir $ROADRUNNER_INSTALL

rm -rf $ROADRUNNER_BUILD_THIRDPARTY
mkdir $ROADRUNNER_BUILD_THIRDPARTY
cd $ROADRUNNER_BUILD_THIRDPARTY
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL ${GIT_DIR}/$ROADRUNNER_DEPS && make -j4 install

# read -rsp $'Press any key to continue...\n' -n1 key

# build roadrunner
echo "--------------------------------------"
echo "build roadrunner"
echo "--------------------------------------"
rm -rf $ROADRUNNER_BUILD
mkdir $ROADRUNNER_BUILD
cd $ROADRUNNER_BUILD
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL -DTHIRD_PARTY_INSTALL_FOLDER=$ROADRUNNER_INSTALL -DBUILD_LLVM=ON -DBUILD_PYTHON=ON -DUSE_TR1_CXX_NS=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON ${GIT_DIR}/$ROADRUNNER
make
make install

echo "--------------------------------------"
echo "roadrunner python bindings"
echo "--------------------------------------"
# clean old roadrunner installs
sudo rm -r /usr/local/lib/python2.7/dist-packages/roadrunner
sudo rm /usr/local/lib/python2.7/dist-packages/*roadrunner*

# make the python setup
cd $ROADRUNNER_INSTALL
sudo python setup.py install

echo "--------------------------------------"
echo "roadrunner tests"
echo "--------------------------------------"
cd $DIR
./roadrunner_test.py
