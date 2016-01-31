#!/bin/bash
############################################################
# Install multiscale-galactose project
# github https://github.com/matthiaskoenig/multiscale-galactose
#
# Usage: 
# 	./multiscale-galactose.sh 2>&1 | tee ./logs/multiscale-galactose.log
#
# @author: Matthias Koenig
# @date: 2016-01-31
############################################################
date
echo "--------------------------------------"
echo "multiscale-galactose installation"
echo "--------------------------------------"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
GIT_DIR=$HOME/git 
TMP_DIR=$HOME/tmp
if ! [ -d "$GIT_DIR" ]; then
	mkdir $GIT_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

REPOSITORY=https://github.com/matthiaskoenig/multiscale-galactose.git
MG_NAME=multiscale-galactose
MG_DIR=$GIT_DIR/$MG_NAME
echo $MG_DIR

echo "--------------------------------------"
echo "pull multiscale-galactose repository"
echo "--------------------------------------"
if [ -d "$MG_DIR" ]; then
	cd $MG_DIR
	git pull
else
	cd $GIT_DIR
	git clone $REPOSITORY $MG_NAME
    cd $MG_DIR
fi
git checkout develop
echo "*commit*"
git rev-parse HEAD

# ln -s $MULTISCALE_GALACTOSE ~/multiscale-galactose
# mkdir $MULTISCALE_GALACTOSE_RESULTS

echo "--------------------------------------"
echo "postgres & django client"
echo "--------------------------------------"
# postgres
sudo apt-get -y install postgresql-client-common postgresql-client python-dev libpq-dev pgadmin3
# django
sudo -E pip install rpy2
sudo -E pip install psycopg2==2.6.1
sudo -E pip install django==1.8.7
sudo -E pip install django-extensions django-haystack --upgrade
sudo -E pip install django-debug-toolbar --upgrade
sudo -E pip install django-enumfield --upgrade
sudo -E pip install pandas matplotlib requests sh enum34 --upgrade
# MPI
sudo apt-get -y install libcr-dev mpich2 mpich2-doc
sudo -E pip install mpi4py
# h5py
sudo apt-get -y install libhdf5-dev
sudo -E pip install Cython --upgrade
sudo -E pip install h5py --upgrade
