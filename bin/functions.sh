#!/usr/bin/env bash

export PATH=~/bin:$PATH

debug() {
    if [ "$DEBUG" == "1" ]; then
       echo "$@"
    fi
}

export backup_date="$(date +"%y-%m-%d")"

parse_yaml() {
   # syntax: parse_yaml path_to_yaml_file.yml [prefix]
   if [ -z "$2" ]; then
      local prefix="yml_"
   else
      local prefix=$2_
   fi
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

eval $(parse_yaml ./config/backup.yml "backup")
debug $(parse_yaml ./config/backup.yml "backup")

pre_slash() {
   if [ ${1:0:1} == "/" ]; then
       echo $1
   else
       echo /$1
   fi
}

do_scp() {
  echo "Copying $1 to remote $2"
#  scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $1 ${backup_endpoint_user}@${backup_endpoint_ip}:$2 2>&1 | grep -v "^Warning: Permanently added"
#  scp $1 ${backup_endpoint_user}@${backup_endpoint_ip}:$2 2>&1 | grep -v "^Warning: Permanently added"
  scp $1 ${backup_endpoint_user}@${backup_endpoint_ip}:$2
}

do_ssh() {
#  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${backup_endpoint_user}@${backup_endpoint_ip} -t $@ 2>&1 | grep -v "^Warning: Permanently added" | grep -v "Pseudo-terminal"
#  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${backup_endpoint_user}@${backup_endpoint_ip} -tt "$@"
  ssh -n ${backup_endpoint_user}@${backup_endpoint_ip} -t $@ 2>&1 | grep -v "Pseudo-terminal"
}

do_rsync() {
  rsync -tuavhP --partial-dir=.rsync $1 ${backup_endpoint_user}@${backup_endpoint_ip}:$2
}

do_backup() {
  echo "Backing up: $@"
  local PARAM="$(pre_slash "$@")"
  do_ssh mkdir -p "${backup_disk_mountpoint}${PARAM}"
  rsync -tuavhP --delete --partial-dir=.rsync "$@" ${backup_endpoint_user}@${backup_endpoint_ip}:"${backup_disk_mountpoint}${PARAM}" 2>&1 | grep -v "Permission denied"
#  rsync -tuavhP --delete --partial-dir=.rsync "$@" ${backup_endpoint_user}@${backup_endpoint_ip}:"${backup_disk_mountpoint}/$@"
}