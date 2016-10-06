# Docker image with all the dependencies
#
# This allows to run the tests with the given docker image 
# which is much faster than rebuilding from source all the time.

FROM ubuntu:14.04
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install git


# checkout the linux-setup repo
RUN git clone https://github.com/matthiaskoenig/linux-setup
WORKDIR linux-setup/scripts

# run ubuntu base installation
RUN ./ubuntu_base.sh
RUN ls


# defining environment variables
# ENV

# The add instruction is used to copy files from the local filesystem in the image
# ADD

# changing the working directory
# WORKDIR

# command that launches process within container
# CMD