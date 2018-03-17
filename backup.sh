#!/usr/bin/env bash

. ./bin/functions.sh

do_ssh bin/mount_backup_disk.sh

VOLUMES="./config/volumes.txt"

if [ -f ${VOLUMES} ]; then
    while IFS='' read -r line || [[ -n "$line" ]]; do
        if [ -z "$line" ]; then
            echo "Skipping empty line in volumes.txt"
        elif [[ ${line:0:1} == "#" ]] ; then
            echo "Skipping commented line: $line"
        else
            do_backup "$line"
        fi
    done < ${VOLUMES}

    do_ssh bin/umount_backup_disk.sh

else
    echo "Nothing to backup as there is not volumes.txt file..."
fi


