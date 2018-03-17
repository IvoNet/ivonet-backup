#!/usr/bin/env bash

gpio mode 3 out
gpio -g write 22 1
sleep 1
gpio -g write 22 0