#!/bin/sh -ex

SWD=$(dirname $0)
cd $SWD

for subnet in $HOST_SUBNETS; do
	sipcalc $subnet|egrep "Network address\s*-|Network mask\s*-"|cut -d- -f2- |xargs >> /tmp/net
done

[ ! -f /tmp/net ] && exit

while read network netmask; do
	line="push \"route $network $netmask\""
	grep -q "$line" /etc/openvpn/server/server.conf && continue
	echo "$line" >> /etc/openvpn/server/server.conf
done < /tmp/net

