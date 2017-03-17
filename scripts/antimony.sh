#!/bin/bash
############################################################
# Build antimony from latest source
#   http://svn.code.sf.net/p/antimony/code/
#
# Usage: 
# 	./antimony.sh 2>&1 | tee ./logs/antimony.log
############################################################
date
echo "--------------------------------------"
echo "antimony installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=antimony
ANTIMONY=antimony

SVN_DIR=$HOME/svn
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
TMP_DIR=$HOME/tmp
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

echo "---------------------------------------"
echo "install dependencies"
echo "---------------------------------------"
# qt
if lsb_release -r -s | grep -q '14.04'; then
  echo "Dependencies for Ubuntu 14.04"
  sudo apt-get -y install libqt4-core libqt4-dev
fi
if lsb_release -r -s | grep -q '16.04'; then
  echo "Dependencies for Ubuntu 16.04"
  sudo apt-get -y install qt4-default
fi

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
echo "Build directory:" $ANTIMONY_BUILD
# if [ -d "$ANTIMONY_BUILD" ]; then
#	sudo rm -rf $ANTIMONY_BUILD
# fi
mkdir $ANTIMONY_BUILD
cd $ANTIMONY_BUILD
# with cellml
# cmake -DWITH_CELLML=ON -DCELLML_API_INSTALL_DIR="/usr/local/lib/cellml-sdk-1.13-Linux-x86_64" -DWITH_PYTHON=ON ${SVN_DIR}/$CODE/antimony
cmake -DWITH_CELLML=ON -DWITH_PYTHON=ON ${SVN_DIR}/$CODE/antimony
make # DONT ! -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "--------------------------------------"
echo "install antimony"
echo "--------------------------------------"
# remove old version
sudo pip uninstall antimony
sudo rm -rf /usr/local/lib/python2.7/dist-packages/antimony*
sudo rm -rf /usr/local/lib/python2.7/site-packages/antimony
sudo rm -rf /usr/local/lib/python2.7/site-packages/libantimony.pth

sudo make install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


echo "--------------------------------------"
echo "test antimony"
echo "--------------------------------------"
cd $DIR
../tests/antimony_test.py
