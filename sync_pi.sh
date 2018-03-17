#!/usr/bin/env bash

SCP=( scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -r)
SSH=( ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no)

${SCP[@]} bin/setup.sh $1@$2:/home/$1/setup.sh 2>&1 | grep -v "^Warning: Permanently added"
${SSH[@]} $1@$2 -t sh ./setup.sh 2>&1 | grep -v "^Warning: Permanently added"
${SCP[@]} bin/* $1@$2:/home/$1/bin 2>&1 | grep -v "^Warning: Permanently added"
${SCP[@]} config/* $1@$2:/home/$1/config 2>&1 | grep -v "^Warning: Permanently added"
