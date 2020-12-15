#!/bin/sh -ex

if [ $(/bin/id -u) != "0" ]; then
	SUDO=/bin/sudo
fi

$SUDO /sbin/ip $*

