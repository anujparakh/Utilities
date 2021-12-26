PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Create Staging area
mkdir /tmp/staging;
cd ~;

# Zip it up with date
zipFile="/tmp/staging/College_Backup_$(date +'%Y_%b_%d-%H_%S').zip"
zip -er $zipFile Documents/College\ Documents/Eighth\ Semester -P "thisisaverylongcollegepassword";

rclone copy $zipFile Backups:/Backups/

# Remove staging area
sudo rm -rf /tmp/staging;

