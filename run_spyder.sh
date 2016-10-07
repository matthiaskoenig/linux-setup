#!/usr/bin/env bash
#################################################
# Start spyder from the combine container.
#
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
#################################################

# TODO: set user variable

docker run -it \
--net host \
--cpuset-cpus 0 \
--memory 512mb \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
matthiaskoenig/linux-setup-combine /bin/bash # /usr/local/bin/spyder
# --name spyder \