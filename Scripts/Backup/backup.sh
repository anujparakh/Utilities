PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Create Staging area
mkdir /tmp/staging;

cd ~;
# Zip it up with date
zipFile="/tmp/staging/Backup_$(date +'%Y_%b_%d-%H_%S').zip"

zip -er $zipFile Documents --exclude Documents/Projects\** Documents/College\ Documents\** Documents/Tulika\** -P "averylongandsecurepasswordforbackups";

rclone copy $zipFile Backups:/Backups/;

# Remove staging area
sudo rm -rf /tmp/staging;

