#!/bin/bash
############################################################
# Build libsbml from latest source
#   http://svn.code.sf.net/p/sbml/code/trunk
#
# Usage: 
# 	./libsbml.sh 2>&1 | tee ./logs/libsbml.log
############################################################
date
TSTART=`date +%s`

echo "--------------------------------------"
echo "libsbml installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
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
sudo apt-get update
sudo apt-get -y install subversion cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libsbml repository"
echo "--------------------------------------"
if [ -d "${SVN_DIR}/$SBMLCODE" ]; then
	cd ${SVN_DIR}/$SBMLCODE
else
	cd $SVN_DIR
	# svn checkout http://svn.code.sf.net/p/sbml/code/trunk $SBMLCODE
	# sparse directory checkout
	svn checkout --quiet --depth empty http://svn.code.sf.net/p/sbml/code/trunk $SBMLCODE
    svn update --quiet --set-depth infinity $SBMLCODE/libsbml
	cd ${SVN_DIR}/$SBMLCODE
fi
svn update

echo "--------------------------------------"
echo "build libsbml"
echo "--------------------------------------"
LIBSBML_BUILD=$TMP_DIR/libsbml_build
# if [ -d "$LIBSBML_BUILD" ]; then
#	sudo rm -rf $LIBSBML_BUILD
# fi
mkdir $LIBSBML_BUILD
cd $LIBSBML_BUILD

cmake -DWITH_BZIP2=OFF -DWITH_ZLIB=OFF -DLIBSBML_USE_LEGACY_MATH=ON -DENABLE_COMP=ON -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_LAYOUT=ON -ENABLE_GROUPS -DENABLE_QUAL=ON -DWITH_EXAMPLES=ON -DWITH_R=ON -DWITH_PYTHON=OFF -DWITH_CREATE_PYTHON_SOURCE=ON ${SVN_DIR}/$SBMLCODE/libsbml
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

make -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

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
sudo rm /etc/profile.d/libsbml.sh

# installation
sudo make -j8 install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# sudo rm /usr/local/lib/python2.7/site-packages/libsbml.pth
# sudo rm -rf /usr/local/lib/python2.7/site-packages/libsbml

echo "--------------------------------------"
echo "python bindings"
echo "--------------------------------------"
cd $LIBSBML_BUILD/src/bindings/python/out/
python setup.py install --user

# test python bindings
cd $DIR
../tests/libsbml_test.py
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# test that pip package installed
echo pip list | grep libsbml

echo "--------------------------------------"
echo "R bindings"
echo "--------------------------------------"
sudo R CMD INSTALL $LIBSBML_BUILD/src/bindings/r/libSBML_*_R_x86_64-pc-linux-gnu.tar.gz

TEND=`date +%s`
RUNTIME=$((TEND-TSTART))
echo "runtime: $RUNTIME [s]"