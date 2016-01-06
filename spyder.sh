#!/bin/bash
############################################################
# Install spyder
# Usage: 
# 	./roadrunner_build.sh 2>&1 | tee ./roadrunner_build.log
#
# To select a branch/tag/commit to build from change the
# checkout command for roadrunner.
#
# @author: Matthias Koenig
# @date: 2016-01-05
############################################################
sudo apt-get -y remove spyder python-sphinx

sudo -E pip install sphinx pep8 pylint pyflakes rope psutil pysandbox --upgrade
sudo apt-get -y install python-qt4
sudo apt-get -y install ipython ipython-qtconsole
sudo -E pip install spyder --upgrade
