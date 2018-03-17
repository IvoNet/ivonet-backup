#!/usr/bin/env bash
##############################################################################
## This script will setup the application
##############################################################################
# Do not forget to configure the config/application.yml file
##############################################################################
# include parse_yaml function
. ./bin/parse_yaml.sh
eval $(parse_yaml ./config/application.yml "backup")


if [ -z "${backup_endpoint_user}" ]; then
    echo "Do not forget to configure the config/application.yml file"
    exit 1
fi
if [ -z "${backup_endpoint_ip}" ]; then
    echo "Do not forget to configure the config/application.yml file"
    exit 1
fi

do_scp() {
  echo "Copying $1 to remote $2"
  scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $1 ${backup_endpoint_user}@${backup_endpoint_ip}:$2 2>&1 | grep -v "^Warning: Permanently added"
}

do_ssh() {
  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${backup_endpoint_user}@${backup_endpoint_ip} -t $@ 2>&1 | grep -v "^Warning: Permanently added" | grep -v "Pseudo-terminal"
}

do_scp setup/setup.sh /home/${backup_endpoint_user}/setup.sh
do_ssh sh ./setup.sh
do_scp "bin/*" /home/${backup_endpoint_user}/bin
do_scp "config/*" /home/${backup_endpoint_user}/config
