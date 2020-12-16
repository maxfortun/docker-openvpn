#!/bin/sh -ex

serverIp=$(ip route get 8.8.8.8 | awk '{print $7}')
vpnIp=$(grep -o '^server [^ ]*' /etc/openvpn/server/server.conf|awk '{ print $2 }')

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


