#!/bin/sh

SWD=$(dirname $0)
pushd $SWD

# Import our environment variables from systemd
while read e; do
	export "$e"
done < <(tr "\000" "\n" < /proc/1/environ)

for subnet in $OPENVPN_PRIVATE_SUBNETS; do
	read network netmask < <(sipcalc $subnet|egrep "Network address\s*-|Network mask\s*-"|cut -d- -f2- |xargs)
	echo push \"route $network $netmask\" >> server.conf
done
