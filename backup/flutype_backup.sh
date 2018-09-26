#!/bin/sh -x

# backup of all data from flutype server
TARGET=/media/mkoenig/USB_KOENIG/backup_server/

# SOURCE_LIST="/var/www /var/backups/flutypedb /var/backups/pkdb /usr/lib/systemd/system /var/# owncloud_data /var/letsencrypt /etc/nginx /home/mkoenig/envs /var/git"
# for SOURCE in $SOURCE_LIST; do 
#     sudo cp -R --delete $SOURCE $TARGET
# done


# 1. -a = recursive (recurse into directories), links (copy symlinks as symlinks), perms (preserve permissions), times (preserve modification times), group (preserve group), owner (preserve owner), preserve device files, and preserve special files.
# 2. -v = verbose. The reason I think verbose is important is so you can see exactly what rsync is backing up. Think about this: What if your hard drive is going bad, and starts deleting files without your knowledge, then you run your rsync script and it pushes those changes to your backups, thereby deleting all instances of a file that you did not want to get rid of?
# 3. –delete = This tells rsync to delete any files that are in Directory2 that aren’t in Directory1. If you choose to use this option, I recommend also using the verbose options, for reasons mentioned above.

sudo rsync -a --delete --progress /var/www $TARGET
sudo rsync -a --delete --progress /var/backups/flutypedb $TARGET
sudo rsync -a --delete --progress /var/backups/pkdb $TARGET
sudo rsync -a --delete --progress /usr/lib/systemd/system $TARGET
sudo rsync -a --delete --progress /var/owncloud_data $TARGET
sudo rsync -a --delete --progress /var/letsencrypt $TARGET
sudo rsync -a --delete --progress /etc/nginx $TARGET
sudo rsync -a --delete --progress /home/mkoenig/envs $TARGET
sudo rsync -a --delete --progress /var/git $TARGET


# rsync --progress source destination




