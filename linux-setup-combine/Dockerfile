FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>


# checkout the linux-setup repo
RUN git clone https://github.com/matthiaskoenig/linux-setup

# run ubuntu base installation
WORKDIR linux-setup/scripts
RUN ./combine.sh
WORKDIR /

# clean the container
RUN rm -rf /var/lib/apt/lists/*