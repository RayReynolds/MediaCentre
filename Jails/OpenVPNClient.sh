# https://www.reddit.com/r/truenas/comments/o9lvma/best_way_to_run_a_jail_through_vpn/

# create a jail.
# allow tun traffic... not sure what to do here

sudo -i # we need to be root
iocage console openvpn
nano /etc/rc.conf
cat /var/log/openvpn.log

openvpn --cd /usr/local/etc/openvpn --config uk-lon-mp001.prod.surfshark.com_udp.ovpn --ping-restart 10 --verb 4
