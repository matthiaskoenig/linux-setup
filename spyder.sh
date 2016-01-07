#!/bin/bash
############################################################
# Install spyder
# Usage: 
# 	./spyder.sh 2>&1 | tee ./logs/spyder.log
#
# @author: Matthias Koenig
# @date: 2016-01-06
############################################################

echo "--------------------------------------"
echo "spyder installation"
echo "--------------------------------------"
sudo apt-get -y remove spyder python-sphinx

sudo -E pip install sphinx pep8 pylint pyflakes rope psutil pysandbox --upgrade
sudo apt-get -y install python-qt4
sudo apt-get -y install ipython ipython-qtconsole
sudo -E pip install spyder --upgrade
