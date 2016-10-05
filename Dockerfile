# Docker image with all the dependencies
#
# This allows to run the tests with the given docker image 
# which is much faster than rebuilding from source all the time.

FROM ubuntu

MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

RUN apt-get -y update

# defining environment variables
ENV

# The add instruction is used to copy files from the local filesystem in the image
ADD

# changing the working directory
WORKDIR

# checkout the linux-setup repo
RUN
# run the combine script
RUN (cd linux-setup/scripts && ./combine.sh)

# command that launches process within container
CMD

