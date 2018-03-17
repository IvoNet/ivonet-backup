#!/usr/bin/env bash

# include parse_yaml function
. functions.sh

diskon.sh

# Mount disk when ready
mount_backup_disk.sh

# Notify readyness to NAS
echo "Backup..."
sleep 2

## umount
echo "Unmounting the backup drive..."
umount ${backup_disk_mountpoint}

echo "Powering off the backup drive"
diskoff.sh