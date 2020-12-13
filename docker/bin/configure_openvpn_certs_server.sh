#!/bin/sh -ex

if ls /etc/openvpn/server/server.key 2>&1; then
	echo "Using existing server configuration."
	exit
fi

cp -r /usr/share/easy-rsa /etc/openvpn/
cd /etc/openvpn/easy-rsa/

./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass

./easyrsa --batch gen-req server nopass
./easyrsa --batch sign-req server server

./easyrsa --batch gen-dh

./easyrsa --batch gen-crl

openvpn --genkey --secret ta.key

cp pki/ca.crt /etc/openvpn/server/
cp pki/ca.crt /etc/openvpn/client/

cp pki/dh.pem /etc/openvpn/server/
cp pki/crl.pem /etc/openvpn/server/

cp ta.key /etc/openvpn/server/
cp pki/issued/server.crt /etc/openvpn/server/
cp pki/private/server.key /etc/openvpn/server/


