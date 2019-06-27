#!/bin/bash
############################################################
# Build python package for libsbml from latest source
#   http://svn.code.sf.net/p/sbml/code/trunk
#
# Usage: 
# 	./python-libsbml.sh 2>&1 | tee ./logs/python-libsbml.log
#
# install dependencies
#     sudo apt-get update
#     sudo apt-get -y install subversion cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev
#
# checkout libsbml-experimental
#     cd ~/svn
#     svn checkout http://svn.code.sf.net/p/sbml/code/branches/libsbml-experimental libsbml
#     cd ~/svn/libsbml
#     svn update
############################################################

PYTHON_VERSION=3.6
if [ $PYTHON_VERSION -eq "2.7" ]
then
	PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython${PYTHON_VERSION}.so
else
	PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython${PYTHON_VERSION}m.so
fi
PYTHON_EXECUTABLE=/usr/bin/python${PYTHON_VERSION}
PYTHON_INCLUDE_DIR=/usr/include/python${PYTHON_VERSION}


DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

SVN_DIR=$HOME/svn
TMP_DIR=$HOME/tmp

echo "--------------------------------------"
echo "build libsbml"
echo "--------------------------------------"
LIBSBML_BUILD=$TMP_DIR/libsbml-experimental-$PYTHON_VERSION
if [ -d "$LIBSBML_BUILD" ]; then
	sudo rm -rf $LIBSBML_BUILD
fi
mkdir $LIBSBML_BUILD
cd $LIBSBML_BUILD

cmake -DWITH_BZIP2=OFF -DWITH_ZLIB=OFF -DENABLE_L3V2EXTENDEDMATH=ON -DENABLE_ARRAYS=ON -DENABLE_COMP=ON -DENABLE_DISTRIB=ON -DENABLE_DYN=ON -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_LAYOUT=ON -DENABLE_MULTI=ON -DENABLE_QUAL=ON -DENABLE_RENDER=ON -DENABLE_REQUIREDELEMENTS=ON -DENABLE_SPATIAL=ON -DWITH_EXAMPLES=OFF -DWITH_PYTHON=ON -DWITH_CREATE_PYTHON_SOURCE=ON -DPYTHON_LIBRARY=${PYTHON_LIBRARY} -DPYTHON_EXECUTABLE=${PYTHON_EXECUTABLE} -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE_DIR} ${SVN_DIR}/libsbml
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

make -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


# echo "--------------------------------------"
# echo "python bindings in virtualenv"
# echo "--------------------------------------"
# cd ~/tmp/libsbml-experimental-2.7/src/bindings/python/out/
# mkvirtualenv libsbml-py27 --python=python2.7
# (libsbml-py27) pip install .

# cd ~/tmp/libsbml-experimental-3.6/src/bindings/python/out/
# mkvirtualenv libsbml-py36 --python=python3.6
# (libsbml-py36) pip install .


