#!/bin/bash
############################################################
# Build tellurium directly from the release files
# github https://github.com/sys-bio/tellurium-examples
# github https://github.com/sys-bio/tellurium
#
# Usage: 
# 	./tellurium.sh 2>&1 | tee ./logs/tellurium.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
#
# @author: Matthias Koenig
# @date: 2016-01-15
############################################################
date
echo "--------------------------------------"
echo "tellurium installation"
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

echo "--------------------------------------"
echo "tellurium-dependencies"
echo "--------------------------------------"
sudo -E pip install nose coverage --upgrade
sudo apt-get -y install graphviz graphviz-dev libgraphviz-dev
sudo -E pip install pygraphviz --install-option="--include-path=/usr/include/graphviz" --install-option="--library-path=/usr/lib/graphviz/" --upgrade
sudo -E pip install bioservices


echo "--------------------------------------"
echo "tellurium-examples"
echo "--------------------------------------"
TELLURIUM_EXAMPLES=tellurium-examples

if [ -d "${GIT_DIR}/$TELLURIUM_EXAMPLES" ]; then
	cd ${GIT_DIR}/$TELLURIUM_EXAMPLES
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/tellurium-examples.git $TELLURIUM_EXAMPLES
    cd ${GIT_DIR}/$TELLURIUM_EXAMPLES
fi
git checkout master
echo "*commit*"
git rev-parse HEAD

echo "--------------------------------------"
echo "tellurium"
echo "--------------------------------------"
TELLURIUM=tellurium

if [ -d "${GIT_DIR}/$TELLURIUM" ]; then
	cd ${GIT_DIR}/$TELLURIUM
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/sys-bio/tellurium.git $TELLURIUM
    cd ${GIT_DIR}/$TELLURIUM
fi
git checkout master

echo "--------------------------------------"
echo "install tellurium"
echo "--------------------------------------"
sudo python setup.py install

echo "--------------------------------------"
echo "test tellurium"
echo "--------------------------------------"
cd $DIR
../tests/tellurium_test.py

