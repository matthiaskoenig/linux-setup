#!/bin/bash
############################################################
# Setup of basic requirements for simulation stack
#
# Usage:
# 	./ubuntu_base.sh 2>&1 | tee ./logs/ubuntu_base.log
############################################################
date

echo "*** create and delete directories ***"
mkdir $HOME/git
mkdir $HOME/svn

# general requirements
sudo apt-get -y install software-properties-common
sudo apt-get -y install build-essential libfreetype6-dev
sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev liblzma-dev lzma lzma-dev

# cmake
sudo apt-get install -y software-properties-common
sudo apt-get -y install cmake cmake-qt-gui

# R
sudo add-apt-repository -y ppa:marutter/rrutter
sudo apt-get -y update
sudo apt-get -y install r-base-core r-base r-base-dev r-recommended

# python
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo apt-get -y install python-tk python3-tk
sudo apt-get -y install python-pygraphviz python3-pygraphviz


sudo pip install pip --upgrade
sudo pip install Cython --upgrade
sudo pip install numpy --upgrade
sudo pip install scipy --upgrade
sudo pip install matplotlib --upgrade
sudo pip install ipython --upgrade
sudo pip install jupyter --upgrade
sudo pip install pandas --upgrade

sudo pip3 install pip --upgrade
sudo pip3 install Cython --upgrade
sudo pip3 install numpy --upgrade
sudo pip3 install scipy --upgrade
sudo pip3 install matplotlib --upgrade
sudo pip3 install ipython --upgrade
sudo pip3 install jupyter --upgrade
sudo pip3 install pandas --upgrade

