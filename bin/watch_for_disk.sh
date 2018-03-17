#!/usr/bin/env bash

. parse_yaml.sh
eval $(parse_yaml ~/config/application.yml "backup")

echo "$backup_watch_description"

inotifywait -m $TEST_DIR -e create |
    while read path action file; do
        echo "Processing: '$path$file'"
        if [ ${file} == "$backup_disk_uuid" ]
        then
            echo "$backup_watch_action_description"
            mount $backup_disk_mountpoint
        else
            echo "$backup_watch_action_not"
        fi
    done