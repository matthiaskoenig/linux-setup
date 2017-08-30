#!/bin/bash
############################################################
# Core Ubuntu setup after clean installation.
#
# This is used on clean Ubuntu computers which should be
# used as workstation
#
# Usage: 
# 	./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
#
# Subsequent installation:
#   ./ubuntu_base.sh
#   ./INSTALL.sh
#
# TODO: remove redundancies between ubuntu_core & ubuntu_base
############################################################
date
echo "*** create and delete directories ***"
# only deletes if empty
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
sudo pip install --upgrade setuptools pip

echo "*** Install codecs ***"
sudo apt-get -y install ubuntu-restricted-extras libxine1-ffmpeg gxine mencoder mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6v5 icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 libjpeg-progs flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview flac mpeg3-utils mpegdemux liba52-0.7.4-dev 

echo "*** gparted ***"
sudo apt-get -y install gparted
sudo apt-get -y install terminator
sudo apt-get -y install htop
sudo apt-get -y install indicator-multiload

echo "*** ssh ***"
sudo apt-get -y install openssh-server

echo "*** git ***"
sudo apt-get -y install git gitk

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
# install oracle-java8
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && \
  sudo add-apt-repository -y ppa:webupd8team/java && \
  sudo apt-get update && \
  sudo apt-get install -y oracle-java8-installer && \
  sudo rm -rf /var/cache/oracle-jdk8-installer


# switch java alternatives
sudo update-java-alternatives -s java-8-oracle
java -version
javac -version

# export JAVA_HOME
echo "Setting JAVA_HOME: /usr/lib/jvm/java-8-oracle"
cat > java.sh << EOF0
#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
EOF0
sudo mv java.sh /etc/profile.d/

# echo "*** cmake ***"
sudo apt-get -y install cmake cmake-qt-gui

echo "-----------------------------------------"
echo "Python dependencies"
echo "-----------------------------------------"
sudo apt-get -y install build-essential python-dev python-pip libfreetype6-dev
sudo apt-get -y install python-tk python3-tk
sudo -E pip install numpy scipy matplotlib ipython pandas jupyter --upgrade
sudo -E pip install virtualenv virtualenvwrapper --upgrade



