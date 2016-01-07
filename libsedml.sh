#!/bin/bash
############################################################
# Build libsedml from latest source
#   https://github.com/NuML/NuML.git
#	https://github.com/fbergmann/libSEDML.git
#
# Usage: 
# 	./libsedml.sh 2>&1 | tee ./logs/libsedml.log
#
# @author: Matthias Koenig
# @date: 2016-01-07
############################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
NUMLCODE=numl-code
SEDMLCODE=sedml-code

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

echo "---------------------------------------"
echo "install libsedml dependencies"
echo "---------------------------------------"
sudo apt-get -y install cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libNUML repository"
echo "--------------------------------------"
echo "$GIT_DIR/$NUMLCODE"
if [ -d "$GIT_DIR/$NUMLCODE" ]; then
	cd $GIT_DIR/$NUMLCODE
	git pull
else
	cd $GIT_DIR
	git clone https://github.com/NuML/NuML.git $NUMLCODE
	cd $GIT_DIR/$NUMLCODE
fi

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

exit

cmake -DENABLE_COMP=ON -DENABLE_FBC=ON -DENABLE_LAYOUT=ON -DENABLE_QUAL=ON -DWITH_EXAMPLES=ON -DWITH_PYTHON=ON -DWITH_R=ON ${SVN_DIR}/$SBMLCODE/libsbml
make

echo "--------------------------------------"
echo "install libsbml"
echo "--------------------------------------"
# remove old files
sudo rm -rf /usr/local/share/libsbml
sudo rm /usr/local/lib/pkgconfig/libsbml.pc
sudo rm -rf /usr/local/include/sbml/
sudo rm -rf /usr/local/lib/libsbml*
sudo rm /usr/local/lib/python2.7/site-packages/libsbml.pth
sudo rm -rf /usr/local/lib/python2.7/site-packages/libsbml

# installation
sudo make install

echo "--------------------------------------"
echo "python & R bindings"
echo "--------------------------------------"
# install R bindings
cd $LIBSBML_BUILD/src/bindings/r/
sudo R CMD INSTALL libSBML_*_R_x86_64-pc-linux-gnu.tar.gz

# python bindings
echo "Add to path: /usr/local/lib/python2.7/site-packages/libsbml"
echo "export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python2.7/site-packages/libsbml"

./libsbml_test.py



