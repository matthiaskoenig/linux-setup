#!/bin/bash
############################################################
# Build libCombine from latest source
# https://github.com/sbmlteam/libCombine.git
#
# Usage: 
# 	./libCombine.sh 2>&1 | tee ./logs/libCombine.log
#
############################################################
date
echo "--------------------------------------"
echo "libCombine installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMBINECODE=libCombine


GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi
exit

echo "---------------------------------------"
echo "install libCombine dependencies"
echo "---------------------------------------"
sudo apt-get -y install cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libNUML repository"
echo "--------------------------------------"
echo "$GIT_DIR/${COMBINECODE}"
if [ -d "$GIT_DIR/${COMBINECODE}" ]; then
	cd $GIT_DIR/$COMBINECODE
	git pull
    git checkout 46558fcea3d
else
	cd $GIT_DIR
	git clone https://github.com/NuML/NuML.git $NUMLCODE
	cd $GIT_DIR/$NUMLCODE
fi
echo "*commit*"
git rev-parse HEAD

echo 

echo "--------------------------------------"
echo "build libNUML"
echo "--------------------------------------"
NUML_BUILD=$TMP_DIR/numl_build
if [ -d "$NUML_BUILD" ]; then
	sudo rm -rf $NUML_BUILD
fi
mkdir $NUML_BUILD

# here are the cmake files
cd $NUML_BUILD

cmake -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_JAVA=ON -DWITH_PYTHON=ON -DWITH_R=ON ${GIT_DIR}/$NUMLCODE/libnuml
make -j8

echo "--------------------------------------"
echo "install libnuml"
echo "--------------------------------------"
# remove old files
sudo rm -rf /usr/local/share/libnuml
sudo rm -rf /usr/local/include/numl/
sudo rm -rf /usr/local/lib/libnuml*
# installation
sudo make install
