#!/bin/sh
name=client$1
[ -f /etc/openvpn/client/${name}.ovpn ] && exit

SWD=$(dirname $0)

cd /etc/openvpn/client

export OPENVPN_PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com || dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')
export OPENVPN_CA=$(cat ca.crt)
export OPENVPN_CERT=$(cat ${name}.crt)
export OPENVPN_KEY=$(cat ${name}.key)
export OPENVPN_TLS_AUTH=$(cat ta.key)

cat $SWD/client.ovpn.envsubst | envsubst > ${name}.ovpn
