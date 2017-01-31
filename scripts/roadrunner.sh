#!/bin/bash
############################################################
# Build roadrunner directly from the release files on
# github https://github.com/sys-bio/roadrunner
# The dependencies must be build first, i.e. run at least
# once roadrunner-deps.sh
#
# Usage: 
# 	./roadrunner.sh 2>&1 | tee ./logs/roadrunner.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
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
cd ${GIT_DIR}/$ROADRUNNER
git checkout develop

echo "*commit*"
git rev-parse HEAD

# read -rsp $'Press any key to continue...\n' -n1 key


echo "--------------------------------------"
echo "build roadrunner"
echo "--------------------------------------"
ROADRUNNER_BUILD=${TMP_DIR}/roadrunner_build
ROADRUNNER_INSTALL=${TMP_DIR}/roadrunner_install
rm -rf $ROADRUNNER_BUILD
mkdir $ROADRUNNER_BUILD
cd $ROADRUNNER_BUILD

LLVM=llvm
LLVM_VERSION=3.5.2
LLVM_INSTALL=$TMP_DIR/${LLVM}-${LLVM_VERSION}_install

cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL -DTHIRD_PARTY_INSTALL_FOLDER=$ROADRUNNER_INSTALL -DBUILD_LLVM=ON -DBUILD_PYTHON=ON -DUSE_TR1_CXX_NS=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON -DLIBSBML_INCLUDE_DIR=$ROADRUNNER_INSTALL/include -DLIBSBML_LIBRARY=$ROADRUNNER_INSTALL/lib/libsbml.so -DLIBSBML_STATIC_LIBRARY=$ROADRUNNER_INSTALL/lib/libsbml-static.a -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so -DBZ2_LIBRARY=/usr/lib/x86_64-linux-gnu/libbz2.so -DLLVM_CONFIG_EXECUTABLE=${LLVM_INSTALL}/bin/llvm-config -DPYTHON_EXECUTABLE="/usr/bin/python" -DPYTHON_INCLUDE_DIR="/usr/include/python2.7" -DPYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/libpython2.7.so" ${GIT_DIR}/$ROADRUNNER

make -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
make install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
# run the c++ tests
ctest -VV

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
../tests/roadrunner_test.py
