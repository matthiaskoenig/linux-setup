FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

# get the latest changes from linux-setup
WORKDIR linux-setup
RUN git pull

# run ubuntu base installation
WORKDIR linux-setup/scripts
RUN ls
RUN ./combine.sh
WORKDIR /

# clean the container
RUN rm -rf /var/lib/apt/lists/*