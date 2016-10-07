# Docker image with all the dependencies
#
# This allows to run the tests with the given docker image 
# which is much faster than rebuilding from source all the time.

FROM ubuntu:16.04
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install sudo
RUN apt-get -y upgrade

# all installation files are in the /home subdirectory
WORKDIR /$HOME

# checkout the linux-setup repo
RUN apt-get -y install git
RUN git clone https://github.com/matthiaskoenig/linux-setup

# run ubuntu base installation
WORKDIR /$HOME/linux-setup/scripts
RUN mkdir logs
RUN ./ubuntu_base.sh 2>&1 | tee logs/ubuntu_base.log
WORKDIR /$HOME

# clean the container
RUN rm -rf /var/lib/apt/lists/*