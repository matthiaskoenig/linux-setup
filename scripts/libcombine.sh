#!/bin/bash
############################################################
# Build libCombine from latest source
# https://github.com/sbmlteam/libCombine.git
#
# Usage: 
# 	./libcombine.sh 2>&1 | tee ./logs/libcombine.log
#
# Depends on Zipper library
############################################################
date
TSTART=`date +%s`
echo "--------------------------------------"
echo "libCombine installation"
echo "--------------------------------------"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CODE=libCombine
REPO=https://github.com/sbmlteam/libCombine.git

GIT_DIR=$HOME/git
TMP_DIR=$HOME/tmp
if ! [ -d "${GIT_DIR}" ]; then
	mkdir ${GIT_DIR}
fi
if ! [ -d "${TMP_DIR}" ]; then
	mkdir ${TMP_DIR}
fi

echo "---------------------------------------"
echo "install libCombine dependencies"
echo "---------------------------------------"
sudo apt-get -y install cmake cmake-gui swig libxml2 libxml2-dev libbz2-dev zlib1g-dev

echo "--------------------------------------"
echo "pull libCombine repository"
echo "--------------------------------------"
echo "$GIT_DIR/${CODE}"
if [ -d "$GIT_DIR/${CODE}" ]; then
	cd $GIT_DIR/${CODE}
	git pull
    git checkout master
else
	cd $GIT_DIR
	git clone ${REPO} ${CODE}
	cd $GIT_DIR/${CODE}
fi
echo "*commit*"
git rev-parse HEAD
echo 

echo "--------------------------------------"
echo "build libCombine"
echo "--------------------------------------"
BUILD=$TMP_DIR/libCombine_build
# if [ -d "${BUILD}" ]; then
# 	sudo rm -rf ${BUILD}
# fi
mkdir ${BUILD}
cd ${BUILD}

cmake -DEXTRA_LIBS="xml2;z;bz2;" -DWITH_QT_FILESYSTEM=ON -DWITH_JAVA=ON -DWITH_PYTHON=ON ${GIT_DIR}/$CODE
make -j8
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "--------------------------------------"
echo "install libCombine"
echo "--------------------------------------"
# remove old installation
sudo rm -rf /usr/local/include/combine/
sudo rm -rf /usr/local/include/omex/
sudo rm -rf /usr/local/lib/libCombine*
sudo rm -rf /usr/local/lib/libcombine*
sudo rm -rf /usr/local/share/java/libcombine.jar
sudo rm -rf /usr/local/lib/python2.7/site-packages/libcombine/
sudo rm /usr/local/lib/python2.7/site-packages/libcombine.pth
sudo rm -rf /usr/local/lib/python3.5/site-packages/libcombine/
sudo rm /usr/local/lib/python3.5/site-packages/libcombine.pth

sudo rm /etc/profile.d/libcombine.sh

# installation
sudo make install
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "--------------------------------------"
echo "python bindings"
echo "--------------------------------------"
echo "Adding to PYTHONPATH: /usr/local/lib/python2.7/site-packages/libcombine"
cat > libcombine.sh << EOF0
#!/bin/bash
export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python2.7/site-packages/libcombine
EOF0
sudo mv libcombine.sh /etc/profile.d/
source /etc/profile.d/libcombine.sh

# tests
cd $DIR
../tests/libcombine_test.py
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

TEND=`date +%s`
RUNTIME=$((TEND-TSTART))
echo "runtime: $RUNTIME [s]"