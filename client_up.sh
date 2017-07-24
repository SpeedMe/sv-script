#!/bin/sh

# This script will be executed when client is up. All key value pairs (except
# password) in ShadowVPN config file will be passed to this script as
# environment variables.

# Turn on IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Configure IP address and MTU of VPN interface
ip addr add $net dev $intf
ip link set $intf mtu $mtu
ip link set $intf up

# Turn on NAT over VPN
iptables -t nat -A POSTROUTING -o $intf -j MASQUERADE
iptables -I FORWARD 1 -i $intf -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD 1 -o $intf -j ACCEPT

# Direct route to VPN server's public IP via current gateway
ip route add $server via $(ip route show 0/0 | sed -e 's/.* via \([^ ]*\).*/\1/')
. ./us_routes_up.sh
# Shadow default route using two /1 subnets

echo 'namesever 8.8.8.8' > /etc/reslov.conf

echo $0 done
