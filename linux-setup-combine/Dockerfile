FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>

# get latest changes from linux-setup
WORKDIR $HOME/linux-setup
RUN git pull

# paths to find libraries
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsbml
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsedml
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libcombine
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libnuml

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib/cellml-sdk-1.12-Linux-x86_64/lib

# run ubuntu base installation
WORKDIR $HOME/linux-setup/scripts

RUN ./combine.sh && \
    rm -rf $HOME/git && \
    rm -rf $HOME/svn && \
    rm -rf $HOME/tmp && \
    rm -rf $HOME/.cache && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $HOME

