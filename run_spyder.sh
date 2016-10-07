#!/usr/bin/env bash
#################################################
# Start spyder from the combine container.
#
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
#################################################

# TODO: set user variable

# TODO: connect GUI
# root@core1:~# /usr/local/bin/spyder
# No protocol specified
# Spyder: cannot connect to X server unix:0.0


docker run -it \
--net host \
--cpuset-cpus 0 \
--memory 512mb \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
matthiaskoenig/linux-setup-combine /bin/bash # /usr/local/bin/spyder
# --name spyder \