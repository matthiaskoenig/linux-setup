FROM ubuntu:16.04
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

# basic apt-tools & upgrade
RUN apt-get update && apt-get install -y \
    apt-utils \
    software-properties-common \
    sudo \
    git \
 && rm -rf /var/lib/apt/lists/*

# install oracle-java8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# install ubuntu base from linux-setup repository
# uses the ./ubuntu_base.sh script for installation
ENV HOME /home
WORKDIR $HOME
RUN git clone https://github.com/matthiaskoenig/linux-setup

WORKDIR $HOME/linux-setup/scripts
RUN mkdir logs

RUN ./ubuntu_base.sh 2>&1 | tee logs/ubuntu_base.log && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf $HOME/.cache

WORKDIR $HOME
