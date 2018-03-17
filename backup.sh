#!/usr/bin/env bash

. ./bin/functions.sh

do_ssh bin/mount_backup_disk.sh

while IFS='' read -r line || [[ -n "$line" ]]; do
    do_backup "$line"
done < "./config/volumes.txt"

#do_ssh bin/umount_backup_disk.sh