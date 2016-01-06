#!/bin/bash
############################################################
# Build libsbml from latest source
#   http://svn.code.sf.net/p/sbml/code/trunk
#
# Usage: 
# 	./libsbml_build.sh 2>&1 | tee ./libsbml_build.log
#
# @author: Matthias Koenig
# @date: 2015-12-08
############################################################

SBMLCODE=sbml-code
LIBSBML=libsbml

SVN_DIR=$HOME/svn
TMP_DIR=$HOME/tmp
if ! [ -d "$SVN_DIR" ]; then
	mkdir $SVN_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

# install dependencies
echo "---------------------------------------"
echo "install libsbml dependencies"
echo "---------------------------------------"
sudo apt-get -y install cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libsbml repository"
echo "--------------------------------------"
if [ -d "${SVN_DIR}/$SBMLCODE" ]; then
	cd ${SVN_DIR}/$SBMLCODE
	svn update
else
	cd $SVN_DIR
	svn checkout http://svn.code.sf.net/p/sbml/code/trunk $SBMLCODE
	cd ${SVN_DIR}/$SBMLCODE
fi

echo "--------------------------------------"
echo "build libsbml"
echo "--------------------------------------"
LIBSBML_BUILD=$TMP_DIR/libsbml_build
rm -rf $LIBSBML_BUILD
mkdir $LIBSBML_BUILD

# here are the cmake files
cd $LIBSBML_BUILD
cmake -DENABLE_COMP=ON -DENABLE_FBC=ON -DENABLE_LAYOUT=ON -DENABLE_QUAL=ON -DWITH_EXAMPLES=ON -DWITH_PYTHON=ON -DWITH_R=ON ${SVN_DIR}/$SBMLCODE/libsbml
make
sudo make install

echo "--------------------------------------"
echo "python & R bindings"
echo "--------------------------------------"
echo "/usr/local/lib/python2.7/site-packages/libsbml"

cd $LIBSBML_BUILD/src/bindings/r/
sudo R CMD INSTALL libSBML_*_R_x86_64-pc-linux-gnu.tar.gz


