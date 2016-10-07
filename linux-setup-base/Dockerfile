FROM ubuntu:16.04
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install software-properties-common
RUN apt-get -y install sudo
RUN apt-get -y upgrade

# Install oracle-java8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer &&
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# install ubuntu base from linux-setup repository
RUN apt-get -y install git
ENV HOME /home
WORKDIR $HOME
RUN git clone https://github.com/matthiaskoenig/linux-setup

WORKDIR $HOME/linux-setup/scripts
RUN mkdir logs

RUN ./ubuntu_base.sh 2>&1 | tee logs/ubuntu_base.log && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
