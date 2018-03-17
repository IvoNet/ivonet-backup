#!/usr/bin/env bash
##############################################################################
## This script will setup the application
##############################################################################
# Do not forget to configure the config/application.yml file
##############################################################################
# include parse_yaml function
export DEBUG="1"
. ./bin/functions.sh

if [ -z "${backup_endpoint_user}" ]; then
    echo "Do not forget to configure the config/application.yml file"
    exit 1
fi
if [ -z "${backup_endpoint_ip}" ]; then
    echo "Do not forget to configure the config/application.yml file"
    exit 1
fi

do_scp setup/setup.sh /home/${backup_endpoint_user}/setup.sh
do_ssh sh ./setup.sh

do_rsync "bin/*" ./bin
do_rsync "config/*" ./config

do_ssh sh ./setup.sh
