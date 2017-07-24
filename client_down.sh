#!/bin/sh

# This script will be executed when client is down. All key value pairs (except
# password) in ShadowVPN config file will be passed to this script as
# environment variables.

# Turn off IP forwarding
#sysctl -w net.ipv4.ip_forward=0

# turn off NAT over VPN
iptables -t nat -D POSTROUTING -o $intf -j MASQUERADE
iptables -D FORWARD -i $intf -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -D FORWARD -o $intf -j ACCEPT

# Restore routing table
ip route del $server
. /etc/shadowvpn/us_routes_down.sh
echo 'namesever 114.114.114.114' > /etc/reslov.conf

echo $0 done
