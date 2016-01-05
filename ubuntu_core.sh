#!/bin/bash
############################################################
# Core Ubuntu setup after installation
# Install via 
# 	sudo apt-get install git
# 	GIT_DIR=$HOME/git
# 	mkdir $GIT_DIR
# 	cd $GIT_DIR
# 	git clone https://github.com/matthiaskoenig/linux-setup
#	./ubuntu_core.sh
#
# @author: Matthias Koenig
# @date: 2016-01-05
#
# Issues
# - how to sudo with password?
# - how to set environmental variables
############################################################

echo "*** create and delete directories ***"
rmdir $HOME/Documents
rmdir $HOME/Music
rmdir $HOME/Pictures
rmdir $HOME/Public
rmdir $HOME/Templates
rmdir $HOME/Videos
rm $HOME/examples.desktop

mkdir $HOME/git
mkdir $HOME/svn

echo "*** Update & upgrade system ***"
sudo apt-get update
sudo apt-get -y upgrade

echo "*** Install codecs ***"
sudo apt-get -y install ubuntu-restricted-extras libxine1-ffmpeg gxine mencoder mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 libjpeg-progs flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview flac libmpeg3-1 mpeg3-utils mpegdemux liba52-0.7.4-dev 

echo "*** gnome session flashback ***"
sudo apt-get -y install gnome-session-flashback compizconfig-settings-manager compiz-plugins

echo "*** gparted ***"
sudo apt-get -y install gparted

echo "*** terminator ***"
sudo apt-get -y install terminator

echo "*** ssh ***"
sudo apt-get -y install openssh-server

echo "*** git ***"
sudo apt-get -y install git
git config --global user.email "konigmatt@googlemail.com"
git config --global user.name "Matthias Koenig"
git config --global credential.helper 'cache --timeout 3600'

echo "*** svn ***"
sudo apt-get -y install subversion

echo "*** ntp ***"
sudo apt-get -y install ntp

echo "*** ant & maven ***"
sudo apt-get -y install ant
sudo apt-get -y install maven

echo "*** R ***"
sudo -E add-apt-repository -y ppa:marutter/rrutter
sudo -E apt-get update
sudo -E apt-get -y install r-base-core r-base r-base-dev r-recommended libcurl4-gnutls-dev libxml2-dev libssl-dev python-pip liblzma-dev lzma lzma-dev

echo "*** Java ***"
# remove openjdk
sudo apt-get -y purge openjdk*
sudo -E add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
# switch java alternatives
sudo update-java-alternatives -s java-8-oracle
java -version
javac -version

echo "*** Python ***"
# general python requirements
# TODO: make sure that the apt-get versions are removed
sudo apt-get -y install build-essential python-dev python-pip libfreetype6-dev
sudo -E pip install numpy scipy matplotlib ipython pandas sympy nose jupyter 
sudo apt-get -y install python-tk


