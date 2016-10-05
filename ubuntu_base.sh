#!/bin/bash
############################################################
# 
# Setup of basic requirements for the simulation stack
# 
############################################################
date
echo "*** create and delete directories ***"
mkdir $HOME/git
mkdir $HOME/svn

# python setuptools
sudo pip install --upgrade setuptools pip

# R
sudo -E add-apt-repository -y ppa:marutter/rrutter
sudo -E apt-get update
sudo -E apt-get -y install r-base-core r-base r-base-dev r-recommended libcurl4-gnutls-dev libxml2-dev libssl-dev python-pip liblzma-dev lzma lzma-dev

# cmake
sudo -E apt-get -y remove cmake cmake-data cmake-gui
sudo -E apt-get install -y software-properties-common
sudo -E add-apt-repository -y ppa:george-edison55/cmake-3.x
sudo -E apt-get update
sudo -E apt-get -y install cmake cmake-qt-gui

# python 
sudo apt-get -y install build-essential python-dev python-pip libfreetype6-dev
sudo -E pip install numpy scipy matplotlib ipython pandas sympy nose jupyter --upgrade
sudo -E pip install networkx --upgrade
sudo apt-get -y install pandoc pandoc-citeproc
sudo apt-get -y install python-tk
sudo -E pip install seaborn --upgrade
sudo -E pip install nose coverage mock --upgrade
sudo -E pip install sklearn --upgrade
sudo -E pip install palettable --upgrade
sudo -E pip install pyreadline --upgrade
sudo -E pip install pyexcel pyexcel-xlsx --upgrade

