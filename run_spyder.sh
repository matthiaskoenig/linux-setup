#!/usr/bin/env bash
#################################################
# Start spyder from the combine container.
#
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
#################################################

# TODO: set user variable
# export USER=user

# TODO: connect GUI
# root@core1:~# /usr/local/bin/spyder
# No protocol specified
# Spyder: cannot connect to X server unix:0.0

# http://stackoverflow.com/questions/25281992/alternatives-to-ssh-x11-forwarding-for-docker-containers/25334301#25334301

docker run -it \
--net host \
--cpuset-cpus 0 \
--memory 512mb \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
-e DISPLAY=unix$DISPLAY \
-u combine \
matthiaskoenig/linux-setup-combine /bin/bash /usr/local/bin/spyder
# --name spyder \