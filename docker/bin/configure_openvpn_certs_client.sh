#!/bin/sh -ex
name=client$1

if ls /etc/openvpn/client/${name}.key 2>/dev/null; then
	echo "Using existing client configuration."
	exit
fi

cd /etc/openvpn/easy-rsa/

./easyrsa --batch gen-req $name nopass
./easyrsa --batch sign-req client $name

cp ta.key /etc/openvpn/client/

cp pki/issued/${name}.crt /etc/openvpn/client/
cp pki/private/${name}.key /etc/openvpn/client/


