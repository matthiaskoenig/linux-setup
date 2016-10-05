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

# --- add repositories> ---
# R
sudo add-apt-repository -y ppa:marutter/rrutter
# cmake
sudo add-apt-repository -y ppa:george-edison55/cmake-3.x

sudo apt-get update


# --- installation
# R
sudo -E apt-get -y install r-base-core r-base r-base-dev r-recommended libcurl4-gnutls-dev libxml2-dev libssl-dev python-pip liblzma-dev lzma lzma-dev

# cmake
sudo apt-get install -y software-properties-common
sudo apt-get -y remove cmake cmake-gui
sudo apt-get -y install cmake cmake-qt-gui

# python
sudo apt-get -y install build-essential python-dev python-pip libfreetype6-dev
sudo apt-get -y install pandoc pandoc-citeproc
sudo apt-get -y install python-tk
sudo pip install numpy scipy matplotlib ipython pandas sympy nose jupyter --upgrade
sudo pip install networkx --upgrade
sudo pip install seaborn --upgrade
sudo pip install nose coverage mock --upgrade
sudo pip install sklearn --upgrade
sudo pip install palettable --upgrade
sudo pip install pyreadline --upgrade
sudo pip install pyexcel pyexcel-xlsx --upgrade

