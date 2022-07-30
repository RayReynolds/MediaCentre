# Interactions between jails seem to have issues with file permissions that cause files to either not be seen or cannot be moved
# The easiest way around this is to make the media:media user owner of the services running in the jails.

# create media user and group
# update the service
# 
# Test this out
iocage exec sonarr  service sonarr onestop
iocage exec sonarr "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec sonarr "pw groupadd -n media -g 8675309"
iocage exec sonarr "pw groupmod media -m sonarr"
iocage exec sonarr  sysrc 'sonarr_user=media'

# this can be better, find all files and folders with certain ownership and flip it to media
iocage exec sonarr chown -R media:media /usr/local/share/NzbDrone /config

# try something like this:
find / -user tommy -exec chown peter {} \;
freenas% sudo iocage exec qbittorrent_1 "find / -user qbittorrent"


# find background info
# find will find all files that match a pattern:
find . -name "*foo"
# However, if you want a picture:
tree -P "*foo"


dump

iocage exec qbittorrent_1  service qbittorrent onestop
iocage exec qbittorrent_1 "pw user add media -c media -u 8675309 -d /nonexistent -s /usr/bin/nologin"
iocage exec qbittorrent_1 "pw groupadd -n media -g 8675309"
iocage exec qbittorrent_1 "pw groupmod media -m qbittorrent"
iocage exec qbittorrent_1 chown -R media:media /usr/local/share/NzbDrone /config
iocage exec qbittorrent_1  sysrc 'qbittorrent_user=media'
