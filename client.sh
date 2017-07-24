#! /bin/bash
echo "deb http://shadowvpn.org/debian wheezy main">>/etc/apt/sources.list
apt-get update
apt-get install -y --force-yes  shadowvpn
sed -i "s/CONFFILE=\"\/etc\/shadowvpn\/server.conf\"/CONFFILE=\"\/etc\/shadowvpn\/client.conf\"/" "/etc/default/shadowvpn"
sudo update-rc.d shadowvpn disable
read -p "shadowvpn password: " password
sed -i "s/password=my_password/password=$password/" "/etc/shadowvpn/client.conf"
read -p "shadowvpn intf: " intf
sed -i "s/intf=tun0/intf=$intf/" "/etc/shadowvpn/client.conf"

#sed -i "s/ip route add   0\/1 dev \$intf//" "/etc/shadowvpn/client_up.sh"
#sed -i "s/ip route add 128\/1 dev \$intf/echo 'namesever 8.8.8.8' > \/etc\/reslov.conf/" "/etc/shadowvpn/client_up.sh"

#sed -i "s/ip route del   0\/1//" "/etc/shadowvpn/client_down.sh"
#sed -i "s/ip route del 128\/1/echo 'namesever 114.114.114.114' > \/etc\/reslov.conf/" "/etc/shadowvpn/client_down.sh"
cp -rf client_up.sh /etc/shadowvpn
cp -rf client_down.sh /etc/shadowvpn
cp -rf us_routes_up.sh /etc/shadowvpn
cp -rf us_routes_down.sh /etc/shadowvpn
/etc/init.d/shadowvpn restart
