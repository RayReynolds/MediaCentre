# mono has issues due to expired certificates causing problems interacting with external apis

# ran this in the jail, but saw that the folder it updates is a symlink shared by all the jails. So this part could probably be done directly on FreeNAS
pkg install wget
wget -O - https://curl.haxx.se/ca/cacert.pem | cert-sync --user /dev/stdin

# backup old expired(?) certificates
sudo cp -R /usr/share/certs/trusted /usr/share/certs/trusted_orig

# Copy the new certificates
sudo cp -R /mnt/Volume_8/iocage/jails/jackett_1/root/root/.config/.mono/new-certs/Trust/ /usr/share/certs/trusted/

# fix file permissions
sudo chmod -R 755 ./trusted/

# restart your jail so new certificates are loaded. You should now be able to use api calls to the outside world
