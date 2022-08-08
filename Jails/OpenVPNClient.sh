# https://www.reddit.com/r/truenas/comments/o9lvma/best_way_to_run_a_jail_through_vpn/

# create a jail (get the commands for this).
# allow tun traffic
# UDP 1194 -> 1194
# TCP 9117 -> 9117

# TrueNAS console
sudo -i # we need to be root

# openvpn config files (additional settings)
#   auth-user-pass /usr/local/etc/openvpn/login.conf
#   route 192.168.0.0 255.255.255.0 net_gateway

mkdir -p /mnt/Volume_8/iocage/jails/jackett_openvpn/root/usr/local/etc/openvpn
cp -R /mnt/Volume_8/Misc/vpn_new/config/ /mnt/Volume_8/iocage/jails/jackett_openvpn/root/usr/local/etc/openvpn/


iocage console jackett_openvpn -f
pkg install -y openvpn nano

# not sure about this. tun0 or tun256 default(?)
ifconfig tun create

# Test
openvpn --cd /usr/local/etc/openvpn --config uk-lon-st003.prod.surfshark.com_tcp.ovpn --ping-restart 240 --verb 4

# make this config work every boot
nano /etc/rc.conf
# '''
openvpn_enable=YES #NO #YES
openvpn_configfile=/usr/local/etc/openvpn/uk-lon-st003.prod.surfshark.com_tcp.ovpn
openvpn_flags='--ping-restart 240 --verb 4 --log-append /var/log/openvpn.log'
rtsold_enable="YES"
ifconfig_epair0b_ipv6="inet6 auto_linklocal accept_rtadv autoconf"
# '''

# restart jail
iocage stop jackett_openvpn
iocage start jackett_openvpn

# test
ping 192.168.0.50
ping 1337x.to

