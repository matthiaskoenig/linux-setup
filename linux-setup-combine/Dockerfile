FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>



# get latest changes from linux-setup
WORKDIR /$HOME/linux-setup
RUN git pull

# run ubuntu base installation
WORKDIR /$HOME/linux-setup/scripts

RUN ./combine.sh
WORKDIR /$HOME

# clean the container
RUN rm -rf /$HOME/git
RUN rm -rf /$HOME/svn
# RUN rm -rf /$HOME/tmp
RUN rm -rf /var/lib/apt/lists/*
