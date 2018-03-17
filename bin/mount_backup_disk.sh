#!/usr/bin/env bash

. ./bin/functions.sh

if [ "$(cat /etc/mtab|grep ${backup_disk_mountpoint} |wc -l)" == "1" ]; then
  exit 0
fi

# Turn on the disk
./bin/diskon.sh

echo "${backup_watch_description}"
inotifywait ${backup_watch_command} -e create |
    while read path action file; do
        echo "Mounting disk: '$file'"
        if [ ${file} == "${backup_disk_uuid}" ]
        then
            echo "${backup_watch_action_description_yes}"
            mount ${backup_disk_mountpoint}
        fi
    done