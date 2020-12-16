#!/bin/sh -ex

SWD=$(dirname $0)

action=$1
address=$2
type=$3

if [ -z "$address" ]; then
	exit
fi

echo $(date '+%Y-%m-%d %H:%M:%S') $*
env | sort | while read line; do echo $(date '+%Y-%m-%d %H:%M:%S') $address $line; done
 
case $action in
	add|update)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32"
		ip route del $address/32 || true
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route add $address/32 dev $dev"
		ip route add $address/32 dev $dev
	;;
	delete)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32"
		ip route del $address/32
	;;
	*)
	;;
esac
 
exit 0;
