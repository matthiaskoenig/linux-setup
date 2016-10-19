#!/usr/bin/env bash
######################################################
#
# Building the cellml api from scratch, due to
# issues with pre-builds on Ubuntu 16.04
#
######################################################

sudo apt-get install -y doxygen omniidl bison flex

cd $HOME/git
git clone https://github.com/cellmlapi/cellml-api/

# create build dir
mkdir $HOME/tmp/cellml-api_build
cd $HOME/tmp/cellml-api_build

# cmake
# use CMAKE_INSTALL_PREFIX=$INSTALL_DIR to install in other directory
cmake -DBUILD_TESTING=OFF -DENABLE_ANNOTOOLS=ON -DENABLE_CCGS=ON -DENABLE_CELEDS=ON -DENABLE_CELEDS_EXPORTER=ON \
-DENABLE_CEVAS=ON -DENABLE_CUSES=ON -DENABLE_MALAES=ON -DENABLE_TELICEMS=ON -DENABLE_RDF=ON -DENABLE_VACSS=ON \
-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++0x $HOME/git/cellml-api

# headers must be create
make CXX_HEADERS_FOR_INTERFACES
make
sudo make install