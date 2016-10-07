#!/usr/bin/env bash
#################################################
# Start spyder from the combine container.
#
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
#################################################

# TODO: connect GUI
# root@core1:~# /usr/local/bin/spyder
# No protocol specified
# Spyder: cannot connect to X server unix:0.0

# !!! don't do this
xhost +

# Granting access only to a specific trusted docker container by using the containers hostname.
# xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`


# http://stackoverflow.com/questions/25281992/alternatives-to-ssh-x11-forwarding-for-docker-containers/25334301#25334301
# http://olivier.barais.fr/blog/posts/2014.08.26/Eclipse_in_docker_container.html
# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# http://wiki.ros.org/docker/Tutorials/GUI

docker run -it \
--net host \
--cpuset-cpus 0 \
--memory 512mb \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
-e DISPLAY=unix$DISPLAY \
-e USER=combine \
matthiaskoenig/linux-setup-combine /bin/bash # spyder

# export containerId=$(docker ps -l -q)
# xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
