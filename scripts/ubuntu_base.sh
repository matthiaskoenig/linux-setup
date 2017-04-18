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
sudo apt-get -y install python-dev python-pip
sudo apt-get -y install python-tk
sudo apt-get -y install python-pygraphviz

sudo pip install pip --upgrade
sudo pip install Cython --upgrade
sudo pip install numpy --upgrade
sudo pip install scipy --upgrade
sudo pip install matplotlib --upgrade
sudo pip install ipython --upgrade
sudo pip install pandas --upgrade
# sudo pip install sympy --upgrade
# sudo pip install jupyter --upgrade
# sudo pip install ipywidgets --upgrade

# sudo pip install nose --upgrade
# sudo pip install coverage --upgrade
# sudo pip install mock --upgrade

# sudo pip install networkx --upgrade
# sudo pip install seaborn --upgrade
# sudo pip install sklearn --upgrade
# sudo pip install palettable --upgrade
# sudo pip install pyreadline --upgrade
# sudo pip install pyexcel pyexcel-xlsx --upgrade

