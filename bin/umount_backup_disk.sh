#!/usr/bin/env bash

. ./bin/functions.sh

if [ "$(cat /etc/mtab|grep ${backup_disk_mountpoint} |wc -l)" == "1" ]; then
  echo "Unmounting backup disk"
  umount ${backup_disk_mountpoint}
fi

diskoff.sh

