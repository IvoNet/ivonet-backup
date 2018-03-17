#!/usr/bin/env bash

export LOG="~/logs"
export BIN="~/bin"

# include parse_yaml function
. ${BIN}/parse_yaml.sh
eval $(${BIN}/parse_yaml ~/config/application.yml "backup")

# access yaml content
echo $backup_disk_name
echo $backup_disk_uuid

exec ${BIN}/watch_for_disk.sh </dev/null >>$LOG 2>&1 &