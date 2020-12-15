#!/bin/sh -ex

cat >> /etc/sysctl.conf <<_EOT_
net.ipv4.ip_forward = 1
net.ipv4.conf.all.proxy_arp = 1

_EOT_

