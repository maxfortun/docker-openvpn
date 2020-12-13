#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

. $SWD/setenv.sh

RUN_IMAGE="$REPO/$NAME"

DOCKER_RUN_ARGS=( -e container=docker )
DOCKER_RUN_ARGS+=( -v /etc/resolv.conf:/etc/resolv.conf:ro )

# Publish exposed ports
imageId=$(docker images --format="{{.Repository}} {{.ID}}"|grep "^$RUN_IMAGE "|awk '{ print $2 }')
while read port; do
	hostPort=$DOCKER_PORT_PREFIX${port%%/*}
	[ ${#hostPort} -gt 5 ] && hostPort=${hostPort:${#hostPort}-5}
	DOCKER_RUN_ARGS+=( -p $hostPort:$port )
done < <(docker image inspect -f '{{json .Config.ExposedPorts}}' $imageId|jq -r 'keys[]')

HOST_MNT=${HOST_MNT:-$BWD/mnt}
GUEST_MNT=${GUEST_MNT:-$BWD/mnt}

DOCKER_RUN_ARGS+=( --cap-add=NET_ADMIN )
DOCKER_RUN_ARGS+=( --cap-add=MKNOD  )
DOCKER_RUN_ARGS+=( -v $GUEST_MNT/etc/openvpn/server:/etc/openvpn/server )
DOCKER_RUN_ARGS+=( -v $GUEST_MNT/etc/openvpn/client:/etc/openvpn/client )

OPENVPN_PRIVATE_SUBNETS=$(ifconfig -a|egrep 'inet (10|172.16|192.168)'|awk '{print $6, $4}' | tr '[a-f]' '[A-F]' | while read subnet netmask; do netmask=${netmask#0x}; netmask=$(dc -e 16i2o${netmask}p); netmask=${netmask%%0*}; echo $subnet/${#netmask}; done|xargs)
DOCKER_RUN_ARGS+=( -e "OPENVPN_PRIVATE_SUBNETS=$OPENVPN_PRIVATE_SUBNETS" )

docker update --restart=no $NAME || true
docker stop $NAME || true
docker system prune -f
docker run -d -it --restart=always "${DOCKER_RUN_ARGS[@]}" --name $NAME $RUN_IMAGE:$VERSION "$@"

echo "To attach to container run 'docker attach $NAME'. To detach CTRL-P CTRL-Q."
[ "$DOCKER_ATTACH" != "true" ] || docker attach $NAME


