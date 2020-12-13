#!/bin/sh

SWD=$(dirname $0)
cd $SWD

for subnet in $OPENVPN_PRIVATE_SUBNETS; do
	sipcalc $subnet|egrep "Network address\s*-|Network mask\s*-"|cut -d- -f2- |xargs >> /tmp/net
done

[ ! -f /tmp/net ] && exit

while read network netmask; do
	echo push \"route $network $netmask\" >> /etc/openvpn/server/server.conf
done < /tmp/net

