#!/bin/bash
############################################################
# Build antimony from latest source
#   http://svn.code.sf.net/p/antimony/code/
#
# Ubuntu
#
# @author: Matthias Koenig
# @date: 2015-01-05
############################################################

CODE=antimony
ANTIMONY=antimony

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
echo "install dependencies"
echo "---------------------------------------"
sudo apt-get -y install libqt4-core libqt4-dev

echo "--------------------------------------"
echo "pull libsbml repository"
echo "--------------------------------------"
if [ -d "${SVN_DIR}/$CODE" ]; then
	cd ${SVN_DIR}/$CODE
	svn update
else
	cd $SVN_DIR
	svn checkout http://svn.code.sf.net/p/antimony/code/ $CODE
	cd ${SVN_DIR}/$CODE
fi

exit

echo "--------------------------------------"
echo "build antimony"
echo "--------------------------------------"
ANTIMONY_BUILD=$TMP_DIR/antimony_build
rm -rf $ANTIMONY_BUILD
mkdir $ANTIMONY_BUILD

# here are the cmake files
cd $ANTIMONY_BUILD
cmake -DENABLE_COMP=ON -DENABLE_FBC=ON -DENABLE_LAYOUT=ON -DENABLE_QUAL=ON -DWITH_EXAMPLES=ON -DWITH_PYTHON=ON -DWITH_R=ON ${SVN_DIR}/$CODE/libsbml

make
sudo make install

echo "--------------------------------------"
echo "python & R bindings"
echo "--------------------------------------"
echo "/usr/local/lib/python2.7/site-packages/libsbml"

cd $LIBSBML_BUILD/src/bindings/r/
sudo R CMD INSTALL libSBML_*_R_x86_64-pc-linux-gnu.tar.gz


