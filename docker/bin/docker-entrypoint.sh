#!/bin/sh -ex

SWD=$(dirname $0)

$SWD/configure_openvpn_certs.sh
$SWD/push_private_routes.sh
$SWD/mkovpn.sh -in

[ ! -d /dev/net ] && mkdir -p /dev/net
[ ! -c /dev/net/tun ] && mknod /dev/net/tun c 10 200

cd /etc/openvpn/server

openvpn --config server.conf

