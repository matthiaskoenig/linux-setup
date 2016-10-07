FROM matthiaskoenig/linux-setup-base:latest
MAINTAINER Matthias Koenig <konigmatt@googlemail.com>


# get latest changes from linux-setup
WORKDIR $HOME/linux-setup
RUN git pull

# run ubuntu base installation
WORKDIR $HOME/linux-setup/scripts

# necessary for container
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsbml
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsedml
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libcombine
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsbml
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsbml


RUN ./combine.sh
WORKDIR $HOME

# clean the container
RUN rm -rf $HOME/git
RUN rm -rf $HOME/svn
# RUN rm -rf /$HOME/tmp
RUN rm -rf /var/lib/apt/lists/*
