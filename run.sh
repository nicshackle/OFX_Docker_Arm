# !/usr/bin/env bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth-n

touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it \
    --volume=$XSOCK:$XSOCK \
    --volume=$XAUTH:$XAUTH \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    --volume=$PWD:/app \
    --device=/dev/dri:/dev/dri \
    --volume=/run/user/$(id -u)/pulse:/run/pulse \
    of
