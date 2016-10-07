FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

# get the latest changes from linux-setup
WORKDIR /home/linux-setup
RUN git pull

# run ubuntu base installation
WORKDIR /home/linux-setup/scripts
RUN ./combine.sh
WORKDIR /home

# clean the container
RUN rm -rf /var/lib/apt/lists/*