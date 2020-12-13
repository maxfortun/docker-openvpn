#!/bin/sh -ex
SWD=$(dirname $0)

$SWD/configure_openvpn_certs_server.sh
$SWD/configure_openvpn_certs_client.sh -in
