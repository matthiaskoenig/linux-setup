# Dockerfile documentation

Important arguments for docker
* `-p` : map ports
* `-e` : send environment variables to container
* `-net=host` : use host network settings

Problems with DNS server in images:
http://stackoverflow.com/questions/24991136/docker-build-could-not-resolve-archive-ubuntu-com-apt-get-fails-to-install-a
http://unix.stackexchange.com/questions/28941/what-dns-servers-am-i-using

nmcli dev show | grep DNS

in /etc/default/docker
DOCKER_OPTS="--dns 172.30.0.1"


Name the image
```
docker create --name="awesome-service" ubuntu:latest
```

Inspect container
```
docker inspect 84535234ba3
```

Interactive container
```
docker run --rm -ti ubuntu:latest /bin/bash
```

docker run --rm -ti progrium/stress --cpu 2 --io 1 --vm 2 --vm-bytes 128M --timeout 120s

cAdvisor information on localhost:8080

docker run \
--volume=/:/rootfs:ro \
--volume=/var/run:/var/run:rw \
--volume=/sys:/sys:ro \
--volume=/var/lib/docker/:/var/lib/docker:ro \
--publish=8080:8080 \
--detach=true \
--name=cadvisor \
google/cadvisor:latest

docker run --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest

docker run \
-e BIND_ADDRESS="0.0.0.0"
-e ENVIRONMENT="development" \
-e SERVICE_NAME="hubot" \
-e SERVICE_ENV="development" \
-e EXPRESS_USER="hubot" \
-e EXPRESS_PASSWORD="Chd273gdExAmPl3wlkjdf" \
-e PORT="8080" \
-e HUBOT_ADAPTER="hipchat" \
-e HUBOT_ALIAS="/" \
-e HUBOT_NAME="hubot" \
-e HUBOT_HIPCHAT_JID="someroom@chat.hipchat.com" \
-e HUBOT_HIPCHAT_PASSWORD='SOMEEXAMPLE' \
-e HUBOT_HIPCHAT_NAME="hubot" \
-e HUBOT_HIPCHAT_ROOMS="anotherroom@conf.hipchat.com" \
-e HUBOT_HIPCHAT_JOIN_ROOMS_ON_INVITE="true" \
-e REDIS_URL="redis://redis:6379" \
-d --restart="always" --name hubot hubot:latest

switch(process.env.ENVIRONMENT){
case 'development':
console.log('Running in development');
case 'staging':
console.log('Running in staging');
case 'production':
console.log('Running in production');
default:
console.log('Assuming that I am running in development');
}

# How to build the container?
docker build --no-cache -t linux-setup:v0.1.1-SNAPSHOT . 