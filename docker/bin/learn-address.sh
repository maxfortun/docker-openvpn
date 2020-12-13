#!/bin/sh

SWD=$(dirname $0)

action=$1
address=$2
type=$3

if [ -z "$address" ]; then
	exit
fi

echo $(date '+%Y-%m-%d %H:%M:%S') $*
env | sort | xargs -L 1 echo $(date '+%Y-%m-%d %H:%M:%S') $address
 
case $action in
	add|update)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32"
				$SWD/unpriv-ip route del $address/32
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route add $address/32 dev $dev"
				$SWD/unpriv-ip route add $address/32 dev $dev
	;;
	delete)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32"
				$SWD/unpriv-ip route del $address/32
	;;
	*)
	;;
esac
 
exit 0;
