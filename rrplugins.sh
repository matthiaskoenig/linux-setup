#!/bin/bash
############################################################
# Build rrplugins from
# github https://github.com/sys-bio/rrplugins
#
# Usage: 
# 	./rrplugins.sh 2>&1 | tee ./logs/rrplugins.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
#
# @author: Matthias Koenig
# @date: 2016-02-01
############################################################
date
echo "--------------------------------------"
echo "rrplugins installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
GIT_DIR=$HOME/git 
TMP_DIR=$HOME/tmp
if ! [ -d "$GIT_DIR" ]; then
	mkdir $GIT_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

RRPLUGINS=rrplugins

echo "--------------------------------------"
echo "rrplugins repository"
echo "--------------------------------------"
if [ -d "$GIT_DIR/$RRPLUGINS" ]; then
	cd $GIT_DIR/$RRPLUGINS
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/rrplugins.git $RRPLUGINS
    cd $GIT_DIR/$RRPLUGINS
fi
git checkout master
echo "*commit*"
git rev-parse HEAD
git branch --list

echo "--------------------------------------"
echo "build rrplugins"
echo "--------------------------------------"
RRPLUGINS_BUILD=$TMP_DIR/rrplugins_build
rm -rf $RRPLUGINS_BUILD
mkdir $RRPLUGINS_BUILD
cd $RRPLUGINS_BUILD

ROADRUNNER_INSTALL=$TMP_DIR/roadrunner_install
cmake -DTLP_DEPENDENCIES_PATH=$ROADRUNNER_INSTALL ${GIT_DIR}/$RRPLUGINS
make
make install

exit

echo "--------------------------------------"
echo "roadrunner python bindings"
echo "--------------------------------------"
# clean old roadrunner installs
sudo rm -r /usr/local/lib/python2.7/dist-packages/roadrunner
sudo rm /usr/local/lib/python2.7/dist-packages/*roadrunner*

# make the python setup
cd $ROADRUNNER_INSTALL
sudo python setup.py install

