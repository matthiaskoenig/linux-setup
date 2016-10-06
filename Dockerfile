# Docker image with all the dependencies
#
# This allows to run the tests with the given docker image 
# which is much faster than rebuilding from source all the time.

FROM ubuntu:14.04
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>
RUN apt-get -y update


# checkout the linux-setup repo
RUN git clone https://github.com/matthiaskoenig/linux-setup
# run the combine script
RUN (cd linux-setup/scripts && ./combine.sh)
RUN ls
WORKDIR linux-setup
RUN ls

# defining environment variables
# ENV

# The add instruction is used to copy files from the local filesystem in the image
# ADD

# changing the working directory
# WORKDIR

# command that launches process within container
# CMD