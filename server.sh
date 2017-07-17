#! /bin/bash
echo "deb http://shadowvpn.org/debian wheezy main">>/etc/apt/sources.list
apt-get update
apt-get install -y --force-yes  shadowvpn
read -p "shadowvpn password: " password
sed -i "s/password=my_password/password=$password/" "/etc/shadowvpn/server.conf"
read -p "shadowvpn intf: " intf
sed -i "s/intf=tun0/intf=$intf/" "/etc/shadowvpn/server.conf"
/etc/init.d/shadowvpn start
