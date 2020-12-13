#!/bin/sh

SWD=$(dirname $0)

$SWD/configure_openvpn_certs.sh

openvpn --config /etc/openvpn/server/server.conf

