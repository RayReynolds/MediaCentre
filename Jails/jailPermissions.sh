# Interactions between jails seem to have issues with file permissions that cause files to either not be seen or cannot be moved
# The easiest way around this is to make the media:media user owner of the services running in the jails.

# update the service to use the media user
export jail=qbittorrent_1
export server=qbittorrent
iocage exec $jail "service ${server} onestop"
iocage exec $jail "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec $jail "pw groupadd -n media -g 8675309"
iocage exec $jail "pw groupmod media -m ${jail}"
iocage exec $jail "find / -user ${server} -exec chown media:wheel {} \;"
iocage exec $jail  "sysrc '${server}_user=media'"

# look for any config files that need updating user information
# for example transmission
https://bipedu.wordpress.com/2019/12/06/correct-transmission-permissions-when-inside-freenas-jail/

iocage exec $jail "service ${server} start"
