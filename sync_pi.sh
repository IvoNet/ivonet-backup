#!/usr/bin/env bash
##############################################################################
## This script will setup the application
##############################################################################
# Do not forget to configure the config/application.yml file
##############################################################################
# include parse_yaml function
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
do_scp "bin/*" /home/${backup_endpoint_user}/bin
do_scp "config/*" /home/${backup_endpoint_user}/config
