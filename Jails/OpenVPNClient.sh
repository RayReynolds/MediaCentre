# https://www.reddit.com/r/truenas/comments/o9lvma/best_way_to_run_a_jail_through_vpn/
openvpn --cd /usr/local/etc/openvpn --config uk-lon-mp001.prod.surfshark.com_udp.ovpn --ping-restart 10 --verb 4
