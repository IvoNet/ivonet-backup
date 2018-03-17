#!/usr/bin/env bash

. functions.sh

# Turn on the disk
diskon.sh

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